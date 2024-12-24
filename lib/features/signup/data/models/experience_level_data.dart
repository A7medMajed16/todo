import 'package:flutter/material.dart';
import 'package:todo/core/localization/localization_functions.dart';

class ExperienceLevelData {
  final List<String> dataEnglish = [
    'Fresh',
    'Junior',
    'MidLevel',
    'Senior',
  ];
  final List<String> dataArabic = [
    'مبتدئ',
    'جونيور',
    'متوسط',
    'سينير',
  ];
  final List<String> values = [
    "fresh",
    "junior",
    "midLevel",
    "senior",
  ];

  List<DropdownMenuItem> get experienceLevelItems =>
      List<DropdownMenuItem>.generate(
        4,
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
