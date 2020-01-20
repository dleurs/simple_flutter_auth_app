import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:simple_flutter_auth_app/main.dart';
import 'package:simple_flutter_auth_app/models/pageNavigator.dart';
import 'package:simple_flutter_auth_app/models/state.dart';
import 'package:simple_flutter_auth_app/models/user.dart';
import 'package:simple_flutter_auth_app/util/auth.dart';
import 'package:simple_flutter_auth_app/util/loading.dart';
import 'package:simple_flutter_auth_app/util/store-local.dart';

class FirstTimeOpenApp extends StatelessWidget {
  Widget child;

  FirstTimeOpenApp({this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StateModel>(
        future: stateModelBuilder(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error - return function stateModelBuilder");
          } else if (!snapshot.hasData) {
            return LoadingPageScreen();
          } else {
            return child;
          }
        });
  }
}

Future<StateModel> stateModelBuilder() async {
  FirebaseUser firebaseUserAuth = await FirebaseAuth.instance.currentUser();
  User user = await StoreLocal().getUserLocal();
  StateModel state = StateModel(firebaseUserAuth: firebaseUserAuth, user: user);
  return state;
}
