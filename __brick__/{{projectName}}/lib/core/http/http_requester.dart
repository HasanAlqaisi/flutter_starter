import 'package:{{projectName}}/core/failures/http_failure.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

abstract class HttpRequester {
  Future<Either<HttpFailure, Response>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    HttpOptions? httpOptions,
    CancelToken? cancelToken,
  });

  Future<Either<HttpFailure, Response>> post(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    HttpOptions? httpOptions,
  });

  Future<Either<HttpFailure, Response>> patch(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    HttpOptions? httpOptions,
  });

  Future<Either<HttpFailure, Response>> delete(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    HttpOptions? httpOptions,
  });
}

class HttpOptions {
  final String? requestContentType;
  final Map<String, dynamic>? headers;

  HttpOptions({this.requestContentType, this.headers});

  Options toDioOptions() {
    return Options(
      contentType: requestContentType,
      headers: headers,
    );
  }
}
