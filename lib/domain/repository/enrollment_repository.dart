/// 수강 신청 상태 관리를 위한 Repository 인터페이스
abstract class EnrollmentRepository {
  /// 특정 강좌의 수강 신청 상태를 토글합니다.
  /// 수강 중이면 수강 취소, 수강 중이 아니면 수강 신청이 됩니다.
  ///
  /// [courseId]는 강좌의 고유 식별자입니다.
  Future<void> toggleEnrollment(int courseId);

  /// 특정 강좌의 수강 신청 여부를 확인합니다.
  ///
  /// [courseId]는 강좌의 고유 식별자입니다.
  ///
  /// 반환값이 true이면 수강 중, false이면 수강 중이 아님을 나타냅니다.
  Future<bool> isEnrolled(int courseId);
}
