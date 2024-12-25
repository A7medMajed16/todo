import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/features/home/data/repos/home_repo.dart';

part 'task_edit_delete_state.dart';

class TaskEditDeleteCubit extends Cubit<TaskEditDeleteState> {
  TaskEditDeleteCubit(this._homeRepo) : super(TaskEditDeleteInitial());
  final HomeRepo _homeRepo;
  int? itemIndex;

  void deleteTask(String taskId, int? itemIndex) async {
    itemIndex = itemIndex;
    emit(TaskEditDeleteLoading());
    var result = await _homeRepo.deleteTask(taskId: taskId);
    result.fold(
      (failure) =>
          !isClosed ? emit(TaskEditDeleteFailure(failure.errorMessage)) : null,
      (done) => !isClosed ? emit(TaskEditDeleteSuccess(taskId)) : null,
    );
  }
}
