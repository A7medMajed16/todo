import 'package:flutter/material.dart';
import 'package:todo/features/task/presentation/views/add_new_task/widgets/image_container.dart';

class AddNewTaskBody extends StatelessWidget {
  const AddNewTaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            ImageContainer(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
