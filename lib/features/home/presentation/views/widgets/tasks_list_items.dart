import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/size/screen_dimensions.dart';
import 'package:todo/core/common/widgets/error_page.dart';
import 'package:todo/core/theme/styles.dart';
import 'package:todo/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:todo/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:todo/features/home/presentation/manager/task_edit_delete_cubit/task_edit_delete_cubit.dart';
import 'package:todo/features/home/presentation/views/widgets/tasks_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksListItems extends StatelessWidget {
  const TasksListItems({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    TaskEditDeleteCubit taskEditDeleteCubit =
        context.read<TaskEditDeleteCubit>();
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocListener<TaskEditDeleteCubit, TaskEditDeleteState>(
      listener: (context, state) {
        if (state is TaskEditDeleteSuccess) {
          homeCubit.deleteTask(state.taskId);
        }
      },
      child: BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          log("state:$state");
          if (state is HomeLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primerColor,
                strokeCap: StrokeCap.round,
              ),
            );
          } else if (state is HomeFailure) {
            log("tasks_list_items-HomeFailure:${state.message}");
            return ErrorPage(
              onPressed: () => homeCubit.getTasks(),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: RawScrollbar(
                    thumbColor: AppColors.primerColor.withValues(alpha: 0.8),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    thickness: 5,
                    minThumbLength: 30,
                    controller: homeCubit.scrollController,
                    radius: Radius.circular(ScreenDimensions.width),
                    child: RefreshIndicator(
                      onRefresh: () => homeCubit.getTasks(refresh: true),
                      color: AppColors.backgroundColor,
                      backgroundColor: AppColors.primerColor,
                      child: ListView.separated(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: homeCubit.scrollController,
                        itemCount: homeCubit.filterStatus != null
                            ? homeCubit.filteredTasks.length + 1
                            : homeCubit.tasks.length + 1,
                        itemBuilder: (context, index) => (homeCubit
                                        .filterStatus !=
                                    null
                                ? homeCubit.filteredTasks.isEmpty
                                : homeCubit.tasks.isEmpty)
                            ? ErrorPage(
                                errorMessage: appLocalizations.home_no_tasks,
                                onPressed: homeCubit.filterStatus == null
                                    ? () => homeCubit.getTasks()
                                    : null,
                              )
                            : index ==
                                    (homeCubit.filterStatus != null
                                        ? homeCubit.filteredTasks.length
                                        : homeCubit.tasks.length)
                                ? SizedBox(height: 65)
                                : Dismissible(
                                    key: ValueKey(homeCubit.tasks[index].id),
                                    secondaryBackground: Container(
                                      padding: EdgeInsets.all(16),
                                      color: Colors.red,
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: const Icon(
                                        Icons.delete_rounded,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    background: Container(
                                      padding: EdgeInsets.all(16),
                                      color: Colors.red,
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: const Icon(
                                        Icons.delete_rounded,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    confirmDismiss: (direction) async {
                                      taskEditDeleteCubit.showDeleteDialog(
                                          context,
                                          homeCubit.tasks[index].id!,
                                          index);
                                      if (taskEditDeleteCubit.state
                                          is TaskEditDeleteSuccess) {
                                        return true;
                                      } else {
                                        return false;
                                      }
                                    },
                                    child: TasksItem(
                                      taskModel: homeCubit.filterStatus != null
                                          ? homeCubit.filteredTasks[index]
                                          : homeCubit.tasks[index],
                                      itemIndex: index,
                                    ),
                                  ),
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: 12),
                      ),
                    ),
                  ),
                ),
                if (state is HomeLoadingMore)
                  CircularProgressIndicator(
                    color: AppColors.primerColor,
                    strokeCap: StrokeCap.round,
                  ),
                if (homeCubit.loadMore == false)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      appLocalizations.home_no_more_tasks,
                      style: Styles.textStyle14Regular
                          .copyWith(color: AppColors.subtitleTextColor),
                    ),
                  ),
                SizedBox(height: 20),
              ],
            );
          }
        },
        listener: (BuildContext context, HomeState state) {
          if (state is HomeFailure) {
            if (state.message == "Unauthorized") {
              homeCubit.getTasks();
            } else if (state.message ==
                "Session expired. Please login again.") {
              context.read<LoginCubit>().logout();
            }
          }
        },
      ),
    );
  }
}
