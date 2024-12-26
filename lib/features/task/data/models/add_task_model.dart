import 'package:todo/features/home/data/models/task_model.dart';

class AddTaskModel {
  final TaskModel taskModel;
  final bool isQr;
  AddTaskModel({required this.taskModel, this.isQr = false});
}
