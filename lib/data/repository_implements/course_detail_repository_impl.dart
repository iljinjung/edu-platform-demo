import 'package:edu_platform_demo/core/constants/api_constants.dart';
import 'package:edu_platform_demo/domain/repository/course_detail_repository.dart';
import 'package:edu_platform_demo/domain/model/course.dart';
import 'package:edu_platform_demo/domain/model/lecture.dart';
import 'package:edu_platform_demo/data/source/remote/course_remote_source.dart';
import 'package:edu_platform_demo/data/source/remote/lecture_remote_source.dart';
import 'package:flutter/foundation.dart';

/// CourseDetailRepository 구현체
///
/// 강좌 상세 정보와 강의 목록을 조회하는 기능을 구현합니다.
/// Remote Source를 통해 API를 호출하고 응답을 적절한 모델로 변환하여 반환합니다.
class CourseDetailRepositoryImpl implements CourseDetailRepository {
  /// 강좌 정보 조회를 위한 Remote Source
  final CourseRemoteSource _courseRemoteSource;

  /// 강의 목록 조회를 위한 Remote Source
  final LectureRemoteSource _lectureRemoteSource;

  /// CourseDetailRepository 구현체 생성자
  ///
  /// [courseRemoteSource]는 강좌 정보 조회를 위한 Remote Source입니다.
  /// [lectureRemoteSource]는 강의 목록 조회를 위한 Remote Source입니다.
  CourseDetailRepositoryImpl({
    required CourseRemoteSource courseRemoteSource,
    required LectureRemoteSource lectureRemoteSource,
  })  : _courseRemoteSource = courseRemoteSource,
        _lectureRemoteSource = lectureRemoteSource;

  @override
  Future<Course> getCourse(int courseId) async {
    /// Remote Source를 통해 강좌 상세 정보 조회
    final response = await _courseRemoteSource.getCourseDetail(
      courseId: courseId.toString(),
    );

    /// 응답 데이터가 없으면 예외 발생
    final data = response.data;
    if (data == null) {
      throw Exception(
          'Failed to get course detail for id: $courseId - No data');
    }

    /// 응답의 course 필드가 없으면 예외 발생
    final courseData = data['course'] as Map<String, dynamic>?;
    if (courseData == null) {
      throw Exception(
          'Failed to get course detail for id: $courseId - No course data');
    }

    /// 응답 데이터를 Course 모델로 변환하여 반환
    return Course.fromJson(courseData);
  }

  @override
  Future<List<Lecture>> getLectures({
    required int courseId,
    int offset = 0,
    int count = ApiConstants.defaultPageSize,
  }) async {
    /// Remote Source를 통해 강의 목록 조회
    final response = await _lectureRemoteSource.getLectureList(
      courseId: courseId.toString(),
      offset: offset,
      count: count,
    );

    /// 응답 데이터가 없으면 빈 리스트 반환
    final data = response.data;
    if (data == null) {
      debugPrint('No lecture data found for course $courseId');
      return [];
    }

    /// 응답의 lectures 필드가 없으면 빈 리스트 반환
    final lectures = data['lectures'] as List<dynamic>?;
    if (lectures == null || lectures.isEmpty) {
      debugPrint(
          'No lectures found for course $courseId (offset: $offset, count: $count)');
      return [];
    }

    /// 응답 데이터를 Lecture 모델로 변환하여 반환
    return lectures
        .map((json) => Lecture.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
