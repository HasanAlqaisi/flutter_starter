import 'package:{{projectName}}/core/failures/storage_failure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';

abstract class EncryptedKeyStorage {
  Future<Either<StorageReadFailure, String?>> read({required String key});

  Future<Either<StorageWriteFailure, void>> write(
      {required String key, required String? value});

  Future<Either<StorageFailure, void>> delete({required String key});
}

class FlutterEncryptedStorage extends EncryptedKeyStorage {
  final FlutterSecureStorage _secureStroage;

  FlutterEncryptedStorage(this._secureStroage);

  @override
  Future<Either<StorageReadFailure, String?>> read(
      {required String key}) async {
    try {
      return Right(await _secureStroage.read(key: key));
    } catch (e, s) {
      return Left(StorageReadFailure('حدث خطأ اثناء قراءة البيانات',
          error: e, stackTrace: s));
    }
  }

  @override
  Future<Either<StorageWriteFailure, void>> write(
      {required String key, required String? value}) async {
    try {
      await _secureStroage.write(key: key, value: value);

      return const Right(null);
    } catch (e, s) {
      return Left(StorageWriteFailure('حدث خطأ اثناء كتابة البيانات',
          error: e, stackTrace: s));
    }
  }

  @override
  Future<Either<StorageFailure, void>> delete({required String key}) async {
    try {
      await _secureStroage.delete(key: key);

      return const Right(null);
    } catch (e, s) {
      return Left(StorageDeleteFailure('حدث خطأ اثناء حذف البيانات',
          error: e, stackTrace: s));
    }
  }
}

final secureKeyStorageProvider = Provider<EncryptedKeyStorage>((ref) {
  return FlutterEncryptedStorage(const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  ));
});
