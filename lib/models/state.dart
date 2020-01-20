import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:simple_flutter_auth_app/models/settings.dart';
import 'package:simple_flutter_auth_app/models/user.dart';
import 'package:simple_flutter_auth_app/util/auth.dart';

class StateModel extends ChangeNotifier {
  bool isLoading;
  FirebaseUser firebaseUserAuth;
  User user;
  Settings settings;

  StateModel({
    this.isLoading = false,
    this.firebaseUserAuth,
    this.user,
    this.settings,
  });

  void switchLoading() {
    this.isLoading = !this.isLoading;
    notifyListeners();
  }

  void updateStateModel(FirebaseUser firebaseUserAuthInput, User userInput) {
    this.firebaseUserAuth = firebaseUserAuthInput;
    this.user = userInput;
    notifyListeners();
  }

  String toString() {
    String res = "";
    if (this.firebaseUserAuth != null) {
      res += "firebaseUserAuth.uid = " + this.firebaseUserAuth.uid;
    } else {
      res += "firebaseUserAuth is null.";
    }
    if (this.user != null) {
      res += "User.uid = " + this.user.uid;
    } else {
      res += "User null";
    }
    return res;
  }
}
