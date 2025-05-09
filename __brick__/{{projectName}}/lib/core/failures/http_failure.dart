part of 'base_failure.dart';

sealed class HttpFailure extends BaseFailure {
  final String message;
  final Object? error;
  final StackTrace? stackTrace;

  HttpFailure(this.message, {this.error, this.stackTrace});
}

class HttpSimpleFailure extends HttpFailure {
  HttpSimpleFailure(super.message, {super.error, super.stackTrace});
}

class HttpUnAuthorizedFailure extends HttpFailure {
  HttpUnAuthorizedFailure(super.message, {super.error, super.stackTrace});
}
