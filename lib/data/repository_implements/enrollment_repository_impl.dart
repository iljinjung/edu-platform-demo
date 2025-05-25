import 'dart:developer' as dev; // For logging

import 'package:edu_platform_demo/core/database/db_helper.dart';
import 'package:edu_platform_demo/domain/repository/enrollment_repository.dart';

/// EnrollmentRepository 구현체
///
/// 수강 신청 상태를 관리하는 기능을 구현합니다.
/// DatabaseHelper를 사용하여 SQLite 데이터베이스에 수강 상태를 저장합니다.
class EnrollmentRepositoryImpl implements EnrollmentRepository {
  final DatabaseHelper _dbHelper;

  /// EnrollmentRepository 구현체 생성자
  ///
  /// [dbHelper]는 데이터베이스 접근을 위한 DatabaseHelper 인스턴스입니다.
  EnrollmentRepositoryImpl({
    required DatabaseHelper dbHelper,
  }) : _dbHelper = dbHelper;

  @override
  Future<void> enroll(String courseId) async {
    try {
      await _dbHelper.enrollCourse(courseId);
      dev.log('Course $courseId enrolled and saved to DB.');
    } catch (e, stackTrace) {
      dev.log('Error enrolling course $courseId in DB', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> unenroll(String courseId) async {
    try {
      await _dbHelper.unenrollCourse(courseId);
      dev.log('Course $courseId unenrolled and removed from DB.');
    } catch (e, stackTrace) {
      dev.log('Error unenrolling course $courseId from DB', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<bool> isEnrolled(String courseId) async {
    try {
      final enrolled = await _dbHelper.isCourseEnrolled(courseId);
      // dev.log('Checked enrollment for course $courseId from DB: $enrolled'); // Optional logging
      return enrolled;
    } catch (e, stackTrace) {
      dev.log('Error checking enrollment for course $courseId from DB', error: e, stackTrace: stackTrace);
      return false; // Or rethrow, depending on desired error handling
    }
  }

  @override
  Future<List<String>> getEnrolledCourseIds() async {
    try {
      final ids = await _dbHelper.getAllEnrolledCourseIds();
      // dev.log('Retrieved all enrolled course IDs from DB: ${ids.length} courses'); // Optional logging
      return ids;
    } catch (e, stackTrace) {
      dev.log('Error retrieving all enrolled course IDs from DB', error: e, stackTrace: stackTrace);
      return []; // Or rethrow
    }
  }

  // The old toggleEnrollment(int courseId) method is no longer needed
  // as we now have separate enroll and unenroll methods with String courseId.
  // Also, SharedPreferences specific logic and _enrolledCoursesKey are removed.
}
