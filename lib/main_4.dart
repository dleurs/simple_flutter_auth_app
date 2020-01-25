import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Cupertino Tab Bar Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: SafeArea(
          child: MyHomePage(title: 'Cupertino Tab Bar Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
              title: Text('Tab 1'), icon: Icon(Icons.ac_unit)),
          BottomNavigationBarItem(
              title: Text('Tab 2'), icon: Icon(Icons.ac_unit)),
          BottomNavigationBarItem(
              title: Text('Tab 3'), icon: Icon(Icons.ac_unit)),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return Column(children: [Text('Page 1')]);
          case 1:
            return Text('Page 2');
          case 2:
            return Text('Page 3');
        }
      },
    );
  }
}