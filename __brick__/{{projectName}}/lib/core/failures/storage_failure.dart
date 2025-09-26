part of 'base_failure.dart';

sealed class StorageFailure extends BaseFailure {
  StorageFailure(String message, {super.error, super.stackTrace})
    : super(message: message);
}

class StorageWriteFailure extends StorageFailure {
  StorageWriteFailure(super.message, {super.error, super.stackTrace});
}

class StorageReadFailure extends StorageFailure {
  StorageReadFailure(super.message, {super.error, super.stackTrace});
}

class StorageDeleteFailure extends StorageFailure {
  StorageDeleteFailure(super.message, {super.error, super.stackTrace});
}
