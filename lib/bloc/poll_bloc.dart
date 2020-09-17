import 'package:bidders/bloc/base_bloc.dart';
import 'package:bidders/models/poll.dart';
import 'package:bidders/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class PollBloc extends BaseBloc {
  FirebaseFirestore firestore;
  FirebaseAuth firebaseAuth;

  PollBloc() {
    firestore = FirebaseFirestore.instance;
    firebaseAuth = FirebaseAuth.instance;
  }

  final _getPollsSuccessBS = BehaviorSubject<List<Poll>>();

  Stream<List<Poll>> get getPollsListStream => _getPollsSuccessBS.stream;

  @override
  void onDispose() {
    _getPollsSuccessBS.close();
  }

  /* CREATING POLL */
  Stream<DocumentReference> createPoll({
    String description,
    DateTime durationFromNow, //DateTime.now().add(DateTime(hours: 24))
    List<PollOption> options,
    String pollImage,
  }) {
    return firestore.collection('polls').add({
      'createdAt': DateTime.now(),
      'createdBy': getPollCreatorMap(),
      'description': description,
      'options': getOptionsFirestoreMapping(options),
      'endTime': durationFromNow,
      'image': pollImage
    }).asStream();
  }

  Map<String, dynamic> getOptionsFirestoreMapping(List<PollOption> pollOptions) {
    var map = <String, dynamic>{};
    for (int i = 0; i < pollOptions.length; i++) {
      map[i.toString()] = {'statement': pollOptions[i].statement, 'numberOfVotes': 0};
    }

    return map;
  }

  Map<String, dynamic> getPollCreatorMap() {
    return {
      'userId': firebaseAuth.currentUser.uid,
      'userImage': firebaseAuth.currentUser.photoURL,
      'userName': firebaseAuth.currentUser.displayName,
    };
  }

  /* VOTING ON A POLL */
  Future<Poll> voteOnAPoll(String pollId, int choice) async {
    await firestore.runTransaction((transaction) async {
      DocumentReference pollRef = firestore.collection('polls').doc(pollId);
      DocumentReference userRef = firestore.collection('users').doc(firebaseAuth.currentUser.uid);
      DocumentSnapshot snapshot = await transaction.get(pollRef);
      int currentVotersCount = snapshot.data()['options'][choice.toString()]['numberOfVotes'];
      transaction.update(pollRef, {
        'options.${choice.toString()}.numberOfVotes': currentVotersCount + 1,
        'options.${choice.toString()}.voters': FieldValue.arrayUnion([
          {
            'userId': firebaseAuth.currentUser.uid,
            'userImage': firebaseAuth.currentUser.photoURL,
            'userName': firebaseAuth.currentUser.displayName
          }
        ]),
      });
      transaction.update(userRef, {'votedPolls.${pollId}': choice});
    });

    var updatedPoll;
    await firestore
        .collection('polls')
        .doc(pollId)
        .get()
        .then((poll) => {updatedPoll = getPollFromDocumentData(poll, true)});

    return updatedPoll;
  }

  /* GET ALL POLLS DATA */
  Future<void> fetchAllPolls() async {
    final List<Poll> polls = [];
    await fetchUser(firebaseAuth.currentUser.uid).then((user) async {
          await firestore.collection('polls').get().then((querySnapshot) {
            querySnapshot.docs.forEach((document) {
              polls.add(getPollFromDocumentData(
                document,
                user.votedPolls.containsKey(document.id),
              ));
            });
          });
        });
    _getPollsSuccessBS.add(polls);
  }

  Poll getPollFromDocumentData(QueryDocumentSnapshot document, bool hasUserVoted) {
    final data = document.data();
    return Poll(
      id: document.id,
      createdAt: data['createdAt'].toDate(),
      description: data['description'],
      options: getPollOptions(data['options']),
      imageUrl: data['image'],
      user: PollCreator(
        userId: data['createdBy']['userId'],
        userImage: data['createdBy']['userImage'],
        userName: data['createdBy']['userName'],
      ),
      endTime: data['endTime'].toDate(),
      hasVoted: hasUserVoted,
    );
  }

  List<PollOption> getPollOptions(Map<String, dynamic> data) {
    final pollOptions = <PollOption>[];
    data.keys.forEach((key) {
      pollOptions.add(PollOption(
          statement: data[key]['statement'],
          numberOfVotes: data[key]['numberOfVotes'],
          pollVoters: getPollVoters(data[key]['voters'])));
    });
    return pollOptions;
  }

  List<PollVoter> getPollVoters(List<dynamic> data) {
    final pollVoters = <PollVoter>[];
    if(data == null) {
      return [];
    }
    List.from(data).forEach((voter) {
      pollVoters.add(PollVoter(
        userId: voter['userId'],
        userName: voter['userName'],
        userImage: voter['userImage'],
      ));
    });
    return pollVoters;
  }

  bool hasCurrentUserVoted(List<PollVoter> pollVoters) {
    final voter = pollVoters.firstWhere(
      (element) => element.userId == firebaseAuth.currentUser.uid,
      orElse: () => null,
    );

    return voter != null;
  }

  /* GET USER DATA */
  Future<AppUser> fetchUser(String userId) async {
    var user;
    await firestore.collection('users').doc(userId).get().then((document) => {
          user = AppUser(
            id: userId,
            email: document.data()['email'],
            image: document.data()['image'],
            votedPolls: document.data()['votedPolls'],
          )
        });

    return user;
  }
}
