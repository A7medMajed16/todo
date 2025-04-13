import 'dart:developer';
import 'dart:io';

void main() {
  const String featureName = 'profile';
  // Project path
  final projectPath = "${Directory.current.path}/lib/features/$featureName";

  // Folder and file structure
  final paths = [
    '$projectPath/presentation/bloc',
    '$projectPath/presentation/pages',
    '$projectPath/presentation/widgets',
    '$projectPath/domain/entities',
    '$projectPath/domain/repositories',
    '$projectPath/domain/usecases',
    '$projectPath/data/models',
    '$projectPath/data/repositories',
    '$projectPath/data/datasources',
    '$projectPath/data/datasources/local_datasources',
    '$projectPath/data/datasources/remote_datasources',
    '$projectPath/data/datasources/local_datasources/local_datasources.dart',
    '$projectPath/data/datasources/remote_datasources/remote_datasources.dart',
  ];

  for (var path in paths) {
    if (path.endsWith('.dart')) {
      // Handle files
      final file = File(path);
      if (!file.existsSync()) {
        file.createSync(recursive: true);
        log('Created file: $path ✓');
      } else {
        log('File already exists: $path');
      }
    } else {
      // Handle directories
      final directory = Directory(path);
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
        log('Created directory: $path ✓');
      } else {
        log('Directory already exists: $path');
      }
    }
  }
  log('Feature files and folders created successfully ✓');
}

// dart run lib/create_feature_folders.dart
