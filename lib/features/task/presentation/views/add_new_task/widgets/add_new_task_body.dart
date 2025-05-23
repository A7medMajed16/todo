import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/common/widgets/custom_button.dart';
import 'package:todo/core/common/widgets/custom_date_picker.dart';
import 'package:todo/core/common/widgets/custom_drop_button.dart';
import 'package:todo/core/common/widgets/custom_text_field.dart';
import 'package:todo/core/config/classes/task_data.dart';
import 'package:todo/core/helper/date_picker_helper/custome_date_picker.dart';
import 'package:todo/core/helper/validations/validations.dart';
import 'package:todo/core/routes/app_router.dart';
import 'package:todo/features/task/presentation/manager/add_new_task_cubit/add_new_task_cubit.dart';
import 'package:todo/features/task/presentation/views/add_new_task/widgets/image_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNewTaskBody extends StatelessWidget {
  AddNewTaskBody({super.key, required this.isQr});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool isQr;
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
                  Center(child: ImageContainer()),
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
                    items: TaskPriorityData().priorityItems,
                    value: addNewTaskCubit.priority,
                    onChanged: (value) => addNewTaskCubit.updatePriority(value),
                    hint: localizations.new_task_priority_hint,
                    isColored: true,
                    title: localizations.new_task_priority,
                    validator: (value) =>
                        Validations.validateTaskPriority(value),
                  ),
                  addNewTaskCubit.status != null && isQr == false
                      ? CustomDropButton(
                          items: TaskStatusData().statusItems,
                          value: addNewTaskCubit.status,
                          onChanged: (value) =>
                              addNewTaskCubit.updateStatus(value),
                          hint: localizations.new_task_status_hint,
                          isColored: true,
                          title: localizations.new_task_status,
                          validator: (value) =>
                              Validations.validateTaskStatus(value),
                        )
                      : SizedBox(),
                  CustomDatePicker(
                    hint: localizations.new_task_date_hint,
                    title: localizations.new_task_date,
                    value: addNewTaskCubit.date,
                    errorMessage: addNewTaskCubit.dateError,
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
                      title: addNewTaskCubit.status != null && isQr == false
                          ? localizations.new_task_update
                          : localizations.new_task_button,
                      onPressed: () {
                        addNewTaskCubit.updateDateError();
                        if (_formKey.currentState!.validate() &&
                            addNewTaskCubit.dateError == null) {
                          addNewTaskCubit.status != null && isQr == false
                              ? addNewTaskCubit.updateTask()
                              : addNewTaskCubit.addNewTask(isQr);
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
              log("add_new_task_body - AddNewTaskSuccess");
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
