import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/size/screen_dimensions.dart';
import 'package:todo/core/common/widgets/error_page.dart';
import 'package:todo/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:todo/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:todo/features/home/presentation/views/widgets/tasks_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksListItems extends StatelessWidget {
  const TasksListItems({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return RawScrollbar(
      thumbColor: AppColors.primerColor.withValues(alpha: 0.8),
      padding: EdgeInsets.symmetric(horizontal: 8),
      thickness: 5,
      minThumbLength: 30,
      radius: Radius.circular(ScreenDimensions.width),
      child: BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeSuccess) {
            if (state.tasks.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () => homeCubit.getTasks(),
                color: AppColors.backgroundColor,
                backgroundColor: AppColors.primerColor,
                child: ListView.separated(
                  itemCount: state.tasks.length + 1,
                  itemBuilder: (context, index) => index == state.tasks.length
                      ? SizedBox(height: 65)
                      : TasksItem(
                          taskModel: state.tasks[index],
                        ),
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 12),
                ),
              );
            } else {
              return ErrorPage(
                errorMessage: appLocalizations.home_no_tasks,
                onPressed: homeCubit.filterStatus == null
                    ? () => homeCubit.getTasks()
                    : null,
              );
            }
          } else if (state is HomeFailure) {
            log("tasks_list_items-HomeFailure:${state.message}");
            return ErrorPage(
              onPressed: () => homeCubit.getTasks(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primerColor,
                strokeCap: StrokeCap.round,
              ),
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
