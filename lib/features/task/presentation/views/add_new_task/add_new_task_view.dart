import 'package:flutter/material.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/widgets/custom_app_bar.dart';
import 'package:todo/features/task/presentation/views/add_new_task/widgets/add_new_task_body.dart';

class AddNewTaskView extends StatelessWidget {
  const AddNewTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: customAppBar(title: "Add new task", context: context),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        bottom: false,
        child: AddNewTaskBody(),
      ),
    );
  }
}
