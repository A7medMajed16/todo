part of 'task_edit_delete_cubit.dart';

sealed class TaskEditDeleteState extends Equatable {
  const TaskEditDeleteState();

  @override
  List<Object> get props => [];
}

final class TaskEditDeleteInitial extends TaskEditDeleteState {}

final class TaskEditDeleteLoading extends TaskEditDeleteState {}

final class TaskEditDeleteFailure extends TaskEditDeleteState {
  final String errorMessage;

  const TaskEditDeleteFailure(this.errorMessage);
}

final class TaskEditDeleteSuccess extends TaskEditDeleteState {
  final String taskId;

  const TaskEditDeleteSuccess(this.taskId);
}
