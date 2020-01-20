import "package:firebase_auth/firebase_auth.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_flutter_auth_app/models/state.dart';
import 'package:flutter/foundation.dart';

import 'package:simple_flutter_auth_app/models/user.dart';
import 'package:simple_flutter_auth_app/util/database.dart';
import 'package:simple_flutter_auth_app/util/store-local.dart';

class AuthService {
  StateModel state;
  AuthService({@required this.state});

  // sign in anon
  Future signInAnonymous() async {
    FirebaseUser firebaseUser = (await FirebaseAuth.instance.signInAnonymously()).user;
    User user = User(uid: firebaseUser.uid, isAnonymous: true);
    await StoreLocal().storeUserLocal(user);
    await DatabaseService(uid:firebaseUser.uid).updateUserDataAnonymous();
    state.updateStateModel(firebaseUser, user);
  }

  // sign out
  Future signOut() async {
    await StoreLocal().deleteUserLocal();
    await FirebaseAuth.instance.signOut();
    state.updateStateModel(null, null);
  }

  // init
  Future initState() async {
    FirebaseUser firebaseUserAuth = await FirebaseAuth.instance.currentUser();
    User user = await StoreLocal().getUserLocal();
    state.updateStateModel(firebaseUserAuth, user);
  }

}
