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
  ScrollController scrollController = ScrollController();
  // ignore: prefer_final_fields
  bool _isFirstLoading = true;
  bool loadMore = true;
  void initScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          loadMore) {
        log("reached");
        pageIndex++;
        getTasks(withRefresh: false);
      }
    });
    getTasks();
  }

  Future<void> getTasks({bool refresh = false, bool withRefresh = true}) async {
    log("refresh_token:${await secureStorage!.read(key: "refresh_token")}");
    log("access_token:${await secureStorage!.read(key: "access_token")}");
    log("user_id:${await secureStorage!.read(key: "user_id")}");
    if (withRefresh || _isFirstLoading || refresh) {
      emit(HomeLoading());
      loadMore = true;
      pageIndex = 1;
    } else {
      emit(HomeLoadingMore());
    }

    var result = await _homeRepo.getTasks(pageIndex: pageIndex);
    result.fold(
      (failure) => !isClosed ? emit(HomeFailure(failure.errorMessage)) : null,
      (apiTasks) {
        _isFirstLoading = false;
        if (apiTasks.isEmpty) {
          loadMore = false;
        } else {
          if (pageIndex == 1) {
            tasks.clear();
            tasks.addAll(apiTasks);
          } else {
            tasks.addAll(apiTasks);
          }
        }

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
