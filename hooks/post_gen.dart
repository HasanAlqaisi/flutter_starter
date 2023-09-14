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
        'auto_route',
        'dio',
        'fpdart',
        'flutter_secure_storage',
        'device_preview',
        'flutter_screenutil',
        'google_fonts',
        'fluttertoast',
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
      ['run', 'build_runner', 'build'],
      workingDirectory: './${context.vars['projectName']}',
    );

    progress.complete('Your project is ready 🚀');
  } catch (e) {
    progress.fail(e.toString());
  }
}
