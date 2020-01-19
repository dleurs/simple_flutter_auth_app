import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:simple_flutter_auth_app/models/settings.dart';
import 'package:simple_flutter_auth_app/models/user.dart';
import 'package:simple_flutter_auth_app/util/auth.dart';
import 'package:simple_flutter_auth_app/util/page-enum.dart';

class StateModel extends ChangeNotifier {
  bool isLoading;
  FirebaseUser firebaseUserAuth;
  User user;
  Settings settings;
  Page currentPage;
  Page previousPage;

  StateModel({
    this.isLoading = false,
    this.firebaseUserAuth,
    this.user,
    this.settings,
    this.currentPage = Page.pageOne,
    this.previousPage,
  });

  Future<Null> initUser() async {
    //print('...initUser...');
    FirebaseUser firebaseUserAuth = await AuthService.getCurrentFirebaseUser();
    User user = await AuthService.getUserLocal();
    //Settings settings = await AuthService.getSettingsLocal();

    this.isLoading = false;
    this.firebaseUserAuth = firebaseUserAuth;
    this.user = user;
    //this.state.settings = settings;
    notifyListeners();
  }

  void changePage(int toIndex) {
    this.previousPage = this.currentPage;
    this.currentPage = indexToPage(toIndex);
    notifyListeners();
  }

  void changePageToPrevious() {
    var temp = this.previousPage;
    this.previousPage = this.currentPage;
    this.currentPage = temp;
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
      res += "User.uid = " + this.user.userUid;
    } else {
      res += "User null";
    }
    return res;
  }
}
