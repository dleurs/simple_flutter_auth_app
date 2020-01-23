import 'package:flutter/material.dart';

import 'package:simple_flutter_auth_app/ui/screens/page-one-screen.dart';
import 'package:simple_flutter_auth_app/ui/screens/page-three-screen.dart';
import 'package:simple_flutter_auth_app/ui/screens/page-two-screen.dart';
import 'package:simple_flutter_auth_app/ui/screens/user-screen.dart';

class PageNavigator extends ChangeNotifier {
  Page currentPage;
  Page previousPage;

  PageNavigator({
    this.currentPage = Page.pageOne,
    this.previousPage,
  });

  void changePage(int toIndex) {
    this.previousPage = this.currentPage;
    this.currentPage = indexToPage(toIndex);
    notifyListeners();
  }

  void changePageToPrevious() {
    var temp = this.previousPage;
    this.previousPage = this.currentPage;
    this.currentPage = temp;
    notifyListeners();
  }
}

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
  else { // For user
    return 10;
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
  else { // For user, == 10
    return Page.user;
  }
}