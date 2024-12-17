import 'dart:io';

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

    // For Android TV, you might want to add additional safety margin
    if (Platform.isAndroid) {
      // Check if running on Android TV
      bool isAndroidTV = mediaQuery.size.width / mediaQuery.size.height > 1.5;

      if (isAndroidTV) {
        // Add safety margin (typically 5-10% of the screen)
        double safetyMargin = 0.05; // 5%
        width = width * (1 - safetyMargin * 2);
        height = height * (1 - safetyMargin * 2);
      }
    }
  }
}
