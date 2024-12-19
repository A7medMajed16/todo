import 'dart:developer';
import 'dart:io';

void main() {
  const String featureName = 'task';
  // Project path
  final projectPath = "${Directory.current.path}/lib/features/$featureName";

  // Folder and file structure
  final paths = [
    '$projectPath/data/models',
    '$projectPath/data/repos',
    '$projectPath/data/repos/${featureName}_repo_impl.dart',
    '$projectPath/data/repos/${featureName}_repo.dart',
    '$projectPath/presentation/manager',
    '$projectPath/presentation/views/widgets',
    '$projectPath/presentation/views/widgets/${featureName}_view_body.dart',
    '$projectPath/presentation/views/${featureName}_view.dart',
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
