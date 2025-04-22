import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';

abstract class CourseRemoteSource {
  /// 강좌 목록을 조회합니다.
  ///
  /// [queryParameters]는 API 요청에 사용될 쿼리 파라미터입니다.
  /// 지원되는 파라미터:
  /// - offset: 페이지네이션을 위한 시작 위치 (기본값: 0)
  /// - count: 한 번에 가져올 강좌 수 (기본값: [ApiConstants.defaultPageSize])
  /// - filter_is_recommended: 추천 강좌만 조회 (true/false)
  /// - filter_is_free: 무료 강좌만 조회 (true/false)
  /// - filter_conditions: 특정 강좌 ID 목록으로 필터링 ({"course_ids":[...]})
  ///
  /// 응답 데이터 형식:
  /// ```json
  /// {
  ///   "courses": [
  ///     {
  ///       "id": 18818,
  ///       "title": "도레미 파이썬 Vol.1",
  ///       "short_description": "다양하고 유익한 실습으로 재미있게 배우는 코딩 기초반!",
  ///       "image_file_url": "https://...png",
  ///       "logo_file_url": "https://...png",
  ///       "taglist": ["print", "도레미", "파이썬기초"],
  ///       "description": "...",
  ///       "is_recommended": true,
  ///       "is_free": false,
  ///       "price": "119000",
  ///       "discounted_price": "107100",
  ///       "discount_rate": "0.1"
  ///     }
  ///   ],
  ///   "course_count": 2,
  ///   "_result": {
  ///     "status": "ok",
  ///     "reason": null
  ///   }
  /// }
  /// ```
  Future<Response<Map<String, dynamic>>> getCourseList({
    required Map<String, dynamic> queryParameters,
  });

  /// 특정 강좌의 상세 정보를 조회합니다.
  ///
  /// [courseId]는 필수이며, 강좌의 고유 식별자입니다.
  ///
  /// 응답 데이터 형식:
  /// ```json
  /// {
  ///   "course": {
  ///     "id": 18818,
  ///     "title": "도레미 파이썬 Vol.1",
  ///     "short_description": "다양하고 유익한 실습으로 재미있게 배우는 코딩 기초반!",
  ///     "image_file_url": "...",
  ///     "logo_file_url": "...",
  ///     "taglist": ["파이썬기초", "print"],
  ///     "description": "...",
  ///     "is_recommended": true,
  ///     "is_free": false,
  ///     "price": "119000",
  ///     "discounted_price": "107100",
  ///     "discount_rate": "0.1",
  ///     "completion_info": {
  ///       "condition": {
  ///         "score": 70,
  ///         "progress": 80,
  ///         "is_enabled": true
  ///       },
  ///       "certificate_info": {
  ///         "is_enabled": true
  ///       }
  ///     }
  ///   },
  ///   "_result": {
  ///     "status": "ok",
  ///     "reason": null
  ///   }
  /// }
  /// ```
  Future<Response<Map<String, dynamic>>> getCourseDetail({
    required String courseId,
  });
}

class CourseRemoteSourceImpl implements CourseRemoteSource {
  final Dio _dio;

  CourseRemoteSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Response<Map<String, dynamic>>> getCourseList({
    required Map<String, dynamic> queryParameters,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiConstants.courseList,
      queryParameters: queryParameters,
    );

    return response;
  }

  @override
  Future<Response<Map<String, dynamic>>> getCourseDetail({
    required String courseId,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiConstants.courseGet,
      queryParameters: {
        ApiConstants.courseId: courseId,
      },
    );

    return response;
  }
}
