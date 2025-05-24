import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/api_constants.dart';

class DioProvider {
  static Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        contentType: 'application/json',
        responseType: ResponseType.json,
        headers: {},
      ),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
        ),
      );
    }

    return dio;
  }
}
