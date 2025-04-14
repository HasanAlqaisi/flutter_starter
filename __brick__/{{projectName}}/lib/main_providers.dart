import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main_providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<SharedPreferencesWithCache> sharedPrefs(Ref ref) {
  return SharedPreferencesWithCache.create(
    cacheOptions: SharedPreferencesWithCacheOptions(),
  );
}

@Riverpod(keepAlive: true)
FutureOr<void> initEntryPoint(Ref ref) async {
  await ref.watch(sharedPrefsProvider.future);
}
