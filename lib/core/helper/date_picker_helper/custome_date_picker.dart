import 'package:flutter/material.dart';
import 'package:todo/core/common/colors/app_colors.dart';

Future<DateTime?> showCustomDatePicker(
    {required BuildContext context, String? hint, String? title}) async {
  return await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2999),
      fieldHintText: hint,
      fieldLabelText: title,
      builder: (BuildContext context, Widget? picker) {
        return Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            dividerTheme: const DividerThemeData(
              color: Colors.transparent,
            ),
            colorScheme: const ColorScheme.light(
              primary: AppColors.primerColor, // header background color
              onPrimary:
                  AppColors.textFieldBackgroundColor, // header text color
              onSurface: AppColors.primerColor, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primerColor, // button text color
              ),
            ),
          ),
          child: picker!,
        );
      });
}
