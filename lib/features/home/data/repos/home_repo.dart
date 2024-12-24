import 'package:dartz/dartz.dart';
import 'package:todo/core/api/errors/failures.dart';
import 'package:todo/features/home/data/models/task_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<TaskModel>>> getTasks({required int pageIndex});
}
