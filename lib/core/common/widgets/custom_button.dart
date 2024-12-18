import 'package:flutter/material.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/theme/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.title,
    this.leading,
    this.backGroundColor = AppColors.buttonBackgroundColor,
    this.isFilled = true,
    this.borderColor = AppColors.borderColor,
    this.titleStyle,
    this.tailing,
  });
  final void Function()? onPressed;
  final String? title;
  final Widget? leading, tailing;
  final Color backGroundColor, borderColor;
  final bool isFilled;

  final TextStyle? titleStyle;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isFilled ? backGroundColor : AppColors.backgroundColor,
        overlayColor: isFilled ? AppColors.backgroundColor : backGroundColor,
        shadowColor: AppColors.shadowColor,
        side: isFilled ? null : BorderSide(width: 1, color: borderColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: isFilled ? null : 0,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leading ?? const SizedBox(),
            leading != null && title != null
                ? const SizedBox(width: 8)
                : const SizedBox(),
            title != null
                ? Text(
                    title!,
                    style: titleStyle ??
                        Styles.textStyle16Bold.copyWith(
                            color: isFilled
                                ? AppColors.filledButtonTextColor
                                : backGroundColor),
                  )
                : const SizedBox(),
            tailing != null && title != null
                ? const SizedBox(width: 8)
                : const SizedBox(),
            tailing ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
