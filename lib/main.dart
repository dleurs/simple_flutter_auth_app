import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:simple_flutter_auth_app/models/state.dart';
import 'package:simple_flutter_auth_app/ui/screens/page-one-screen.dart';
import 'package:simple_flutter_auth_app/ui/screens/page-three-screen.dart';
import 'package:simple_flutter_auth_app/ui/screens/page-two-screen.dart';
import 'package:simple_flutter_auth_app/ui/widgets/loading.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_flutter_auth_app/ui/widgets/user-scaffold-no-bottom-nav.dart';

void main() => runApp(InitStateModel(/*MyApp()*/));
// InitStateModel returns MyApp after initilisation
// initialisation : new users are anonymously sign in StateModel().signInAnonymous()
// and current user information are loaded StateModel().initState()

class MyApp extends StatelessWidget {
  final StateModel stateAlreadySet;
  MyApp({this.stateAlreadySet});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StateModel>(
      create: (context) => (stateAlreadySet == null)
          ? StateModel()
          : StateModel(
              fireUser: stateAlreadySet.fireUser,
              userInfo: stateAlreadySet.userInfo),
      child: MaterialApp(
          title: 'My Flutter App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          //home: BaseScaffold(),
          routes: {
            '/': (context) => BaseScaffold(),
            '/userPage': (context) => UserScaffoldNoBottomNav(bucket: Provider.of<StateModel>(context,listen: false).bucket), 
            // bucket is used to save scrool state. No need for BaseScaffold but necessary for USerPage, don't know why
          }),
    );
  }
}

class BaseScaffold extends StatefulWidget {
  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  int pageIndex = 0;

  final List<Widget> pages = [
    PageOneScreen(
      key: PageStorageKey('Page1'),
    ),
    PageTwoScreen(
      key: PageStorageKey('Page2'),
    ),
    PageThreeScreen(
      key: PageStorageKey('Page3'),
    ),
  ];

  final List<String> titles = [
    "Page one",
    "Page two",
    "Page three",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(titles[pageIndex]),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.portrait),
                color: Colors.white,
                iconSize: 42.0,
                onPressed: () {
                  Navigator.pushNamed(context, '/userPage');
                }),
          ],
        ),
        body: pages[this.pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: this.pageIndex,
          onTap: (int indexInput) {
            setState(() => this.pageIndex = indexInput);
          },
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
        ));
  }
}

class InitStateModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: userAlreadyOpenApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error - return function userAlreadyOpenApp");
            return MyApp();
          } else if (!snapshot.hasData) {
            return LoadingPageScreen();
          } else if (snapshot.hasData && snapshot.data == false) {
            return FutureBuilder<StateModel>(
                future: StateModel().signInAnonymous(),
                builder: (context, shapshotState) {
                  if (shapshotState.hasError) {
                    return Text("Error - signInAnonymous");
                  } else if (!shapshotState.hasData) {
                    return LoadingPageScreen();
                  } else {
                    StateModel state = shapshotState.data;
                    return MyApp(stateAlreadySet: state);
                  }
                });
          } else {
            return FutureBuilder<StateModel>(
                future: StateModel().initState(),
                builder: (context, shapshotStateInit) {
                  if (shapshotStateInit.hasError) {
                    print("Error - initState");
                    return MyApp();
                  } else if (!shapshotStateInit.hasData) {
                    return LoadingPageScreen();
                  } else {
                    StateModel state = shapshotStateInit.data;
                    return MyApp(stateAlreadySet: state);
                  }
                });
          }
        });
  }

  Future<bool> userAlreadyOpenApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _userAlreadyOpenApp = (prefs.getBool('userAlreadyOpenApp') ?? false);
    if (!_userAlreadyOpenApp) {
      prefs.setBool('userAlreadyOpenApp', true);
    }
    return (_userAlreadyOpenApp);
  }
}
