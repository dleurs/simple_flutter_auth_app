import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:simple_flutter_auth_app/models/state.dart';
import 'package:simple_flutter_auth_app/util/loading.dart';

class PageOneScreen extends StatelessWidget {
  const PageOneScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StateModel>(builder: (context, state, child) {
      return LoadingScreen(
        inAsyncCall: state.isLoading,
        child: ListView.builder(itemBuilder: (context, index) {
          if (index == 0) {
            return ListTile(
              title: Text("Page one"),
              subtitle: Text(state.toString()),
            );
          }
          else {
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
