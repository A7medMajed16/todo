import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
  List<TaskModel> filteredTasks = [];
  final ScrollController scrollController = ScrollController();

  void initScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        log("reached");
        pageIndex++;
        getTasks();
      }
    });
    getTasks();
  }

  Future<void> getTasks({bool refresh = false}) async {
    log("refresh_token:${await secureStorage!.read(key: "refresh_token")}");
    log("access_token:${await secureStorage!.read(key: "access_token")}");
    if (refresh) {
      pageIndex = 1;
    }
    emit(HomeLoading());
    var result = await _homeRepo.getTasks(pageIndex: pageIndex);
    result.fold(
      (failure) => !isClosed ? emit(HomeFailure(failure.errorMessage)) : null,
      (apiTasks) {
        if (pageIndex == 1) {
          tasks.clear();
        }
        tasks.addAll(apiTasks);
        !isClosed ? emit(HomeSuccess()) : null;
      },
    );
  }

  void deleteTask(String taskId) {
    emit(HomeLoading());
    tasks.removeWhere((element) => element.id == taskId);
    emit(HomeSuccess());
  }

  Future<void> updateFilter(String? newFilter) async {
    emit(HomeLoading());
    filterStatus = newFilter;
    filteredTasks.clear();
    filteredTasks =
        tasks.where((element) => element.status == filterStatus).toList();
    emit(HomeSuccess());
  }
}
