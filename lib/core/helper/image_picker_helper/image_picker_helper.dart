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

  Future<File?> imageCropper(
      String sourcePath, String arabicTitle, String englishTitle) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: sourcePath,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle:
                LocalizationHelper.isAppArabic() ? arabicTitle : englishTitle,
            toolbarColor: Colors.blue, // Replace with AppColors.iconColor
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true,
            cropStyle: CropStyle.rectangle,
            hideBottomControls: true,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
          ),
          IOSUiSettings(
            title:
                LocalizationHelper.isAppArabic() ? arabicTitle : englishTitle,
            doneButtonTitle: LocalizationHelper.isAppArabic() ? "حفظ" : "Done",
            cancelButtonTitle:
                LocalizationHelper.isAppArabic() ? "الغاء" : "Cancel",
            aspectRatioLockEnabled: true,
            aspectRatioPickerButtonHidden: true,
            cropStyle: CropStyle.rectangle,
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

  Future<File?> getImageFromCamera(
      String arabicTitle, String englishTitle) async {
    try {
      final XFile? imageCamera =
          await picker.pickImage(source: ImageSource.camera);
      if (imageCamera != null) {
        return await imageCropper(imageCamera.path, arabicTitle, englishTitle);
      }
    } catch (e) {
      debugPrint('Error picking image from camera: $e');
    }
    return null;
  }

  /// Picks an image from the gallery and crops it.
  Future<File?> getImageFromGallery(
      String arabicTitle, String englishTitle) async {
    try {
      final XFile? imageGallery =
          await picker.pickImage(source: ImageSource.gallery);
      if (imageGallery != null) {
        return await imageCropper(imageGallery.path, arabicTitle, englishTitle);
      }
    } catch (e) {
      debugPrint('Error picking image from gallery: $e');
    }
    return null;
  }

  void showPhotoPickerBottomSheet(
      BuildContext context,
      Future<void> Function(File? image) updateImageFunction,
      String arabicTitle,
      String englishTitle) {
    final GoRouter router = GoRouter.of(context);
    final AppLocalizations localization = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(12),
      // ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              ListTile(
                onTap: () async => await updateImageFunction(
                        await getImageFromGallery(arabicTitle, englishTitle))
                    .whenComplete(
                  () => router.pop(),
                ),
                splashColor: AppColors.splashColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                leading: const Icon(
                  Icons.photo_library_rounded,
                  color: AppColors.primerColor,
                ),
                title: Text(
                  localization.image_picker_gallery,
                  style: Styles.textStyle16Bold,
                ),
              ),
              ListTile(
                onTap: () async => updateImageFunction(
                        await getImageFromCamera(arabicTitle, englishTitle))
                    .whenComplete(
                  () => router.pop(),
                ),
                splashColor: AppColors.splashColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                leading: const Icon(
                  Icons.camera_rounded,
                  color: AppColors.primerColor,
                ),
                title: Text(
                  localization.image_picker_camera,
                  style: Styles.textStyle16Bold,
                ),
              ),
              SizedBox(height: 10)
            ],
          ),
        );
      },
    );
  }
}
