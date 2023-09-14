import 'dart:developer';

import 'package:{{projectName}}/core/failures/http_failure.dart';
import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  ErrorInterceptor();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final successValue = response.data?['success'] as bool?;
    final errorMessage = (response.data?['error'] as String?);

    final isSuccess = successValue == null || successValue;

    if (!isSuccess) {
      final error = DioException(
        requestOptions: response.requestOptions,
        type: DioExceptionType.badResponse,
        error: HttpSimpleFailure(errorMessage ?? 'حدث خطأ'),
        message: errorMessage,
      );
      handler.reject(error, true);
      return;
    }

    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final response = err.response;

    _logError(response, err);

    return handler.next(err);
  }

  void _logError(Response<dynamic>? response, DioException err) {
    if (response != null) {
      log(response.data.toString());
      log(response.headers.toString());
      log(response.requestOptions.toString());
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      log(err.requestOptions.toString());
      log(err.message.toString());
    }
  }
}
