import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/helper/validations/validations.dart';
import 'package:todo/features/home/data/models/task_model.dart';
import 'package:todo/features/task/data/repos/task_repo.dart';

part 'add_new_task_state.dart';

class AddNewTaskCubit extends Cubit<AddNewTaskState> {
  AddNewTaskCubit(this._taskRepo) : super(AddNewTaskInitial());
  final TaskRepo _taskRepo;
  File? imageFile;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  String? priority, date, imagePath, taskId, status, dateError;

  void initTask(TaskModel? taskModel) {
    if (taskModel != null) {
      taskId = taskModel.id;
      titleController.text = taskModel.title ?? "";
      contentController.text = taskModel.desc ?? "";
      imagePath = taskModel.image;
      priority = taskModel.priority;
      status = taskModel.status;
      date = taskModel.createdAt == null
          ? null
          : DateFormat('dd/MM/yyyy').format(taskModel.createdAt!).toString();
    }
  }

  Future<void> addNewTask(bool isQr) async {
    emit(AddNewTaskLoading());
    if (imageFile != null && isQr == false) {
      var uploadImageResult = await _taskRepo.uploadImage(
        image: imageFile!,
      );
      uploadImageResult.fold(
          (failure) => !isClosed
              ? emit(AddNewTaskFailure(error: failure.errorMessage))
              : null, (imageUrl) async {
        var result = await _taskRepo.addNewTask(
          TaskModel(
            title: titleController.text,
            desc: contentController.text,
            priority: priority,
            image: imageUrl,
            status: "waiting",
          ),
        );
        result.fold(
            (failure) => !isClosed
                ? emit(AddNewTaskFailure(error: failure.errorMessage))
                : null,
            (done) => !isClosed ? emit(AddNewTaskSuccess()) : null);
      });
    } else {
      var result = await _taskRepo.addNewTask(
        TaskModel(
          title: titleController.text,
          desc: contentController.text,
          priority: priority,
          status: status ?? "waiting",
          image: imagePath ?? "empty",
        ),
      );
      result.fold(
          (failure) => !isClosed
              ? emit(AddNewTaskFailure(error: failure.errorMessage))
              : null,
          (done) => !isClosed ? emit(AddNewTaskSuccess()) : null);
    }
  }

  Future<void> updateTask() async {
    emit(AddNewTaskLoading());
    if (imageFile != null) {
      var uploadImageResult = await _taskRepo.uploadImage(
        image: imageFile!,
      );
      uploadImageResult.fold(
          (failure) => !isClosed
              ? emit(AddNewTaskFailure(error: failure.errorMessage))
              : null, (imageUrl) async {
        var result = await _taskRepo.updateTask(
          TaskModel(
            id: taskId,
            title: titleController.text,
            desc: contentController.text,
            priority: priority,
            image: imageUrl,
            status: status,
          ),
        );
        result.fold(
            (failure) => !isClosed
                ? emit(AddNewTaskFailure(error: failure.errorMessage))
                : null,
            (done) => !isClosed ? emit(AddNewTaskSuccess()) : null);
      });
    } else {
      var result = await _taskRepo.updateTask(
        TaskModel(
          id: taskId,
          title: titleController.text,
          desc: contentController.text,
          priority: priority,
          status: status,
          image: imagePath ?? "empty",
        ),
      );
      result.fold(
          (failure) => !isClosed
              ? emit(AddNewTaskFailure(error: failure.errorMessage))
              : null,
          (done) => !isClosed ? emit(AddNewTaskSuccess()) : null);
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

  void updateStatus(String value) {
    status = value;
  }

  void updateDateError() {
    emit(AddNewTaskInitial());

    dateError = Validations.validateDate(date);
    emit(AddNewTaskUpdateUi());
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
