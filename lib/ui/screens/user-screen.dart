import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_flutter_auth_app/models/state.dart';
import 'package:simple_flutter_auth_app/util/auth.dart';
import 'package:simple_flutter_auth_app/util/loading.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool register0SignIn1 = false;

  void _switchRegisterSignIn() {
    setState(() {
      register0SignIn1 = !register0SignIn1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buildMenu(StateModel state) {
      List<Widget> builder = [];

      if (state.user != null) {
        builder.add(Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 0.0),
          child: Text("Hello"),
        ));
        if (state.user.isAnonymous) {
          builder.add(Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
            child: Text("Anonymous user",
                style: TextStyle(
                  fontSize: 24.0,
                )),
          ));
        }
        builder.add(RaisedButton(
          onPressed: () async {
            state.switchLoading();
            await AuthService(state:state).signOut();
            state.switchLoading();
          },
          child: Text('Logout'),
        ));
      } else {
        builder.add(Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 18.0, 8.0, 8.0),
          child: Text("You are not connected",
              style: TextStyle(
                fontSize: 20.0,
              )),
        ));

        builder.add(RaisedButton(
          onPressed: () async {
            state.switchLoading();
            await AuthService(state:state).initState();
            state.switchLoading();
          },
          child: Text('Refresh local data'),
        ));

        builder.add(FlatButton(
          onPressed: () => _switchRegisterSignIn(),
          child: register0SignIn1
              ? Text(
                  'Don\'t have an account ? Register',
                  style: TextStyle(color: Colors.black54),
                )
              : Text(
                  'Have an Account ? Sign In',
                  style: TextStyle(color: Colors.black54),
                ),
        ));

        builder.add(
          FlatButton(
            onPressed: () async {
              state.switchLoading();
              await AuthService(state:state).signInAnonymous();
              state.switchLoading();
            },
            child: Text(
              'Anonymous log in',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        );
      }
      /*
      // Test Loading
      builder.add(
        RaisedButton(
          onPressed: () {
            state.switchLoading();
          },
          child: Text('Test loading'),
        ),
      );
      */
      // Test Anonymous sign up/in
      builder.add(Text(state.toString(),
          style: TextStyle(color: Colors.black.withOpacity(0.2))));
      return builder;
    }

    return Consumer<StateModel>(builder: (context, state, child) {
      return LoadingScreen(
          inAsyncCall: state.isLoading,
          child: Center(
            child: Column(
              children: buildMenu(state),
            ),
          ));
    });
  }
}
