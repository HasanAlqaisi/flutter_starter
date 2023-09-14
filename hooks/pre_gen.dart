import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  try {
    final projectName = context.vars['projectName'];

    final progress = context.logger.progress('Creating $projectName..');

    await Process.run('flutter', ['create', projectName]);

    progress.complete('$projectName created');
  } catch (e) {
    context.logger.err(e.toString());
  }
}
