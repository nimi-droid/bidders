import 'package:bidders/bloc/base_bloc.dart';
import 'package:bidders/models/poll.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PollBloc extends BaseBloc {
  FirebaseFirestore firestore;

  PollBloc() {
    firestore = FirebaseFirestore.instance;
  }

  /* CREATING POLL */
  void createPoll(
      String title, DateTime durationFromNow, List<PollOption> options, String pollImage) {
    firestore.collection('polls').add({
      'createdAt': DateTime.now(),
      'createdBy': getPollCreatorMap(),
      'description': title,
      'options': getOptionsFirestoreMapping(options),
      'endTime': durationFromNow,
      'image': pollImage
    });
  }

  Map<String, dynamic> getOptionsFirestoreMapping(List<PollOption> pollOptions) {
    var map = <String, dynamic>{};
    for (int i = 0; i < pollOptions.length; i++) {
      map[i.toString()] = {'statement': pollOptions[i].statement, 'numberOfVotes': 0};
    }

    return map;
  }

  Map<String, dynamic> getPollCreatorMap() {
    //TODO: This info will belong to the creator of the poll i.e. current user
    return {
      'userId' : 'Solid IDS',
      'userImage' : '',
      'userName' : 'Anthony'
    };
  }

  /* VOTING ON A POLL */
  void voteOnAPoll(String pollId, int choice) {
    firestore.collection('polls').doc("uolH3QCy2G8LMW4ht7zi").update({
      "voters": FieldValue.arrayUnion([
        {
          "choice": choice,
          "userId": "SomeRandomUserId",
          "userImage": "link of image here",
          "userName": "Waddup Boisss"
        }
      ]),
    });

    firestore.runTransaction((transaction) async {
      DocumentReference pollRef = firestore.collection('polls').doc("uolH3QCy2G8LMW4ht7zi");
      DocumentSnapshot snapshot = await transaction.get(pollRef);
      int currentVotersCount = snapshot.data()['options'][choice.toString()]['numberOfVotes'];
      await transaction
          .update(pollRef, {'options.${choice.toString()}.numberOfVotes': currentVotersCount + 1});
    });
  }

  /* GET ALL POLLS DATA */
  List<Poll> fetchAllPolls() {
    List<Poll> polls = List();
    firestore.collection('polls').get().then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        polls.add(getPollFromDocumentData(document.data()));
      });
    });
    return polls;
  }

  Poll getPollFromDocumentData(Map<String, dynamic> data) {
    var poll = Poll(
        createdAt: data["createdAt"].toDate(),
        description: data["description"],
        options: getPollOptions(data['options']),
        imageUrl: data["image"],
        user: PollCreator(
          userId: data['createdBy']['userId'],
          userImage: data['createdBy']['userImage'],
          userName: data['createdBy']['userName'],
        ),
        endTime: data["endTime"].toDate(),
        voters: getPollVoters(data['voters']));
    return poll;
  }

  List<PollOption> getPollOptions(Map<String, dynamic> data) {
    final pollOptions = <PollOption>[];
    data.keys.forEach((key) {
      pollOptions.add(PollOption(
        statement: data[key]["statement"],
        numberOfVotes: data[key]["numberOfVotes"],
      ));
    });
    return pollOptions;
  }

  List<PollVoter> getPollVoters(List<dynamic> data) {
    final pollVoters = <PollVoter>[];
    List.from(data).forEach((voter) {
      pollVoters.add(PollVoter(
        choice: voter['choice'],
        userId: voter['userId'],
        userName: voter['userName'],
        userImage: voter['userImage'],
      ));
    });
    return pollVoters;
  }
}
