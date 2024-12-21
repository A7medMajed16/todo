import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_new_task_state.dart';

class AddNewTaskCubit extends Cubit<AddNewTaskState> {
  AddNewTaskCubit() : super(AddNewTaskInitial());

  File? imageFile;
  Future<void> changeImage(File? image) async {
    emit(AddNewTaskInitial());
    imageFile = image;
    emit(AddNewTaskUpdateUi());
  }
}
