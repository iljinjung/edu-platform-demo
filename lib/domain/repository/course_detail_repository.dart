import 'package:edu_platform_demo/core/constants/api_constants.dart';

import 'package:edu_platform_demo/domain/model/course.dart';
import 'package:edu_platform_demo/domain/model/lecture.dart';

/// 강좌 상세 정보 조회를 위한 Repository 인터페이스
abstract class CourseDetailRepository {
  /// 특정 강좌의 상세 정보를 조회합니다.
  ///
  /// [courseId]는 강좌의 고유 식별자입니다.
  Future<Course> getCourse(int courseId);

  /// 특정 강좌에 포함된 강의 목록을 조회합니다.
  ///
  /// [courseId]는 강좌의 고유 식별자입니다.
  /// [offset]은 페이지네이션을 위한 시작 위치입니다.
  /// [count]는 한 번에 가져올 강의 수입니다. 1~40 사이의 값이어야 합니다.
  ///
  /// API 응답에는 전체 강의 수(lecture_count)가 포함되어 있어,
  /// 이를 통해 다음 페이지 존재 여부를 확인할 수 있습니다.
  Future<List<Lecture>> getLectures({
    required int courseId,
    int offset = 0,
    int count = ApiConstants.defaultPageSize,
  });
}
