import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:simple_flutter_auth_app/models/state.dart';
import 'package:simple_flutter_auth_app/ui/screens/user-screen.dart';
import 'package:simple_flutter_auth_app/util/page-enum.dart';

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
      home: ChangeNotifierProvider<StateModel>(
        create: (context) => StateModel(),
        child: BaseScaffold(),
      ),
    );
  }
}

class BaseScaffold extends StatelessWidget {
  void changePage(int index, BuildContext context) {
    StateModel state = Provider.of<StateModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    
    
    StateModel state = Provider.of<StateModel>(context);
    
    
    if (state.currentPage != Page.user) {
      return Scaffold(
        appBar: AppBar(
          title: Text("My Flutter App"),
          actions: [
            IconButton(
              icon: Icon(Icons.portrait),
              color: Colors.white,
              iconSize: 42.0,
              onPressed: () => state.changePage(10),
            ),
          ],
        ),
        body: pageToWidget(state.currentPage),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageToIndex(state.currentPage),
          onTap: state.changePage,
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


    else { // state.currentPage == Page.user
      return Scaffold(
        appBar: AppBar(
          title: Text("My Flutter App"),
          leading: IconButton(
              icon: Icon(Icons.chevron_left),
              color: Colors.white,
              iconSize: 44.0,
              onPressed: () => state.changePageToPrevious(),
            ),
        ),
        body: pageToWidget(state.currentPage),
      );
    }
  }
}
