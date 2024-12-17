import 'package:flutter/material.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({
    super.key,
    required this.mobileLayout,
    required this.tabletLayout,
    required this.deskTopLayout,
  });
  final WidgetBuilder mobileLayout, tabletLayout, deskTopLayout;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth + 32 < 800) {
        return mobileLayout(context);
      } else {
        return tabletLayout(context);
      }
    });
  }
}
