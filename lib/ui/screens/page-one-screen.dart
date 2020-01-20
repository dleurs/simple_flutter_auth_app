import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:simple_flutter_auth_app/models/state.dart';
import 'package:simple_flutter_auth_app/util/loading.dart';

class PageOneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateModel>(builder: (context, state, child) {
      return LoadingScreen(
          inAsyncCall: state.isLoading,
          child: Center(
            child: Column(
              children: <Widget>[
                Text("Page one"),
                Text(state.toString(),style: TextStyle(color: Colors.black.withOpacity(0.2))),
              ],
            ),
          ));
    });
  }
}
