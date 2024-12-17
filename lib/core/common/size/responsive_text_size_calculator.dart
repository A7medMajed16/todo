import 'package:flutter/foundation.dart';

double getResponsiveFontSize({required double baseFontSize}) {
  double scaleFactor = getScaleFactor().clamp(0.8, 1.2);

  return (baseFontSize * scaleFactor);
}

double getScaleFactor() {
  PlatformDispatcher dispatcher = PlatformDispatcher.instance;
  double width = (dispatcher.views.first.physicalSize.width) /
      (dispatcher.views.first.devicePixelRatio);
  if (width < 800) {
    return width / 360;
  } else if (width < 1380) {
    return width / 940;
  } else {
    return width / 1460;
  }
}
