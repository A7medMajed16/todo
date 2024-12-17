import 'dart:developer';
import 'dart:io';

void main() {
  //project path
  final projectPath = "${Directory.current.path}/lib";

  //folder creation
  final directories = [
    '$projectPath/core',
    '$projectPath/features',
    '$projectPath/core/api',
    '$projectPath/core/api/errors',
    '$projectPath/core/common',
    '$projectPath/core/common/assets',
    '$projectPath/core/common/assets/animations',
    '$projectPath/core/common/assets/fonts',
    '$projectPath/core/common/assets/icons',
    '$projectPath/core/common/assets/images',
    '$projectPath/core/common/colors',
    '$projectPath/core/common/size',
    '$projectPath/core/common/widgets',
    '$projectPath/core/config',
    '$projectPath/core/config/classes',
    '$projectPath/core/helper',
    '$projectPath/core/helper/image_picker_helper',
    '$projectPath/core/helper/validations',
    '$projectPath/core/helper/internet_helper',
    '$projectPath/core/localization',
    '$projectPath/core/routes',
    '$projectPath/core/services',
    '$projectPath/core/services/sub_services',
    '$projectPath/core/services/sub_services/local_storage_service',
    '$projectPath/core/services/sub_services/notifications_service',
    '$projectPath/core/theme',
  ];

  for (var dir in directories) {
    final directory = Directory(dir);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
      log('Created: $dir ✓');
    } else {
      log('Directory already exists: $dir ');
    }
  }
  log('creating files Successfully ✓');
}

// dart run lib/create_feature_folders.dart
