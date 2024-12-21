import 'dart:ui';
import 'package:flutter/material.dart';

class DottedBorderContainer extends StatelessWidget {
  final Widget child;
  final double borderWidth;
  final Color borderColor;
  final double spacing;
  final EdgeInsets padding;
  final double borderRadius;
  final double? width;
  final double? height;

  const DottedBorderContainer({
    super.key,
    required this.child,
    this.borderWidth = 1.0,
    this.borderColor = Colors.black,
    this.spacing = 5.0,
    this.padding = const EdgeInsets.all(8.0),
    this.borderRadius = 0.0,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(borderWidth / 2),
      child: CustomPaint(
        painter: DottedBorderPainter(
          color: borderColor,
          strokeWidth: borderWidth,
          spacing: spacing,
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double spacing;
  final double borderRadius;

  DottedBorderPainter({
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.spacing = 5.0,
    this.borderRadius = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round // Add round caps for better dot appearance
      ..style = PaintingStyle.stroke;

    final RRect rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        strokeWidth / 2, // Offset by half stroke width
        strokeWidth / 2, // Offset by half stroke width
        size.width - strokeWidth, // Account for stroke width
        size.height - strokeWidth, // Account for stroke width
      ),
      Radius.circular(borderRadius),
    );

    final Path path = Path()..addRRect(rRect);

    final Path dashPath = Path();
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + spacing),
          Offset.zero,
        );
        distance += spacing * 2;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(DottedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.spacing != spacing ||
        oldDelegate.borderRadius != borderRadius;
  }
}
