import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/widgets/doted_border_container.dart';
import 'package:todo/core/helper/image_picker_helper/image_picker_helper.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/core/theme/styles.dart';
import 'package:todo/features/task/presentation/manager/add_new_task_cubit/add_new_task_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    AddNewTaskCubit addNewTaskCubit = context.read<AddNewTaskCubit>();
    return BlocBuilder<AddNewTaskCubit, AddNewTaskState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => ImagePickerHelper().showPhotoPickerBottomSheet(
            context,
            addNewTaskCubit.changeImage,
            "الصورة",
            "Task Image",
          ),
          borderRadius: BorderRadius.circular(12),
          child: addNewTaskCubit.imageFile != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(addNewTaskCubit.imageFile!),
                )
              : addNewTaskCubit.imagePath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: addNewTaskCubit.imagePath!,
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
                    )
                  : DottedBorderContainer(
                      width: double.infinity,
                      height: 56,
                      borderColor: AppColors.primerColor,
                      borderWidth: 2,
                      spacing: 3,
                      borderRadius: 12,
                      child: Center(
                        child: Row(
                          spacing: 8,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                                AppIcons.coreCommonAssetsIconsAddImage),
                            Text(
                              AppLocalizations.of(context)!.new_task_add_img,
                              style: Styles.textStyle16Medium
                                  .copyWith(color: AppColors.primerColor),
                            )
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
