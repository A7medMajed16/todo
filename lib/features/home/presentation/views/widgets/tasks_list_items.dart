import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/size/screen_dimensions.dart';
import 'package:todo/features/home/data/models/task_model.dart';
import 'package:todo/features/home/presentation/views/widgets/tasks_item.dart';

class TasksListItems extends StatelessWidget {
  TasksListItems({super.key});
  final List<TaskModel> tasks = generateRandomTasks(40);
  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      thumbColor: AppColors.primerColor.withValues(alpha: 0.8),
      padding: EdgeInsets.symmetric(horizontal: 8),
      thickness: 5,
      minThumbLength: 30,
      radius: Radius.circular(ScreenDimensions.width),
      child: ListView.separated(
        itemCount: 41,
        itemBuilder: (context, index) => index == 40
            ? SizedBox(height: 65)
            : TasksItem(
                taskModel: tasks[index],
              ),
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(height: 12),
      ),
    );
  }
}

List<TaskModel> generateRandomTasks(int length) {
  final faker = Faker();
  final statuses = ["Waiting", "Inprogress", "Finished"];
  final importanceLevels = ["Low", "Medium", "High"];

  return List<TaskModel>.generate(length, (index) {
    return TaskModel(
      title: faker.lorem.sentence(),
      content: faker.lorem.sentences(3).join(' '),
      date: faker.date.dateTime(minYear: 2010, maxYear: 2025).toString(),
      image: faker.image.loremPicsum(),
      status: statuses[faker.randomGenerator.integer(statuses.length)],
      importanceLevel: importanceLevels[
          faker.randomGenerator.integer(importanceLevels.length)],
    );
  });
}
