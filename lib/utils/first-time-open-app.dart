import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:simple_flutter_auth_app/main.dart';
import 'package:simple_flutter_auth_app/models/state.dart';
import 'package:simple_flutter_auth_app/ui/widgets/loading.dart';

class FirstTimeOpenApp extends StatelessWidget {
  Widget child;
  FirstTimeOpenApp({@required this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _userAlreadyOpenApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error - return function userAlreadyOpenApp");
          } else if (!snapshot.hasData) {
            return LoadingPageScreen();
          } else if (snapshot.hasData && snapshot.data == false) {
            StateModel().signInAnonymous();
            return child;
          } else {
            return child;
          }
        });
  }
}

Future<bool> _userAlreadyOpenApp() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool _userAlreadyOpenApp = (prefs.getBool('userAlreadyOpenApp') ?? false);
  if (!_userAlreadyOpenApp) {
    prefs.setBool('userAlreadyOpenApp', true);
  }
  return (_userAlreadyOpenApp);
}

