import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Creating packages..');
  try {
    final packagesResult = await Process.run(
      'flutter',
      [
        'pub',
        'add',
        'flutter_riverpod',
        'riverpod_annotation',
        'hooks_riverpod',
        'flutter_hooks',
        'auto_route',
        'dio',
        'fpdart',
        'flutter_secure_storage',
        'google_fonts',
        'fluttertoast',
        'package_rename',
        'shared_preferences',
        'slang',
        'slang_flutter',
        'dart_mappable',
        if (context.vars['hasForm'] == true) 'reactive_forms',
        if (context.vars['hasForm'] == true) 'reactive_forms_annotations',
      ],
      workingDirectory: './${context.vars['projectName']}',
    );

    if (packagesResult.stderr != null && packagesResult.stderr!.isNotEmpty) {
      context.logger.err('\nflutter pub add fails: ${packagesResult.stderr}');
    } else {
      context.logger.success(
        '\nPackages added successfully',
      );
    }

    final devPackagesResult = await Process.run(
      'flutter',
      [
        'pub',
        'add',
        '--dev',
        'build_runner',
        'riverpod_generator',
        'custom_lint',
        // 'riverpod_lint',
        'dart_mappable_builder',
        'auto_route_generator',
        'slang_build_runner',
        'flutter_gen_runner',
        if (context.vars['hasForm'] == true) 'reactive_forms_generator',
      ],
      workingDirectory: './${context.vars['projectName']}',
    );

    if (devPackagesResult.stderr != null &&
        devPackagesResult.stderr!.isNotEmpty) {
      context.logger
          .err('\nflutter pub add --dev fails: ${devPackagesResult.stderr}');
    } else {
      context.logger.success(
        '\nDev packages added successfully',
      );
    }

    final getPackagesResult = await Process.run(
      'flutter',
      ['pub', 'get'],
      workingDirectory: './${context.vars['projectName']}',
    );

    if (getPackagesResult.stderr != null &&
        getPackagesResult.stderr!.isNotEmpty) {
      context.logger
          .err('\n flutter pub get fails: ${getPackagesResult.stderr}');
    } else {
      context.logger.success(
        '\nPackages fetched successfully',
      );
    }

    final packageRenameResult = await Process.run(
      'dart',
      ['run', 'package_rename'],
      workingDirectory: './${context.vars['projectName']}',
    );

    if (packageRenameResult.stderr != null &&
        packageRenameResult.stderr!.isNotEmpty) {
      context.logger.err(
          '\n dart run package_rename fails: ${packageRenameResult.stderr}');
    } else {
      context.logger.success(
        '\nProject renamed to ${context.vars['packageName']} successfully',
      );
    }

    final addLocalizationsResult = await Process.run(
      'flutter',
      ['pub', 'add', 'flutter_localizations', '--sdk=flutter'],
      workingDirectory: './${context.vars['projectName']}',
    );

    if (addLocalizationsResult.stderr != null &&
        addLocalizationsResult.stderr!.isNotEmpty) {
      context.logger.err(
          '\n flutter pub add flutter_localizations fails: ${addLocalizationsResult.stderr}');
    } else {
      context.logger.success(
        '\nLocalizations added successfully',
      );
    }

    final slangResult = await Process.run(
      'dart',
      ['run', 'slang'],
      workingDirectory: './${context.vars['projectName']}',
    );

    if (slangResult.stderr != null && slangResult.stderr!.isNotEmpty) {
      context.logger.err('\n dart run slang fails: ${slangResult.stderr}');
    } else {
      context.logger.success(
        '\nSlang ran successfully',
      );
    }

    // write to pubspec.yaml flutter_gen config
    final pubspec = File('./${context.vars['projectName']}/pubspec.yaml');
    pubspec.writeAsStringSync(pubspec.readAsStringSync() +
        '\n\nflutter_gen:\n  output: lib/generated/\n  line_length: 80\n\n  fonts:\n    outputs:\n      package_parameter_enabled: true\n\n  # Optional\n  integrations:\n    flutter_svg: true\n');

    final buildRunnerResult = await Process.run(
      'dart',
      ['run', 'build_runner', 'build'],
      workingDirectory: './${context.vars['projectName']}',
    );

    if (buildRunnerResult.stderr != null &&
        buildRunnerResult.stderr!.isNotEmpty) {
      context.logger.err(
          '\n dart run build_runner build fails: ${buildRunnerResult.stderr}');
    } else {
      context.logger.success(
        '\nBuild runner ran successfully',
      );
    }

    final widgetTest =
        File('./${context.vars['projectName']}/test/widget_test.dart');
    widgetTest.deleteSync();

    progress.complete('Your project is ready 🚀');
  } catch (e) {
    progress.fail(e.toString());
  }
}
