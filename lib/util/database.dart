import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:simple_flutter_auth_app/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({@required this.uid});

  Future<User> getUser() {
    return Firestore.instance
        .collection('users')
        .document(uid)
        .get().then((doc) => User.fromDocument(doc));
  }

  Future<void> updateUserData({@required String pseudo, @required String email}) async {
    return await Firestore.instance.collection('users').document(uid).setData({
      'uid': uid,
      'isAnonymous': false,
      'pseudo': pseudo,
      'email': email,
      'dateRegister': DateTime.now(),
    });
    //FirebaseAuth
  }

  Future<void> updateUserDataAnonymous() async {
    return await Firestore.instance.collection('users').document(uid).setData({
      'uid': uid,
      'isAnonymous': true,
      'dateAnonymousRegister': DateTime.now(),
    });
    //FirebaseAuth
  }

  Future<Map<String, dynamic>> getUserFirestore() async {
    if (uid != null) {
      return Firestore.instance
          .collection('users')
          .document(uid)
          .get()
          .then((documentSnapshot) => documentSnapshot.data);
    } else {
      print('firestore user uid can not be null');
      return null;
    }
  }
}
