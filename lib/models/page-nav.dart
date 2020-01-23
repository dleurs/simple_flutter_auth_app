import 'package:flutter/material.dart';

class PageNav {
  int index;
  Widget widget;
  bool showBottomNavBar;

  PageNav({@required this.index, @required this.widget, @required this.showBottomNavBar});
}