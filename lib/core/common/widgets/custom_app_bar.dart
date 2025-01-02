import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/size/screen_dimensions.dart';
import 'package:todo/core/common/widgets/custom_pop_over_widget.dart';
import 'package:todo/core/localization/localization_functions.dart';
import 'package:todo/core/routes/app_router.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/core/theme/styles.dart';
import 'package:todo/features/home/data/models/task_model.dart';
import 'package:todo/features/home/presentation/manager/task_edit_delete_cubit/task_edit_delete_cubit.dart';
import 'package:todo/features/task/data/models/add_task_model.dart';

AppBar customAppBar(
        {required String title,
        required BuildContext context,
        TaskModel? taskModel}) =>
    AppBar(
      backgroundColor: AppColors.backgroundColor,
      scrolledUnderElevation: 0,
      elevation: 0,
      leading: Padding(
        padding: LocalizationHelper.isAppArabic()
            ? const EdgeInsets.only(right: 22)
            : const EdgeInsets.only(left: 22),
        child: InkWell(
          splashColor: AppColors.splashColor,
          hoverColor: Colors.transparent,
          borderRadius: BorderRadius.circular(ScreenDimensions.width),
          child: Transform.flip(
            flipX: !LocalizationHelper.isAppArabic(),
            child: SvgPicture.asset(
              AppIcons.coreCommonAssetsIconsArrowLeft,
              colorFilter: ColorFilter.mode(
                AppColors.iconColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          onTap: () {
            context.pop();
          },
        ),
      ),
      titleSpacing: 8,
      title: InkWell(
        splashColor: AppColors.splashColor,
        hoverColor: Colors.transparent,
        borderRadius: BorderRadius.circular(ScreenDimensions.width),
        radius: ScreenDimensions.width,
        onTap: () {
          context.pop();
        },
        child: Text(
          title,
          style: Styles.textStyle16Bold,
        ),
      ),
      centerTitle: false,
      actions: taskModel != null
          ? [
              BlocConsumer<TaskEditDeleteCubit, TaskEditDeleteState>(
                builder: (context, state) {
                  if (state is TaskEditDeleteLoading) {
                    return CircularProgressIndicator(
                      color: AppColors.primerColor,
                      strokeCap: StrokeCap.round,
                    );
                  } else {
                    return CustomPopOverWidget(
                      isAppBar: true,
                      editFunction: () => context.push(AppRouter.kAddNewTask,
                          extra: AddTaskModel(taskModel: taskModel)),
                      deleteFunction: () => context
                          .read<TaskEditDeleteCubit>()
                          .showDeleteDialog(context, taskModel.id!, null),
                    );
                  }
                },
                listener: (BuildContext context, TaskEditDeleteState state) {
                  if (state is TaskEditDeleteSuccess) {
                    context.replace(AppRouter.kHome);
                  } else if (state is TaskEditDeleteFailure &&
                      state.errorMessage == "Unauthorized") {
                    context
                        .read<TaskEditDeleteCubit>()
                        .showDeleteDialog(context, taskModel.id!, null);
                  }
                },
              ),
            ]
          : null,
    );
