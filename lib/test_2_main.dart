import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:simple_flutter_auth_app/models/state.dart';
import 'package:simple_flutter_auth_app/ui/screens/page-one-screen.dart';
import 'package:simple_flutter_auth_app/ui/screens/page-three-screen.dart';
import 'package:simple_flutter_auth_app/ui/screens/page-two-screen.dart';
import 'package:simple_flutter_auth_app/ui/screens/user-screen.dart';
import 'package:simple_flutter_auth_app/ui/transitions/slide_route.dart';
import 'package:simple_flutter_auth_app/util/loading.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<StateModel>(create: (context) => StateModel()),
        ],
        child: BaseScaffold(),
      ),
    );
  }
}

class BaseScaffold extends StatefulWidget {
  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  int index = 0;
  int previousIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();

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
    UserScreen(
      key: PageStorageKey('User page'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Flutter App"),
        centerTitle: true,
        leading: (this.index >= 3)
            ? IconButton(
                icon: Icon(Icons.chevron_left),
                color: Colors.white,
                iconSize: 44.0,
                onPressed: () => setState(() {
                  this.index = this.previousIndex;
                }),
              )
            : null,
        actions: [
          IconButton(
              icon: Icon(Icons.portrait),
              color: Colors.white,
              iconSize: 42.0,
              //onPressed: () => setState(() { this.previousIndex = this.index; this.index = 3;}),
              onPressed: () {
                this.index = 4;
                Navigator.push(
                    context,
                    SlideTopRoute(
                      page: UserScreen(
                        key: PageStorageKey('User page'),
                      ),
                    ));
              }),
        ],
      ),
      body: PageStorage(
        child: pages[this.index],
        bucket: this.bucket,
      ),
      bottomNavigationBar: (this.index <= 2)
          ? BottomNavigationBar(
              currentIndex: this.index,
              onTap: (int inputIndex) {
                setState(() => this.index = inputIndex);
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
            )
          : null,
    );
  }
}
