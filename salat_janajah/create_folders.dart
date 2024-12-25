import 'dart:developer';
import 'dart:io';

void main() {
  final projectPath = '${Directory.current.path}/lib/feature';

  final directories = [
    // configs
    '$projectPath/config/route/app_routes.dart',
    '$projectPath/config/themes/app_theme.dart',
    // core
    '$projectPath/core/animations',
    '$projectPath/core/api',
    '$projectPath/core/error',
    '$projectPath/core/network',
    '$projectPath/core/services',
    '$projectPath/core/usecase',
    '$projectPath/core/widgets',
    '$projectPath/core/utils/app_colors.dart',
    '$projectPath/core/utils/app_strings.dart',
    '$projectPath/core/utils/app_assets.dart',
    '$projectPath/core/utils/hex_color.dart',
    '$projectPath/core/utils/media_query.dart',
    // features
    // data
    '$projectPath/data/models',
    '$projectPath/data/dataSources/remote',
    '$projectPath/data/dataSources/local',
    '$projectPath/data/repositories',
    // domain
    '$projectPath/domain/entities',
    '$projectPath/domain/repositories',
    '$projectPath/domain/useCases',
    // presentation
    '$projectPath/presentation/pages',
    '$projectPath/presentation/widgets',
    '$projectPath/presentation/cubit',
  ];

  for (var dir in directories) {
    final directory = Directory(dir);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
      log('Directory created: $dir');
    } else {
      log('directory already exists: $dir');
    }
  }

  log('creating folders done');
}
