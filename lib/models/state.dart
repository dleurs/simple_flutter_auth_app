import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:simple_flutter_auth_app/models/settings.dart';
import 'package:simple_flutter_auth_app/models/user.dart';
import 'package:simple_flutter_auth_app/services/database.dart';
import 'package:simple_flutter_auth_app/services/store-local.dart';

class StateModel extends ChangeNotifier {
  bool isLoading;
  FirebaseUser fireUser;
  User userInfo;
  final PageStorageBucket bucket = PageStorageBucket();

  StateModel({
    this.isLoading = false,
    this.fireUser,
    this.userInfo,
  }) {
    print("1. State model constructor, " + this.toString());
  }

  void setIsLoading(bool isLoadingInput) {
    this.isLoading = isLoadingInput;
    notifyListeners();
  }

  void updateStateModel(FirebaseUser fireUserInput, User userInfoInput) {
    this.fireUser = fireUserInput;
    this.userInfo = userInfoInput;
    notifyListeners();
  }

  // init
  Future<StateModel> initState() async {
    FirebaseUser fireUser = await FirebaseAuth.instance.currentUser();
    User user = await StoreLocal().getUserLocal();
    this.updateStateModel(fireUser, user);
    print("2. State model initialization, " + this.toString());
    return this;
  }

  Future<StateModel> signInAnonymous() async {
    FirebaseUser fireUser =
        (await FirebaseAuth.instance.signInAnonymously()).user;
    await DatabaseService(uid: fireUser.uid).updateUserDataAnonymous();
    this.updateStateModel(fireUser, null);
    print("3. State model sign in anonymously, " + this.toString());
    return this;
  }

  // sign out
  Future signOut() async {
    await StoreLocal().deleteUserLocal();
    await FirebaseAuth.instance.signOut();
    this.updateStateModel(null, null);
  }

  String toString() {
    String res = "";
    if (fireUser != null) {
      res += "uid:" + fireUser.uid;
    } else {
      res += "User null";
    }
    return res;
  }
}
