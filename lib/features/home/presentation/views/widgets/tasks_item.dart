import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/widgets/custom_pop_over_widget.dart';
import 'package:todo/core/routes/app_router.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/core/theme/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/features/home/data/models/task_model.dart';
import 'package:todo/core/config/classes/task_status_data_model.dart';

class TasksItem extends StatelessWidget {
  const TasksItem({super.key, required this.taskModel});
  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    TaskStatusDataModel taskData = getTaskData(taskModel.status ?? "waiting",
        localizations, taskModel.priority ?? "low");
    return ListTile(
      onTap: () => context.push(AppRouter.kTaskDetails, extra: taskModel),
      splashColor: AppColors.splashColor.withValues(alpha: 0.05),
      hoverColor: Colors.transparent,
      contentPadding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      titleAlignment: ListTileTitleAlignment.top,
      minLeadingWidth: 0,
      horizontalTitleGap: 12,
      subtitle: Column(
        spacing: 8,
        children: [
          SizedBox(height: 0),
          Row(
            children: [
              Flexible(
                child: Text(
                  taskModel.desc ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: Styles.textStyle14Regular
                      .copyWith(color: AppColors.subtitleTextColor),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 2,
                children: [
                  SvgPicture.asset(
                    AppIcons.coreCommonAssetsIconsFlag,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                        taskData.importanceLevelColor, BlendMode.srcIn),
                  ),
                  Text(
                    taskData.importanceLevelTitle,
                    style: Styles.textStyle12Medium.copyWith(
                      color: taskData.importanceLevelColor,
                    ),
                  ),
                ],
              ),
              Text(
                formatDateTime(DateTime.now().toString()),
                style: Styles.textStyle12Regular.copyWith(
                  color: AppColors.subtitleTextColor,
                ),
              ),
            ],
          )
        ],
      ),
      leading: Hero(
        tag: "taskImage${taskModel.id}",
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: CachedNetworkImage(
            imageUrl: taskModel.image!,
            width: 64,
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
              color: AppColors.errorColor,
            ),
            placeholder: (context, url) => SizedBox(
              width: 30,
              height: 30,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: const CircularProgressIndicator(
                  color: AppColors.primerColor,
                  strokeCap: StrokeCap.round,
                ),
              ),
            ),
          ),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Flexible(
            child: Text(
              taskModel.title ?? "",
              overflow: TextOverflow.ellipsis,
              style: Styles.textStyle16Bold,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: taskData.statusContainerColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              taskData.statusTitle,
              style: Styles.textStyle12Medium.copyWith(
                color: taskData.statusTitleColor,
              ),
            ),
          )
        ],
      ),
      trailing: CustomPopOverWidget(
        editFunction: () =>
            context.push(AppRouter.kAddNewTask, extra: taskModel),
      ),
    );
  }

  TaskStatusDataModel getTaskData(String status, AppLocalizations localizations,
          String importanceLevel) =>
      TaskStatusDataModel(
          statusContainerColor: status == "Finished"
              ? Color(0xffE3F2FF)
              : status == "inprogress"
                  ? Color(0xffF0ECFF)
                  : Color(0xffFFE4F2),
          statusTitleColor: status == "finished"
              ? Color(0xff0087FF)
              : status == "inprogress"
                  ? Color(0xff5F33E1)
                  : Color(0xffFF7D53),
          importanceLevelColor: importanceLevel == "high"
              ? Color(0xffFF7D53)
              : importanceLevel == "medium"
                  ? Color(0xff5F33E1)
                  : Color(0xff0087FF),
          statusTitle: status == "finished"
              ? localizations.home_finished_tasks
              : status == "inprogress"
                  ? localizations.home_in_progress_tasks
                  : localizations.home_waiting_tasks,
          importanceLevelTitle: importanceLevel == "high"
              ? localizations.home_high
              : importanceLevel == "medium"
                  ? localizations.home_medium
                  : localizations.home_low);

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }
}
