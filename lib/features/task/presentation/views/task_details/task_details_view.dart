import 'package:flutter/material.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/size/screen_dimensions.dart';
import 'package:todo/core/common/widgets/custom_app_bar.dart';
import 'package:todo/features/home/data/models/task_model.dart';
import 'package:todo/features/task/presentation/views/task_details/widgets/task_details_view_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key, required this.taskModel});
  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: customAppBar(
        title: AppLocalizations.of(context)!.details_title,
        context: context,
        taskModel: taskModel,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: SizedBox(
            width: ScreenDimensions.width > 500 ? 500 : double.infinity,
            child: TaskDetailsViewBody(
              taskModel: taskModel,
            ),
          ),
        ),
      ),
    );
  }
}
