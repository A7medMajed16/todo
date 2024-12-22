import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/features/home/data/models/task_model.dart';

part 'add_new_task_state.dart';

class AddNewTaskCubit extends Cubit<AddNewTaskState> {
  AddNewTaskCubit() : super(AddNewTaskInitial());

  File? imageFile;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  String? priority, date;

  void initTask(TaskModel? taskModel) {
    if (taskModel != null) {
      titleController.text = taskModel.title ?? "";
      contentController.text = taskModel.content ?? "";
      priority = taskModel.importanceLevel == "High"
          ? "h"
          : taskModel.importanceLevel == "Medium"
              ? "m"
              : "l";
      date = DateFormat('dd/MM/yyyy')
          .format(DateTime.parse(taskModel.date!))
          .toString();
    }
  }

  Future<void> changeImage(File? image) async {
    emit(AddNewTaskInitial());
    imageFile = image;
    emit(AddNewTaskUpdateUi());
  }

  void updatePriority(String value) {
    priority = value;
  }

  void updateDate(DateTime? value) {
    if (value != null) {
      emit(AddNewTaskInitial());
      DateFormat formatter = DateFormat('dd/MM/yyyy');
      date = formatter.format(value).toString();
      emit(AddNewTaskUpdateUi());
    }
  }
}
