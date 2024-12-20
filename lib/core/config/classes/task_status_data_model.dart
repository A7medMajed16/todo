import 'package:flutter/material.dart';

class TaskStatusDataModel {
  final Color statusContainerColor, statusTitleColor, importanceLevelColor;
  final String statusTitle, importanceLevelTitle;

  TaskStatusDataModel({
    required this.statusContainerColor,
    required this.statusTitleColor,
    required this.importanceLevelColor,
    required this.statusTitle,
    required this.importanceLevelTitle,
  });
}
