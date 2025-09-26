import 'dart:developer';

part 'http_failure.dart';
part 'storage_failure.dart';
part 'app_failure.dart';

sealed class BaseFailure {
  final String message;
  final Object? error;
  final StackTrace? stackTrace;

  BaseFailure({required this.message, this.error, this.stackTrace}) {
    log('error message: $message\nerror: $error\nstackTrace: $stackTrace');
  }
}

String handleErrorMessage(Object error) {
  if (error is BaseFailure) {
    return error.message;
  }

  if (error is Exception) {
    return error.toString().replaceFirst('Exception: ', '');
  }

  return error.toString();
}
