import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/features/home/data/models/task_model.dart';
import 'package:todo/features/home/data/repos/home_repo.dart';
import 'package:todo/features/home/presentation/views/widgets/tab_controller_mixin.dart';
import 'package:todo/main.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with TabControllerManager {
  HomeCubit(this._homeRepo) : super(HomeInitial());

  final HomeRepo _homeRepo;
  int pageIndex = 1;
  String? filterStatus;
  List<TaskModel> tasks = [];

  Future<void> getTasks() async {
    log("refresh_token:${await secureStorage!.read(key: "refresh_token")}");
    log("access_token:${await secureStorage!.read(key: "access_token")}");
    emit(HomeLoading());
    var result = await _homeRepo.getTasks(pageIndex: pageIndex);
    result.fold(
      (failure) => !isClosed ? emit(HomeFailure(failure.errorMessage)) : null,
      (apiTasks) {
        tasks.clear();
        tasks.addAll(apiTasks);
        !isClosed ? emit(HomeSuccess(tasks)) : null;
      },
    );
  }

  Future<void> updateFilter(String? newFilter) async {
    emit(HomeLoading());
    filterStatus = newFilter;
    List<TaskModel> filterTasks =
        tasks.where((element) => element.status == filterStatus).toList();
    emit(HomeSuccess(newFilter == null ? tasks : filterTasks));
  }
}
