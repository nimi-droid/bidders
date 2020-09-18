import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'base_bloc.dart';

class LoginBloc extends BaseBloc {
  FirebaseFirestore firestore;

  LoginBloc() {
    firestore = FirebaseFirestore.instance;
  }

  Future<dynamic> saveUserToFireStore(User user, String accessToken, String idToken) async {
    /*await firestore.collection('polls').get().then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        polls.add(getPollFromDocumentData(
          document,
          user.votedPolls?.containsKey(document.id) ?? false,
        ));
      });
    });*/
    bool userExists = false;
    await firestore.collection('users').get().then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        if (document.id == user.uid) {
          userExists = true;
        }
      });
    });
    if (!userExists)
      return firestore.collection('users').doc(user.uid).set({
        'name': user.displayName,
        'email': user.email,
        'image': user.photoURL,
        'phoneNumber': user.phoneNumber,
        'accessToken': accessToken,
        'idToken': idToken,
        'votedPolls': {},
      });
    return true;
  }
}
