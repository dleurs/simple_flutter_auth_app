import 'package:flutter/material.dart';
import 'package:simple_flutter_auth_app/ui/screens/user-screen.dart';

/*
class UserScaffoldNoBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
*/

class UserScaffoldNoBottomNav extends StatefulWidget {
  //final Widget child; = UserScreen(key: PageStorageKey('PageUser'),),
  //final String title; = "User"
  final PageStorageBucket bucket;

  // UserScaffoldNoBottomNav({@required this.child, @required this.title, @required this.bucket});
  UserScaffoldNoBottomNav({@required this.bucket});

  @override
  _UserScaffoldNoBottomNavState createState() =>
      _UserScaffoldNoBottomNavState();
}

class _UserScaffoldNoBottomNavState extends State<UserScaffoldNoBottomNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.clear),
          color: Colors.white,
          iconSize: 36.0,
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),
      body: PageStorage(
        child: UserScreen(
          key: PageStorageKey('PageUser'),
        ),
        bucket: widget.bucket,
      ),
    );
  }
}
