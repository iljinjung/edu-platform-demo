import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

class DioProvider {
  static Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        contentType: 'application/json',
        responseType: ResponseType.json,
        headers: {
          'Access-Control-Allow-Origin': '*',
        },
      ),
    );

    return dio;
  }
}
