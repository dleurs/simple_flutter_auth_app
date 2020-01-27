# simple_flutter_auth_app

A simple flutter auth app with a BottomNavigationBar, anonymous log in when the app open and state management with ChangeNotifierProvider.

![](screenshots/app_presentation.gif)

A lot of element is taken from from https://github.com/delay/flutter_firebase_auth_example, with modification (coming soon) :  
- username (instead of first/last name)
- anonymous sign in when user open the app for the first time
- The state management will be modified, from InheritedWidget to ChangeNotifierProvider

If you want the same project but with a Drawer, go to :
 - https://github.com/dleurs/simple_flutter_auth_app_drawer

## Getting Started

In order to make this app working after a git clone, you will have to setup a Firebase.
Steps on https://codelabs.developers.google.com/codelabs/flutter-firebase/index.html#6

0. Make sure "$ flutter doctor -v" don't reveal errors
1. $ git clone https://github.com/dleurs/simple_flutter_auth_app.git
2. $ cd simple_flutter_auth_app
3. $ flutter pub get
4. Go to https://console.firebase.google.com/u/0/ and add a project
5. Enter the project name you want, else use default settings
6. Go to Authentification, Set uo sign-in method, enable "Email/Password" and "Anonymous"
7. Go to Database, Create Database, production mode, CAREFULLY choose location
8. In Database > rules, replace "false" by "true" and publish
9. Go back to project overview

10. For iOS :
- a. In project overview, click on iOS 
- b. On a terminal, in  simple_flutter_auth_app, "$ open ios/Runner.xcworkspace", a Xcode page opens
- c. copy Bundle Identifier (com.example.simpleFlutterAuthApp) in iOS bundle ID, then click register app
- d. Download GoogleService-Info.plist and paste it in simple_flutter_auth_app/ios (protected in .gitignore)
- e. Drag the file in the Xcode window Runner>Runner
- f. Finish ("Next" x 3 and "Skip this step")

11. For Android :
- a. In project overview, click on Android
- b. Find "package" in android/app/src/main/AndroidManifest.xml (com.example.simple_flutter_auth_app) and copy in Android package name
- c. NOT POSSIBLE : In terminal, cd simple_flutter_auth_app, "$ keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore", password "android"
- d. NOT POSSIBLE : copy / paste SHA1 code
- e. Download google-services.json, paste in android/app
- f. Finish ("Next" x 2 and "Skip this step")