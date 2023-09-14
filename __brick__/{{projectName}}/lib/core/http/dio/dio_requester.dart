import 'package:{{projectName}}/core/failures/http_failure.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:{{projectName}}/core/http/dio/error_interceptor.dart';
import 'package:{{projectName}}/core/http/http_requester.dart';

class DioRequester extends HttpRequester {
  final Dio _dio;

  DioRequester({required Dio dio}) : _dio = dio;

  @override
  Future<Either<HttpFailure, Response>> delete(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    HttpOptions? httpOptions,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: httpOptions?.toDioOptions(),
      );

      return Right(response);
    } catch (e) {
      if (e is DioException && e.error is HttpFailure) {
        return Left(e.error as HttpFailure);
      } else if (e is HttpFailure) {
        return Left(e);
      }
      return Left(HttpSimpleFailure('حدث خطأ غير معروف'));
    }
  }

  @override
  Future<Either<HttpFailure, Response>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    HttpOptions? httpOptions,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: httpOptions?.toDioOptions(),
        cancelToken: cancelToken,
      );

      return Right(response);
    } catch (e) {
      if (e is DioException && e.error is HttpFailure) {
        return Left(e.error as HttpFailure);
      } else if (e is HttpFailure) {
        return Left(e);
      }
      return Left(HttpSimpleFailure('حدث خطأ غير معروف'));
    }
  }

  @override
  Future<Either<HttpFailure, Response>> patch(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    HttpOptions? httpOptions,
  }) async {
    try {
      final response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: httpOptions?.toDioOptions(),
      );

      return Right(response);
    } catch (e) {
      if (e is DioException && e.error is HttpFailure) {
        return Left(e.error as HttpFailure);
      } else if (e is HttpFailure) {
        return Left(e);
      }
      return Left(HttpSimpleFailure('حدث خطأ غير معروف'));
    }
  }

  @override
  Future<Either<HttpFailure, Response>> post(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    HttpOptions? httpOptions,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: httpOptions?.toDioOptions(),
      );
      return Right(response);
    } catch (e) {
      if (e is DioException && e.error is HttpFailure) {
        return Left(e.error as HttpFailure);
      } else if (e is HttpFailure) {
        return Left(e);
      }
      return Left(HttpSimpleFailure('حدث خطأ غير معروف'));
    }
  }
}

final httpRequesterProvider = Provider<HttpRequester>((ref) {
  final dio = Dio(BaseOptions(
    headers: {'Authorization': 'Bearer abc'},
  ));

  dio.interceptors.addAll([LogInterceptor(), ErrorInterceptor()]);

  return DioRequester(dio: dio);
});
