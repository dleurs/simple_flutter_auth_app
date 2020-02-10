import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:simple_flutter_auth_app/models/state.dart';
import 'package:simple_flutter_auth_app/ui/widgets/loading.dart';

class PageThreeScreen extends StatelessWidget {
  const PageThreeScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<StateModel>(builder: (context, state, child) {
      print("Page three " + state.toString()); // To check if there is not loop, consumer build one time 
      return LoadingScreen(
        inAsyncCall: state.isLoading,
        child: ListView.builder(itemBuilder: (context, index) {
         if (index == 0) {
            return ListTile(
              title: Text("Page three"),
              subtitle: Text(state.toString()),
            );
          }
          else if (index < 20) {
            return ListTile(
              title: Text('Lorem Ipsum'),
              subtitle: Text('$index'),
            );
          }
        }),
      );
    });
  }
}
