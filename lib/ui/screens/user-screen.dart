import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_flutter_auth_app/models/state.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateModel>(builder: (context, state, child) {
      return Center(
        child: Column(
          children: <Widget>[
            Text("User Page"),
            Text(state.toString()),
          ],
        ),
      );
    });
  }
}
