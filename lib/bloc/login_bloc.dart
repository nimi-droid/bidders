

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'base_bloc.dart';

class LoginBloc extends BaseBloc {
  FirebaseFirestore firestore;

  LoginBloc() {
    firestore = FirebaseFirestore.instance;
  }

  void saveUserToFireStore(User user, String accessToken, String idToken) {
    firestore.collection('users').doc(user.uid).set({
      'name': user.displayName,
      'email': user.email,
      'image': user.photoURL,
      'phoneNumber': user.phoneNumber,
      'accessToken': accessToken,
      'idToken': idToken,
    }).then((_) {});
  }
}