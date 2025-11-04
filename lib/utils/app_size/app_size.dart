import 'package:flutter/material.dart';

class AppSize {
  AppSize._();

  static const double _xdHeight = 882;
  static const double _xdWidth = 375;

  static double height(BuildContext context, num value) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return (value / _xdHeight) * screenHeight;
  }

  static double width(BuildContext context, num value) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return (value / _xdWidth) * screenWidth;
  }
}