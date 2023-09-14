import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension RefX on Ref {
  /// Cancel the request if they're no longer needed.
  CancelToken cancelToken() {
    final token = CancelToken();
    onDispose(token.cancel);
    return token;
  }

  /// Delay the network request by [duration], so if a dependency changes
  /// multiple times rapidly, we trigger only a single request.
  Future<void> debounce(Duration duration) {
    final completer = Completer<void>();
    final timer = Timer(duration, () {
      if (!completer.isCompleted) completer.complete();
    });

    onDispose(() {
      timer.cancel();
      if (!completer.isCompleted) {
        completer.completeError(StateError('cancelled'));
      }
    });

    return completer.future;
  }
}
