import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Creating packages..');
  try {
    await Process.run(
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

    await Process.run(
      'flutter',
      [
        'pub',
        'add',
        '--dev',
        'build_runner',
        'riverpod_generator',
        'custom_lint',
        'riverpod_lint',
        'dart_mappable_builder',
        'auto_route_generator',
        'slang_build_runner',
        'flutter_gen_runner',
        if (context.vars['hasForm'] == true) 'reactive_forms_generator',
      ],
      workingDirectory: './${context.vars['projectName']}',
    );

    await Process.run(
      'flutter',
      ['pub', 'get'],
      workingDirectory: './${context.vars['projectName']}',
    );

    await Process.run(
      'dart',
      ['run', 'package_rename'],
      workingDirectory: './${context.vars['projectName']}',
    );

    await Process.run(
      'flutter',
      ['pub', 'add', 'flutter_localizations', '--sdk=flutter'],
      workingDirectory: './${context.vars['projectName']}',
    );

    await Process.run(
      'dart',
      ['run', 'slang'],
      workingDirectory: './${context.vars['projectName']}',
    );

    // write to pubspec.yaml flutter_gen config
    final pubspec = File('./${context.vars['projectName']}/pubspec.yaml');
    pubspec.writeAsStringSync(pubspec.readAsStringSync() +
        '\n\nflutter_gen:\n  output: lib/generated/\n  line_length: 80\n\n  fonts:\n    outputs:\n      package_parameter_enabled: true\n\n  # Optional\n  integrations:\n    flutter_svg: true\n');

    await Process.run(
      'dart',
      ['run', 'build_runner', 'build'],
      workingDirectory: './${context.vars['projectName']}',
    );

    progress.complete('Your project is ready 🚀');
  } catch (e) {
    progress.fail(e.toString());
  }
}
