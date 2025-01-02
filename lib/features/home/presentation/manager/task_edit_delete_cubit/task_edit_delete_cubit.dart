import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/widgets/custom_button.dart';
import 'package:todo/core/theme/styles.dart';
import 'package:todo/features/home/data/repos/home_repo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

  void showDeleteDialog(BuildContext context, String taskId, int? itemIndex) {
    emit(TaskEditDeleteInitial());
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.backgroundColor,
        contentTextStyle: Styles.textStyle16Regular,
        actionsAlignment: MainAxisAlignment.spaceBetween,
        title: Text(
          textAlign: TextAlign.center,
          appLocalizations.delete_task_title,
          style: Styles.textStyle18Bold,
        ),
        content: Text(appLocalizations.delete_task_content),
        actions: [
          CustomButton(
            onPressed: () {
              deleteTask(taskId, itemIndex);
              context.pop();
            },
            isFilled: false,
            borderColor: AppColors.errorColor,
            title: appLocalizations.delete_task_button,
            titleStyle:
                Styles.textStyle14Regular.copyWith(color: AppColors.errorColor),
          ),
          CustomButton(
            onPressed: () => context.pop(),
            title: appLocalizations.delete_task_cancel,
            titleStyle: Styles.textStyle14Regular
                .copyWith(color: AppColors.backgroundColor),
          ),
        ],
      ),
    );
  }
}
