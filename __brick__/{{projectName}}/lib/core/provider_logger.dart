import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProviderLogger implements ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log('''
${provider.name ?? provider.runtimeType} updated:
{
  "newValue": "$newValue"
}''', name: 'ProviderLogger');
  }

  @override
  void didAddProvider(
      ProviderBase provider, Object? value, ProviderContainer container) {
    log('''
${provider.name ?? provider.runtimeType} initialized:
{
  "value": "$value"
}''', name: 'ProviderLogger');
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    log(
      '${provider.name ?? provider.runtimeType} disposed',
      name: 'ProviderLogger',
    );
  }

  @override
  void providerDidFail(ProviderBase provider, Object error,
      StackTrace stackTrace, ProviderContainer container) {
    log('''
${provider.name ?? provider.runtimeType} failed:
{
  "error": "$error"
  "stacktrace": "$stackTrace"
}''', name: 'ProviderLogger');
  }
}
