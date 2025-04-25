import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

import 'package:edu_platform_demo/domain/repository/enrollment_repository.dart';

/// EnrollmentRepository 구현체
///
/// 수강 신청 상태를 관리하는 기능을 구현합니다.
/// SharedPreferences를 사용하여 로컬에 수강 상태를 저장합니다.
/// CourseListRepository와 동일한 저장소와 키를 사용하여 일관성을 유지합니다.
///
/// 저장 형식:
/// - 키: 'enrolled_course_ids'
/// - 값: List<String> 형태로 수강 중인 강좌 ID 목록이 저장됨
/// 예시:
/// ```
/// [
///   "18818",
///   "21503",
///   "20330"
/// ]
/// ```
/// SharedPreferences는 이 목록을 JSON으로 변환하지 않고,
/// 네이티브 List<String> 형태 그대로 저장합니다.
class EnrollmentRepositoryImpl implements EnrollmentRepository {
  /// 로컬 저장소 접근을 위한 SharedPreferences 인스턴스
  final SharedPreferences _preferences;

  /// SharedPreferences에서 사용할 키
  ///
  /// CourseListRepository와 동일한 키를 사용하여
  /// 수강 신청 상태의 일관성을 유지합니다.
  static const String _enrolledCoursesKey = 'enrolled_course_ids';

  /// EnrollmentRepository 구현체 생성자
  ///
  /// [preferences]는 로컬 저장소 접근을 위한 SharedPreferences 인스턴스입니다.
  EnrollmentRepositoryImpl({
    required SharedPreferences preferences,
  }) : _preferences = preferences;

  @override
  Future<void> toggleEnrollment(int courseId) async {
    try {
      // 현재 수강 중인 강좌 ID 목록 조회
      // SharedPreferences에서 List<String> 형태로 직접 저장/조회됨
      final enrolledCourses =
          _preferences.getStringList(_enrolledCoursesKey) ?? [];
      final courseIdString = courseId.toString();

      // 수강 상태 토글
      if (enrolledCourses.contains(courseIdString)) {
        enrolledCourses.remove(courseIdString);
        debugPrint('Successfully unenrolled from course $courseId');
      } else {
        enrolledCourses.add(courseIdString);
        debugPrint('Successfully enrolled in course $courseId');
      }

      // 변경된 목록을 List<String> 형태로 저장
      await _preferences.setStringList(_enrolledCoursesKey, enrolledCourses);
    } catch (e) {
      debugPrint('Error toggling enrollment for course $courseId: $e');
      rethrow;
    }
  }

  @override
  Future<bool> isEnrolled(int courseId) async {
    try {
      // 수강 중인 강좌 ID 목록에서 확인
      final enrolledCourses =
          _preferences.getStringList(_enrolledCoursesKey) ?? [];
      return enrolledCourses.contains(courseId.toString());
    } catch (e) {
      debugPrint('Error checking enrollment status for course $courseId: $e');
      return false;
    }
  }
}
