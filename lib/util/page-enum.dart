import 'package:flutter/material.dart';

import 'package:simple_flutter_auth_app/ui/screens/page-one-screen.dart';
import 'package:simple_flutter_auth_app/ui/screens/page-three-screen.dart';
import 'package:simple_flutter_auth_app/ui/screens/page-two-screen.dart';
import 'package:simple_flutter_auth_app/ui/screens/user-screen.dart';

enum Page {
  pageOne,
  pageTwo,
  pageThree,
  user,
}

Widget pageToWidget(Page pageInput) {
  if (pageInput == Page.pageOne) {
    return PageOneScreen();
  }
  else if (pageInput == Page.pageTwo) {
    return PageTwoScreen();
  }
  else if (pageInput == Page.pageThree) {
    return PageThreeScreen();
  }
  else {
    return UserScreen();
  }
}

int pageToIndex(Page pageInput) {
  if (pageInput == Page.pageOne) {
    return 0;
  }
  else if (pageInput == Page.pageTwo) {
    return 1;
  }
  else if (pageInput == Page.pageThree) {
    return 2;
  }
  else { // should never be the case
    return -1;
  }
}

Page indexToPage(int index) {
    if (index == 0) {
    return Page.pageOne;
  }
  else if (index == 1) {
    return Page.pageTwo;
  }
  else if (index == 2) {
    return Page.pageThree;
  }
  else { // should never be the case
    return Page.user;
  }
}
