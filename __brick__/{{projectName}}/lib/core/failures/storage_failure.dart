sealed class StorageFailure {
  final String message;
  final Object? error;
  final StackTrace? stackTrace;

  StorageFailure(this.message, {this.error, this.stackTrace});
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
