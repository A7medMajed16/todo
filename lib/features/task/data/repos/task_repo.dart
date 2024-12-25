import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:todo/core/api/errors/failures.dart';
import 'package:todo/features/home/data/models/task_model.dart';

abstract class TaskRepo {
  Future<Either<Failure, void>> addNewTask(TaskModel taskModel);
  Future<Either<Failure, void>> updateTask(TaskModel taskModel);
  Future<Either<Failure, String>> uploadImage({required File image});
}
