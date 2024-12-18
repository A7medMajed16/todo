import 'package:flutter/material.dart';
import 'package:todo/core/localization/localization_functions.dart';

class ExperienceLevelData {
  final List<String> dataEnglish = [
    'Beginner',
    'Intermediate',
    'Advanced',
  ];
  final List<String> dataArabic = [
    'مبتدئ',
    'متوسط',
    'متقدم',
  ];
  final List<String> values = [
    "b",
    "i",
    "a",
  ];

  List<DropdownMenuItem> get experienceLevelItems =>
      List<DropdownMenuItem>.generate(
        3,
        (index) => DropdownMenuItem(
          value: values[index],
          child: Text(
            LocalizationHelper.isAppArabic()
                ? dataArabic[index]
                : dataEnglish[index],
          ),
        ),
      );
}
