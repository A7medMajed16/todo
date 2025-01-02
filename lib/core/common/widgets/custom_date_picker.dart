import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/core/theme/styles.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    super.key,
    this.onTap,
    this.title,
    this.isError = false,
    this.isActive = false,
    this.isPop = false,
    this.value,
    this.hint,
    this.errorMessage,
  });
  final Function()? onTap;
  final String? title;
  final String? value, hint, errorMessage;
  final bool isError, isActive, isPop;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        title != null
            ? Text(
                title!,
                style: Styles.textStyle12Regular.copyWith(
                  color: Color(0xff6E6A7C),
                ),
              )
            : SizedBox(),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: errorMessage != null
                    ? AppColors.errorColor
                    : AppColors.borderColor,
                width: errorMessage != null ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value ?? hint ?? "",
                  style: value != null
                      ? Styles.textStyle14Bold
                      : Styles.textStyle14Regular.copyWith(
                          color: AppColors.hintTextColor,
                        ),
                ),
                SvgPicture.asset(
                  AppIcons.coreCommonAssetsIconsCalendar,
                )
              ],
            ),
          ),
        ),
        errorMessage != null
            ? Text(
                errorMessage!,
                style: Styles.textStyle9Regular.copyWith(
                  color: AppColors.errorColor,
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
