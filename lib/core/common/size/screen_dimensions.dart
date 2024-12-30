import 'package:flutter/material.dart';

class ScreenDimensions {
  static late double height;
  static late double width;

  static void init(BuildContext context) {
    // Get the MediaQuery padding to account for safe areas
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final EdgeInsets viewPadding = mediaQuery.viewPadding;

    // Calculate the actual safe area dimensions
    width = mediaQuery.size.width - viewPadding.left - viewPadding.right;
    height = mediaQuery.size.height - viewPadding.top - viewPadding.bottom;
  }
}
