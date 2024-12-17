import 'dart:developer';
import 'dart:io';

void main() {
  const String featureName = 'auth';
  //project path
  final projectPath = "${Directory.current.path}/lib/features/$featureName";

  //folder creation
  final directories = [
    '$projectPath/data/models',
    '$projectPath/data/repos',
    '$projectPath/presentation/manager',
    '$projectPath/presentation/views/widgets',
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
