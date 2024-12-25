import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/common/widgets/custom_button.dart';
import 'package:todo/core/common/widgets/custom_date_picker.dart';
import 'package:todo/core/common/widgets/custom_drop_button.dart';
import 'package:todo/core/common/widgets/custom_text_field.dart';
import 'package:todo/core/config/classes/task_status_data_model.dart';
import 'package:todo/core/helper/date_picker_helper/custome_date_picker.dart';
import 'package:todo/core/helper/validations/validations.dart';
import 'package:todo/core/routes/app_router.dart';
import 'package:todo/features/task/presentation/manager/add_new_task_cubit/add_new_task_cubit.dart';
import 'package:todo/features/task/presentation/views/add_new_task/widgets/image_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNewTaskBody extends StatelessWidget {
  AddNewTaskBody({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final AddNewTaskCubit addNewTaskCubit = context.read<AddNewTaskCubit>();
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: BlocConsumer<AddNewTaskCubit, AddNewTaskState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  ImageContainer(),
                  CustomTextField(
                    textEditingController: addNewTaskCubit.titleController,
                    hintText: localizations.new_task_title_hint,
                    title: localizations.new_task_title,
                    showLabel: false,
                    validator: (value) => Validations.validateTaskTitle(value),
                  ),
                  CustomTextField(
                    textEditingController: addNewTaskCubit.contentController,
                    hintText: localizations.new_task_content_hint,
                    title: localizations.new_task_content,
                    keyboardType: TextInputType.multiline,
                    isExpanded: true,
                    showLabel: false,
                    validator: (value) =>
                        Validations.validateTaskContent(value),
                  ),
                  CustomDropButton(
                    items: TaskStatusData().priorityItems,
                    value: addNewTaskCubit.priority,
                    onChanged: (value) => addNewTaskCubit.updatePriority(value),
                    hint: localizations.new_task_priority_hint,
                    isColored: true,
                    title: localizations.new_task_priority,
                  ),
                  CustomDatePicker(
                    hint: localizations.new_task_date_hint,
                    title: localizations.new_task_date,
                    value: addNewTaskCubit.date,
                    onTap: () async {
                      DateTime? date = await showCustomDatePicker(
                        context: context,
                        hint: localizations.new_task_date_hint,
                        title: localizations.new_task_date,
                      );
                      addNewTaskCubit.updateDate(date);
                    },
                  ),
                  SizedBox(),
                  SizedBox(
                    width: double.infinity,
                    height: 49,
                    child: CustomButton(
                      isLoading: state is AddNewTaskLoading,
                      title: localizations.new_task_button,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          addNewTaskCubit.addNewTask();
                        }
                      },
                    ),
                  ),
                  SizedBox(),
                ],
              ),
            );
          },
          listener: (BuildContext context, AddNewTaskState state) {
            if (state is AddNewTaskSuccess) {
              context.replace(AppRouter.kHome);
            } else if (state is AddNewTaskFailure) {
              log("add_new_task_body - AddNewTaskFailure:${state.error}");
            }
          },
        ),
      ),
    );
  }
}
