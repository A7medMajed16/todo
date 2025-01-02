import 'package:flutter/material.dart';
import 'package:todo/core/localization/localization_functions.dart';

class TaskDataModel {
  final Color statusContainerColor, statusTitleColor, importanceLevelColor;
  final String statusTitle, importanceLevelTitle;

  TaskDataModel({
    required this.statusContainerColor,
    required this.statusTitleColor,
    required this.importanceLevelColor,
    required this.statusTitle,
    required this.importanceLevelTitle,
  });
}

class TaskStatusData {
  final List<String> dataEnglish = [
    'Waiting',
    'In Progress',
    'Finished',
  ];
  final List<String> dataArabic = [
    'انتظار',
    'قيد التنفيذ',
    'منتهي',
  ];
  final List<String> values = [
    "waiting",
    "inprogress",
    "finished",
  ];

  List<DropdownMenuItem> get statusItems => List<DropdownMenuItem>.generate(
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

class TaskPriorityData {
  final List<String> dataEnglish = [
    'Low Priority',
    'Medium Priority',
    'High Priority',
  ];
  final List<String> dataArabic = [
    'منخفض',
    'متوسط',
    'عالي',
  ];
  final List<String> values = [
    "low",
    "medium",
    "high",
  ];

  List<DropdownMenuItem> get priorityItems => List<DropdownMenuItem>.generate(
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
