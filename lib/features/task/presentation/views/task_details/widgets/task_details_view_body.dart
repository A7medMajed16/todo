import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/size/screen_dimensions.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/core/theme/styles.dart';
import 'package:todo/features/home/data/models/task_model.dart';
import 'package:todo/features/task/presentation/views/task_details/widgets/task_details_widget.dart';

class TaskDetailsViewBody extends StatelessWidget {
  const TaskDetailsViewBody({super.key, required this.taskModel});
  final TaskModel taskModel;
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
            Hero(
              tag: "taskImage${taskModel.id}",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: taskModel.image!,
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: AppColors.errorColor,
                  ),
                  placeholder: (context, url) => const SizedBox(
                    width: 50,
                    height: 50,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CircularProgressIndicator(
                        color: AppColors.primerColor,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              taskModel.title ?? "",
              style: Styles.textStyle19Bold,
            ),
            Text(
              formatContentWithNewLines(taskModel.content ?? ""),
              style: Styles.textStyle14Regular
                  .copyWith(color: AppColors.subtitleTextColor),
            ),
            TaskDetailsWidget(
              title: DateFormat('d MMMM, yyyy')
                  .format(DateTime.parse(taskModel.date!)),
              icon: AppIcons.coreCommonAssetsIconsCalendar,
              isDate: true,
            ),
            TaskDetailsWidget(
              title: taskModel.status ?? "",
              icon: AppIcons.coreCommonAssetsIconsStatus,
              isDate: false,
            ),
            TaskDetailsWidget(
              title: taskModel.importanceLevel ?? "",
              icon: AppIcons.coreCommonAssetsIconsFlag,
              isDate: false,
            ),
            Center(
              child: QrImageView(
                data: taskModel.toJson().toString(),
                version: QrVersions.auto,
                eyeStyle: QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: AppColors.primerColor,
                ),
                size: ScreenDimensions.width - 44,
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  String formatContentWithNewLines(String content) => content.isEmpty
      ? content
      : content
          .split('.')
          .map((sentence) => sentence.trim())
          .where((sentence) => sentence.isNotEmpty)
          .join('.\n');
}
