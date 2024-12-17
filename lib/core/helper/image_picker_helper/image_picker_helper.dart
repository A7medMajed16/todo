import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/localization/localization_functions.dart';
import 'package:todo/core/theme/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImagePickerHelper {
  File? file;
  final picker = ImagePicker();

  Future<File?> imageCropper(String sourcePath) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: sourcePath,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: LocalizationFunctions.isAppArabic()
                ? "الصورة الشخصيه"
                : "Profile Picture",
            toolbarColor: Colors.blue, // Replace with AppColors.iconColor
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true,
            cropStyle: CropStyle.circle,
            hideBottomControls: true,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
          ),
          IOSUiSettings(
            title: LocalizationFunctions.isAppArabic()
                ? "الصورة الشخصيه"
                : "Profile Picture",
            doneButtonTitle:
                LocalizationFunctions.isAppArabic() ? "حفظ" : "Done",
            cancelButtonTitle:
                LocalizationFunctions.isAppArabic() ? "الغاء" : "Cancel",
            aspectRatioLockEnabled: true,
            aspectRatioPickerButtonHidden: true,
            cropStyle: CropStyle.circle,
            aspectRatioLockDimensionSwapEnabled: true,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
          ),
        ],
      );

      if (croppedFile != null) {
        return File(croppedFile.path);
      }
    } catch (e) {
      debugPrint('Error cropping image: $e');
    }
    return null;
  }

  Future<File?> getImageFromCamera() async {
    try {
      final XFile? imageCamera =
          await picker.pickImage(source: ImageSource.camera);
      if (imageCamera != null) {
        return await imageCropper(imageCamera.path);
      }
    } catch (e) {
      debugPrint('Error picking image from camera: $e');
    }
    return null;
  }

  /// Picks an image from the gallery and crops it.
  Future<File?> getImageFromGallery() async {
    try {
      final XFile? imageGallery =
          await picker.pickImage(source: ImageSource.gallery);
      if (imageGallery != null) {
        return await imageCropper(imageGallery.path);
      }
    } catch (e) {
      debugPrint('Error picking image from gallery: $e');
    }
    return null;
  }

  void showPhotoPickerBottomSheet(
    BuildContext context,
    Future<void> Function(File? image) updateImageFunction,
  ) {
    final GoRouter router = GoRouter.of(context);
    final AppLocalizations localization = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () async =>
                    await updateImageFunction(await getImageFromGallery())
                        .whenComplete(
                  () => router.pop(),
                ),
                splashColor: AppColors.splashColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                leading: const Icon(
                  Icons.photo_library_rounded,
                  color: Colors.blue,
                ),
                title: Text(
                  ' localization.image_picker_gallery',
                  style: Styles.textStyle16Medium,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                onTap: () async =>
                    updateImageFunction(await getImageFromCamera())
                        .whenComplete(
                  () => router.pop(),
                ),
                splashColor: AppColors.splashColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                leading: const Icon(
                  Icons.camera_rounded,
                  color: Colors.blue,
                ),
                title: Text(
                  localization.image_picker_camera,
                  style: Styles.textStyle16Medium,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
