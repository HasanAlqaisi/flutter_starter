part of 'base_failure.dart';

sealed class HttpFailure extends BaseFailure {
  HttpFailure(String message, {super.error, super.stackTrace})
    : super(message: message);
}

class HttpSimpleFailure extends HttpFailure {
  HttpSimpleFailure(super.message, {super.error, super.stackTrace});
}

class HttpUnAuthorizedFailure extends HttpFailure {
  HttpUnAuthorizedFailure(super.message, {super.error, super.stackTrace});
}
