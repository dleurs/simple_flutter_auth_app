import 'package:flutter/material.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
      text: 'sample text: ${widget.child}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return new MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            /*return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  widget.child,
                  SizedBox(height: 16.0),
                  RaisedButton(
                    child: Text('push a route'),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) {
                          */return 
                          Scaffold(
                            appBar: AppBar(
                                title: Text('Route for ${widget.child}')),
                            body:
                                ListView.builder(itemBuilder: (context, index) {
                              return ListTile(
                                title: Text('Lorem Ipsum'),
                                subtitle: Text('$index'),
                              );
                            }), /*Container(
                              padding: const EdgeInsets.all(16.0),
                              alignment: Alignment.center,
                              child: TextField(controller: _textController), 
                            ),*/
                          ); /*
                        },
                      ));
                    },
                  ),
                ],
              ),
            );*/
          },
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _pageIndex,
          children: const <Widget>[
            NavigatorPage(child: Text('Home')),
            NavigatorPage(child: Text('Business')),
            NavigatorPage(child: Text('School')),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), title: Text('Business')),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), title: Text('School')),
        ],
        currentIndex: _pageIndex,
        onTap: (int index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: HomePage()));
}
