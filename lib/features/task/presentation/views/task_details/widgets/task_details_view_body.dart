import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/core/theme/app_images.dart';
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
            taskModel.image == null
                ? SizedBox()
                : Center(
                    child: Hero(
                      tag: "taskImage${taskModel.id}",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://todo.iraqsapp.com/images/${taskModel.image!}",
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
                  ),
            Text(
              taskModel.title ?? "",
              style: Styles.textStyle19Bold,
            ),
            Text(
              formatContentWithNewLines(taskModel.desc ?? ""),
              style: Styles.textStyle14Regular
                  .copyWith(color: AppColors.subtitleTextColor),
            ),
            TaskDetailsWidget(
              title: taskModel.createdAt == null
                  ? "'d MMMM yyyy'"
                  : DateFormat('d MMMM, yyyy').format(taskModel.createdAt!),
              icon: AppIcons.coreCommonAssetsIconsCalendar,
              isDate: true,
            ),
            TaskDetailsWidget(
              title: taskModel.status ?? "",
              icon: AppIcons.coreCommonAssetsIconsStatus,
              isDate: false,
            ),
            TaskDetailsWidget(
              title: taskModel.priority ?? "",
              icon: AppIcons.coreCommonAssetsIconsFlag,
              isDate: false,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.secondColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: PrettyQrView.data(
                  data: taskModel.toJson().toString(),
                  decoration: const PrettyQrDecoration(
                    image: PrettyQrDecorationImage(
                      image: AssetImage(
                        AppImages.coreCommonAssetsImagesAppLauncher,
                      ),
                    ),
                    shape: PrettyQrSmoothSymbol(
                      color: AppColors.mainTextColor,
                    ),
                  ),
                ),
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

// QrImageView(
//                 data: taskModel.toJson().toString(),
//                 version: QrVersions.auto,
//                 eyeStyle: QrEyeStyle(
//                   eyeShape: QrEyeShape.square,
//                   color: AppColors.primerColor,
//                 ),
//                 size: ScreenDimensions.width - 44,
//               )
