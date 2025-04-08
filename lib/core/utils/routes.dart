import 'package:flutter/material.dart';
import 'package:taskmgt/core/constant/key.dart';

class Routes {
  static BuildContext context = KeyConstant.navigatorKey.currentContext as BuildContext;
  static void routesPushRemoveUntil(Widget pageName) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => pageName), (r) => false);
  }

  static void routesPush(Widget pageName) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => pageName));
  }

  static void pop() {
    Navigator.pop(context);
  }
}
