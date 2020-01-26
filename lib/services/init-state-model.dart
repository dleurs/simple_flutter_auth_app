import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:simple_flutter_auth_app/models/state.dart';
//import 'package:simple_flutter_auth_app/ui/widgets/loading.dart';

class InitStateModel extends StatelessWidget {
  final Widget child;

  InitStateModel({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<StateModel>(builder: (context, state, child) {
      return FutureBuilder<bool>(
          future: _userAlreadyOpenApp(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error - return function userAlreadyOpenApp");
            // } else if (!snapshot.hasData) {
            //  return LoadingPageScreen();
            } else if (snapshot.hasData && snapshot.data == false) {
              state.signInAnonymous();
              state.initState();
              return this.child;
            } else {
              state.initState();
              return this.child;
            }
          });
    });
  }
}

Future<bool> _userAlreadyOpenApp() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool _userAlreadyOpenApp = (prefs.getBool('userAlreadyOpenApp') ?? false);
  if (!_userAlreadyOpenApp) {
    prefs.setBool('userAlreadyOpenApp', true);
    print("First time users open app");
  }
  return (_userAlreadyOpenApp);
}
