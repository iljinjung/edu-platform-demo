import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as dev;

import '../../core/constants/api_constants.dart';
import '../../domain/model/course_filter_type.dart';
import '../../domain/repository/course_list_repository.dart';
import '../model/course.dart';
import '../model/course_list_query.dart';
import '../source/remote/course_remote_source.dart';

/// CourseListRepository 구현체
///
/// Remote Source를 통한 API 호출과 SharedPreferences를 통한 로컬 데이터 관리를 담당합니다.
/// 강좌 목록 조회 시 필터링 조건에 따라 적절한 API 파라미터를 구성하여 요청합니다.
class CourseListRepositoryImpl implements CourseListRepository {
  /// API 호출을 위한 Remote Source
  final CourseRemoteSource _remoteSource;

  /// 수강 신청 상태 저장을 위한 로컬 스토리지
  final SharedPreferences _preferences;

  /// CourseListRepository 구현체 생성자
  ///
  /// [remoteSource]는 API 호출을 위한 Remote Source입니다.
  /// [preferences]는 수강 신청 상태를 저장하기 위한 SharedPreferences 인스턴스입니다.
  CourseListRepositoryImpl({
    required CourseRemoteSource remoteSource,
    required SharedPreferences preferences,
  })  : _remoteSource = remoteSource,
        _preferences = preferences;

  @override
  Future<List<Course>> fetchCourses({
    CourseFilterType filterType = CourseFilterType.all,
    int offset = 0,
    int count = ApiConstants.defaultPageSize,
  }) async {
    try {
      dev.log(
          'fetchCourses 시작 - filterType: $filterType, offset: $offset, count: $count');

      final enrolledIds =
          _preferences.getStringList('enrolled_course_ids') ?? [];
      dev.log('저장된 수강 강좌 ID 목록: $enrolledIds');

      final query = CourseListQuery.fromFilterType(
        filterType: filterType,
        offset: offset,
        count: filterType == CourseFilterType.enrolled
            ? enrolledIds.length
            : count,
        enrolledCourseIds:
            filterType == CourseFilterType.enrolled ? enrolledIds : null,
      );

      dev.log('API 요청 파라미터: ${query.toQuery()}');

      final response = await _remoteSource.getCourseList(
        queryParameters: query.toQuery(),
      );

      // dev.log('API 응답 상태 코드: ${response.statusCode}');
      // dev.log('API 응답 헤더: ${response.headers}');
      // dev.log('API 응답 데이터: ${response.data}');

      final data = response.data;
      if (data == null) {
        dev.log('응답 데이터가 null입니다.');
        return [];
      }

      final courses = data['courses'] as List<dynamic>;
      final result = courses
          .map((json) => Course.fromJson(json as Map<String, dynamic>))
          .toList();

      dev.log('변환된 강좌 목록 개수: ${result.length}');
      return result;
    } catch (e, stackTrace) {
      dev.log(
        'fetchCourses 에러 발생',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<List<Course>> getEnrolledCourses() async {
    final enrolledIds = _preferences.getStringList('enrolled_course_ids') ?? [];
    if (enrolledIds.isEmpty) {
      dev.log('수강 중인 강좌 ID 없음 → API 호출 생략');
      return [];
    }
    return fetchCourses(
      filterType: CourseFilterType.enrolled,
    );
  }
}
