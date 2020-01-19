import "package:firebase_auth/firebase_auth.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:simple_flutter_auth_app/models/user.dart';

class AuthService {
  static Future addUserDB(User user) async {
    checkUserExist(user.userUid).then((value) {
      if (!value) {
        print("user ${user.userUid} ${user.email} added");
        Firestore.instance
            .document("users/${user.userUid}")
            .setData(user.toJson());
        //_addSettings(new Settings(
        //  settingsId: user.userId,
        //));
      } else {
        print("user ${user.userUid} exists");
      }
    });
  }

  static Future<bool> checkUserExist(String userUid) async {
    bool exists = false;
    try {
      await Firestore.instance.document("users/$userUid").get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  // sign in anon
  Future signInAnonymous() async {
    //await FirebaseAuth.instance.signInAnonymously();
    AuthResult result = await FirebaseAuth.instance.signInAnonymously();
    FirebaseUser firebaseUser = result.user;
    User user = User(userUid: firebaseUser.uid);
    await addUserDB(user);
    await storeUserLocal(user);
    //return result.user.uid;
  }

  static Future<FirebaseUser> getCurrentFirebaseUser() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    return currentUser;
  }

  static Future<String> storeUserLocal(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storeUser = userToJson(user);
    await prefs.setString('user', storeUser);
    return user.userUid;
  }

  static Future<User> getUserLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      User user = userFromJson(prefs.getString('user'));
      //print('USER: $user');
      return user;
    } else {
      return null;
    }
  }
}
