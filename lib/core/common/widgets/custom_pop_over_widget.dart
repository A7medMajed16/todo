import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/localization/localization_functions.dart';
import 'package:todo/core/theme/styles.dart';

class CustomPopOverWidget extends StatelessWidget {
  const CustomPopOverWidget(
      {super.key,
      this.isAppBar = false,
      this.editFunction,
      this.deleteFunction});
  final bool isAppBar;
  final void Function()? editFunction;
  final void Function()? deleteFunction;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      borderRadius: BorderRadius.circular(12),
      icon: isAppBar
          ? Icon(
              Icons.more_vert_rounded,
              size: 28,
              color: AppColors.iconColor,
            )
          : null,
      shape: ArrowShape(
        arrowWidth: 15,
        arrowHeight: 8,
        isArabic: !LocalizationHelper.isAppArabic(),
      ),
      color: AppColors.backgroundColor,
      constraints: BoxConstraints(maxWidth: 82, minWidth: 82),
      position: PopupMenuPosition.under,
      shadowColor: Colors.black.withValues(alpha: 0.19),
      popUpAnimationStyle: AnimationStyle(
        duration: Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      ),
      child: isAppBar
          ? null
          : Icon(
              Icons.more_vert_rounded,
              size: 28,
              color: AppColors.iconColor,
            ),
      itemBuilder: (context) => [
        PopupMenuItem(
          height: 36,
          onTap: editFunction,
          child: Text(
            AppLocalizations.of(context)!.popup_edit,
            style: Styles.textStyle12Medium,
          ),
        ),
        PopupMenuItem(
          height: 2,
          enabled: false,
          child: Divider(color: AppColors.hintTextColor.withValues(alpha: 0.4)),
        ),
        PopupMenuItem(
          height: 36,
          onTap: deleteFunction,
          child: Text(
            AppLocalizations.of(context)!.popup_delete,
            style:
                Styles.textStyle12Medium.copyWith(color: AppColors.errorColor),
          ),
        ),
      ],
    );
  }
}

class ArrowShape extends ShapeBorder {
  final double arrowWidth;
  final double arrowHeight;
  final double radius;
  final bool isArabic;

  const ArrowShape({
    this.arrowWidth = 8.0,
    this.arrowHeight = 6.0,
    this.radius = 12.0,
    required this.isArabic,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(top: arrowHeight);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(
      rect.topLeft + Offset(0, arrowHeight),
      rect.bottomRight,
    );

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));

    // Calculate arrow position
    final arrowX = isArabic
        ? rect.left + arrowWidth * 3.8 // Position arrow near left edge
        : rect.right - arrowWidth * 3.8; // Position arrow near right edge

    // Draw the arrow (fixed syntax)
    path.moveTo(arrowX, rect.top);
    path.relativeLineTo(arrowWidth / 2, -arrowHeight);
    path.relativeLineTo(arrowWidth / 2, arrowHeight);
    path.close();

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
