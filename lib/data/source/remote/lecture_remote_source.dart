import 'dart:developer' as dev;
import 'package:dio/dio.dart';

import 'package:edu_platform_demo/core/constants/api_constants.dart';

abstract class LectureRemoteSource {
  /// 강좌에 포함된 강의 목록을 조회합니다.
  ///
  /// [courseId]는 필수이며, 강좌의 고유 식별자입니다.
  /// [offset]은 페이지네이션을 위한 시작 위치입니다. 기본값은 0입니다.
  /// [count]는 한 번에 가져올 강의 수입니다. 1~40 사이의 값이어야 하며, 기본값은 [ApiConstants.defaultPageSize]입니다.
  ///
  /// 응답 데이터 형식:
  /// ```json
  /// {
  ///   "lectures": [
  ///     {
  ///       "id": 153390,
  ///       "title": "수업 미리보기",
  ///       "description": "강의 설명",
  ///       "lecture_type": 0,
  ///       "order_no": 1,
  ///       "is_opened": true,
  ///       "is_preview": true,
  ///       "total_page_count": 0,
  ///       "total_page_point": 0,
  ///       "test_description": null,
  ///       "test_score_opened": null
  ///     }
  ///   ],
  ///   "lecture_count": 6,
  ///   "_result": {
  ///     "status": "ok",
  ///     "reason": null
  ///   }
  /// }
  /// ```
  Future<Response<Map<String, dynamic>>> getLectureList({
    required String courseId,
    int offset = 0,
    int count = ApiConstants.defaultPageSize,
  });
}

class LectureRemoteSourceImpl implements LectureRemoteSource {
  final Dio _dio;

  LectureRemoteSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Response<Map<String, dynamic>>> getLectureList({
    required String courseId,
    int offset = 0,
    int count = ApiConstants.defaultPageSize,
  }) async {
    dev.log('LectureRemoteSource.getLectureList 호출 - courseId: $courseId, offset: $offset, count: $count');
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiConstants.lectureList,
        queryParameters: {
          ApiConstants.courseId: courseId,
          ApiConstants.offset: offset,
          ApiConstants.count: count,
        },
      );

      return response;
    } catch (e, stackTrace) {
      dev.log('LectureRemoteSource.getLectureList 에러 발생', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
