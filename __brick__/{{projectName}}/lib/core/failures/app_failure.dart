part of 'base_failure.dart';

sealed class AppFailure extends BaseFailure {
  AppFailure(String message, {super.error, super.stackTrace})
    : super(message: message);
}

class AppSimpleFailure extends AppFailure {
  AppSimpleFailure(super.message, {super.error, super.stackTrace});
}
