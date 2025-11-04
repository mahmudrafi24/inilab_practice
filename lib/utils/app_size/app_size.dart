import 'package:flutter/material.dart';

class AppSize {
  static late double _screenWidth;
  static late double _screenHeight;
  static const double _xdHeight = 882;
  static const double _xdWidth = 375;

  static void init(BuildContext context) {
    _screenWidth = MediaQuery.sizeOf(context).width;
    _screenHeight = MediaQuery.sizeOf(context).height;
  }

  static double height(num value) => (value / _xdHeight) * _screenHeight;
  static double width(num value) => (value / _xdWidth) * _screenWidth;
}
