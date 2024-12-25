part of 'add_new_task_cubit.dart';

sealed class AddNewTaskState extends Equatable {
  const AddNewTaskState();

  @override
  List<Object> get props => [];
}

final class AddNewTaskInitial extends AddNewTaskState {}

final class AddNewTaskLoading extends AddNewTaskState {}

final class AddNewTaskFailure extends AddNewTaskState {
  final String error;
  const AddNewTaskFailure({required this.error});
}

final class AddNewTaskSuccess extends AddNewTaskState {}

final class AddNewTaskUpdateUi extends AddNewTaskState {}
