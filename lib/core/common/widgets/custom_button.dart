import 'package:flutter/material.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/theme/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    this.isLoading = false,
  });
  final void Function()? onPressed;
  final String? title;
  final Widget? leading, tailing;
  final Color backGroundColor, borderColor;
  final bool isFilled, isLoading;

  final TextStyle? titleStyle;
  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
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
            leading != null || isLoading
                ? isLoading
                    ? CircularProgressIndicator(
                        color: AppColors.primerColor,
                        strokeCap: StrokeCap.round,
                      )
                    : leading ?? SizedBox()
                : const SizedBox(),
            (leading != null || isLoading) && title != null
                ? const SizedBox(width: 8)
                : const SizedBox(),
            title != null || isLoading
                ? Text(
                    isLoading ? localizations.loading : title!,
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
