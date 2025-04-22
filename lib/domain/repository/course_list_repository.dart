import 'package:edu_platform_demo/core/constants/api_constants.dart';

import '../model/course_filter_type.dart';
import '../../data/model/course.dart';

/// 강좌 목록 조회를 위한 Repository 인터페이스
abstract class CourseListRepository {
  /// 강좌 목록을 조회합니다.
  ///
  /// [filterType]에 따라 다음과 같이 동작합니다:
  /// - [CourseFilterType.all]: 모든 강좌를 조회합니다.
  /// - [CourseFilterType.recommended]: 추천 강좌만 조회합니다.
  /// - [CourseFilterType.free]: 무료 강좌만 조회합니다.
  /// - [CourseFilterType.enrolled]: 수강 중인 강좌만 조회합니다.
  ///
  /// [offset]은 페이지네이션을 위한 시작 위치입니다.
  /// [count]는 한 번에 가져올 강좌 수입니다.
  Future<List<Course>> fetchCourses({
    CourseFilterType filterType = CourseFilterType.all,
    int offset = 0,
    int count = ApiConstants.defaultPageSize,
  });

  /// 수강 중인 강좌 목록을 조회합니다.
  /// SharedPreferences에 저장된 수강 중인 강좌 ID를 기반으로 목록을 구성합니다.
  Future<List<Course>> getEnrolledCourses();
}
