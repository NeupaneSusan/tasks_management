import 'package:flutter/material.dart';
import 'package:taskmgt/model/status.dart';

class AppColor {
  static Color primaryColor = const Color(0xff4563ea);
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color lightColor = const Color(0xFFBDBDBD);
  static Color blackColor = const Color(0xAB000000);
  static Color darkBlackColor = const Color(0xFF000000);

  static Color redColor = const Color(0xFFFF5252);
  static Color greenColor = const Color(0xFF4CAF50);

  static Color lightBackgroundColor = Color.fromRGBO(4, 21, 26, 0.1);
  static Color yellowColor = const Color.fromRGBO(255, 171, 64, 1);
  static Color purpleColor = const Color.fromRGBO(156, 39, 176, 1);

  static Color getColorByStatus(Status status) {
    switch (status) {
      case Status.pending:
        return AppColor.yellowColor;
      case Status.running:
        return AppColor.primaryColor;
      case Status.testing:
        return AppColor.purpleColor;
      default:
        return AppColor.greenColor;
    }
  }

  static Color getNextColorByStaus(Status status) {
    switch (status) {
      case Status.pending:
        return AppColor.primaryColor;
      case Status.running:
        return AppColor.purpleColor;
      case Status.testing:
        return AppColor.greenColor;
      default:
        return AppColor.greenColor;
    }
  }
}
