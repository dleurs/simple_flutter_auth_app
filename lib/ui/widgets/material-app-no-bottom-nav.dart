import 'package:flutter/material.dart';

class MaterialAppNoBottomNav extends StatelessWidget {
  Widget child;
  PageStorageBucket bucket;

  MaterialAppNoBottomNav({@required this.child, @required this.bucket});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
          child: child,
          bucket: this.bucket,
        ),
      ),
    );
  }
}
