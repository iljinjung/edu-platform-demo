import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'dart:developer' as dev;

// 기본 반환 타입을 위한 간단한 클래스 또는 typedef (추후 확장 가능)
// 예시: 성공 여부와 데이터를 포함하는 Result 클래스
class ApiResponse<T> {
  final T? data;
  final bool isSuccess;
  final String? errorMessage;
  final int? statusCode;

  ApiResponse.success(this.data, {this.statusCode})
      : isSuccess = true,
        errorMessage = null;

  ApiResponse.failure(this.errorMessage, {this.statusCode})
      : isSuccess = false,
        data = null;
}

class DioWrapper {
  final Dio _dio;
  static const int _defaultRetryAttempts = 3;

  DioWrapper({required Dio dio}) : _dio = dio {
    // RetryInterceptor 추가
    _dio.interceptors.add(RetryInterceptor(
      dio: _dio,
      logPrint: dev.log, // dev.log를 사용하여 로깅
      retries: _defaultRetryAttempts,
      retryDelays: const [
        Duration(seconds: 1),
        Duration(seconds: 2),
        Duration(seconds: 3),
      ],
      // 기본적으로 모든 요청 실패 시 재시도 (필요시 특정 조건 추가 가능)
      // retryableExtraStatuses: {status_code_to_retry_on},
    ));
  }

  Future<ApiResponse<T>> getData<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    // Options? options, // 필요시 Dio Options도 받을 수 있도록 확장
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        // options: options,
      );
      // Dio의 Response에서 실제 데이터만 추출하거나, ApiResponse로 감싸서 반환
      return ApiResponse.success(response.data, statusCode: response.statusCode);
    } on DioException catch (e) {
      dev.log('DioWrapper.getData 에러: $path', error: e, stackTrace: e.stackTrace);
      // DioException에서 상태 코드와 메시지 추출
      return ApiResponse.failure(
        e.message ?? 'Unknown network error',
        statusCode: e.response?.statusCode,
      );
    } catch (e, stackTrace) {
      dev.log('DioWrapper.getData 일반 에러: $path', error: e, stackTrace: stackTrace);
      return ApiResponse.failure(e.toString());
    }
  }

  // POST, PUT, DELETE 등의 메소드도 유사하게 추가 가능
  // Future<ApiResponse<T>> postData<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async { ... }
}
