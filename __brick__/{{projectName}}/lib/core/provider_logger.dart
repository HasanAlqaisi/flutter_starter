import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final class ProviderLogger extends ProviderObserver {
  const ProviderLogger();

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    log('''
${context.provider.name ?? context.runtimeType} updated:
{
  "newValue": "$newValue"
}''', name: 'ProviderLogger');
  }

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    log('''
${context.provider.name ?? context.runtimeType} initialized:
{
  "value": "$value"
}''', name: 'ProviderLogger');
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    log(
      '${context.provider.name ?? context.runtimeType} disposed',
      name: 'ProviderLogger',
    );
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    log('''
${context.provider.name ?? context.runtimeType} failed:
{
  "error": "$error"
  "stacktrace": "$stackTrace"
}''', name: 'ProviderLogger');
  }
}
