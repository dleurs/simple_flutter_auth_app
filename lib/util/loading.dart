import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final Offset offset;
  final bool dismissible;
  final Widget child;

  LoadingScreen({
    Key key,
    @required this.inAsyncCall,
    this.opacity = 0.7,
    this.color = Colors.white,
    this.progressIndicator = const CircularProgressIndicator(),
    this.offset,
    this.dismissible = false,
    @required this.child,
  })  : assert(child != null),
        assert(inAsyncCall != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (inAsyncCall) {
      Widget layOutProgressIndicator;
      if (offset == null) {
        layOutProgressIndicator = Center(
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  //color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                //need this due to bug...https://github.com/flutter/flutter/issues/18399
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    child: SpinKitCircle(
                      color: Colors.blue,
                      size: 80.0,
                    ),
                    height: 80.0,
                    width: 80.0,
                  ),
                )));
      } else {
        layOutProgressIndicator = Positioned(
          child: progressIndicator,
          left: offset.dx,
          top: offset.dy,
        );
      }
      final modal = [
        new Opacity(
          child: new ModalBarrier(dismissible: dismissible, color: color),
          opacity: opacity,
        ),
        layOutProgressIndicator
      ];
      widgetList += modal;
    }
    return new Stack(
      children: widgetList,
    );
  }
}

class LoadingPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Flutter App"),
        centerTitle: true,
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

/*
class LoadingNoModalBarrier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitCircle(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
    );
  }
}
*/
