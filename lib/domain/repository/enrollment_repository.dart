/// 수강 신청 상태 관리를 위한 Repository 인터페이스
abstract class EnrollmentRepository {
  /// 특정 강좌를 수강 신청합니다.
  ///
  /// [courseId]는 강좌의 고유 식별자입니다. (문자열 형태)
  Future<void> enroll(String courseId);

  /// 특정 강좌의 수강 신청을 취소합니다.
  ///
  /// [courseId]는 강좌의 고유 식별자입니다. (문자열 형태)
  Future<void> unenroll(String courseId);

  /// 특정 강좌의 수강 신청 여부를 확인합니다.
  ///
  /// [courseId]는 강좌의 고유 식별자입니다. (문자열 형태)
  ///
  /// 반환값이 true이면 수강 중, false이면 수강 중이 아님을 나타냅니다.
  Future<bool> isEnrolled(String courseId);

  /// 수강 중인 모든 강좌의 ID 목록을 가져옵니다.
  ///
  /// 반환값은 강좌 ID 문자열 목록입니다.
  Future<List<String>> getEnrolledCourseIds();
}
