import 'package:{{projectName}}/core/failures/base_failure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:{{projectName}}/main_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NormalKeyStorage {
  Either<StorageReadFailure, String?> read({required String key});

  Future<Either<StorageWriteFailure, void>> write({
    required String key,
    required String? value,
  });

  Future<Either<StorageFailure, void>> delete({required String key});
}

class SharedPrefNormalKeyStorage extends NormalKeyStorage {
  final SharedPreferencesWithCache prefs;

  SharedPrefNormalKeyStorage(this.prefs);

  @override
  Either<StorageReadFailure, String?> read({required String key}) {
    try {
      return Right(prefs.get(key)?.toString());
    } catch (e, s) {
      return Left(
        StorageReadFailure(
          'حدث خطأ اثناء قراءة البيانات',
          error: e,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  Future<Either<StorageWriteFailure, void>> write({
    required String key,
    required String? value,
  }) async {
    try {
      // ignore: void_checks
      if (value == null) return Right(prefs.remove(key));

      await prefs.setString(key, value);

      return const Right(null);
    } catch (e, s) {
      return Left(
        StorageWriteFailure(
          'حدث خطأ اثناء كتابة البيانات',
          error: e,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  Future<Either<StorageFailure, void>> delete({required String key}) async {
    try {
      await prefs.remove(key);

      return const Right(null);
    } catch (e, s) {
      return Left(
        StorageDeleteFailure(
          'حدث خطأ اثناء حذف البيانات',
          error: e,
          stackTrace: s,
        ),
      );
    }
  }
}

final normalKeyStorageProvider = Provider<NormalKeyStorage>((ref) {
  return SharedPrefNormalKeyStorage(
    ref.watch(sharedPrefsProvider).requireValue,
  );
});
