import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// A widget that handles async operations and their states.
///
/// This widget is useful when you need to perform an async operation
/// and show different UI states based on the operation's progress.
/// The child widget can control when to execute the operation by calling
/// the provided execute function.
///
/// Example:
/// ```dart
/// EffectWidget<String>(
///   future: (data) async {
///     // Perform async operation with data
///     await Future.delayed(Duration(seconds: 1));
///   },
///   listener: (status) {
///     status.when(
///       loading: () => print('Loading started'),
///       data: (_) => print('Operation completed'),
///       error: (error, _) => context.showToast(error.toString()),
///     );
///   },
///   builder: (context, ref, status, execute) {
///     return ElevatedButton(
///       onPressed: () => execute('some data'),
///       child: status.when(
///         data: (_) => Text('Operation completed'),
///         loading: () => CircularProgressIndicator(),
///         error: (error, _) => Text('Error: $error'),
///       ),
///     );
///   },
/// )
/// ```
class EffectWidget<Param> extends HookConsumerWidget {
  const EffectWidget({
    super.key,
    required this.builder,
    required this.future,
    this.listener,
  });

  /// The builder function that creates the widget based on the async state
  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<void> status,
    Future<void> Function([Param? data]) execute,
  )
  builder;

  /// The async operation to perform
  final Future<void> Function(Param? data) future;

  /// Callback that receives state changes
  final void Function(AsyncValue<void> status)? listener;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // The pending operation. Or null if none is pending.
    final pendingOperation = useState<Future<void>?>(null);

    // Function to execute the future operation
    Future<void> execute([Param? data]) {
      try {
        pendingOperation.value = future(data);
        return pendingOperation.value!;
      } catch (error, stackTrace) {
        // Create a completed future with error to prevent unhandled exception
        pendingOperation.value = Future.error(error, stackTrace);
        return pendingOperation.value!;
      }
    }

    // We listen to the pending operation, to update the UI accordingly.
    final snapshot = useFuture(pendingOperation.value);
    final status = snapshotToAsyncValue(snapshot);

    // Notify state changes
    useEffect(() {
      listener?.call(status);
      return null;
    }, [status]);

    return builder(context, ref, status, execute);
  }

  AsyncValue<void> snapshotToAsyncValue(AsyncSnapshot<void> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const AsyncValue.loading();
    } else if (snapshot.hasError) {
      return AsyncValue.error(
        snapshot.error!,
        snapshot.stackTrace ?? StackTrace.current,
      );
    } else if (snapshot.hasData) {
      return const AsyncValue.data(null);
    } else {
      return const AsyncValue.data(null);
    }
  }
}
