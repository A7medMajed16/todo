import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/localization/localization_functions.dart';
import 'package:todo/core/theme/styles.dart';

class TaskDetailsWidget extends StatelessWidget {
  const TaskDetailsWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.isDate});
  final String title, icon;
  final bool isDate;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: LocalizationHelper.isAppArabic()
          ? EdgeInsets.fromLTRB(10, 7, 7, 24)
          : EdgeInsets.fromLTRB(24, 7, 7, 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.secondColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isDate
              ? FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "End Date",
                        style: Styles.textStyle9Regular,
                      ),
                      Text(
                        title,
                        style: Styles.textStyle14Regular,
                      ),
                    ],
                  ),
                )
              : Text(
                  title,
                  style: Styles.textStyle16Bold
                      .copyWith(color: AppColors.primerColor),
                ),
          SvgPicture.asset(
            icon,
            height: 24,
            width: 24,
            fit: BoxFit.scaleDown,
          ),
        ],
      ),
    );
  }
}
