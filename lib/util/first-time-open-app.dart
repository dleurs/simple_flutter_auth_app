import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:simple_flutter_auth_app/main.dart';
import 'package:simple_flutter_auth_app/models/state.dart';
import 'package:simple_flutter_auth_app/util/auth.dart';
import 'package:simple_flutter_auth_app/util/loading.dart';

class FirstTimeOpenApp extends StatelessWidget {
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
            AuthService().signInAnonymous();
            StateModel state = Provider.of<StateModel>(context);
            state.initUser();
            return BaseScaffold();
          } else {
            return BaseScaffold();
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

class LoadingPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Flutter App"),
        actions: [
          IconButton(
            icon: Icon(Icons.portrait),
            color: Colors.white,
            iconSize: 42.0,
            onPressed: () => null,
          ),
        ],
      ),
      body: LoadingScreen(
        child: Text("Welcome"),
        inAsyncCall: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: null,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[700],
        //showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text('Page 1'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Page 2'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center),
            title: Text('Page 3'),
          ),
        ],
      ),
    );
  }
}
