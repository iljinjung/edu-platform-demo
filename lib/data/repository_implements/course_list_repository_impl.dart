import 'package:shared_preferences/shared_preferences.dart';

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
    /// 필터 타입과 기본 파라미터로 쿼리 객체 생성
    final query = CourseListQuery.fromFilterType(
      filterType: filterType,
      offset: offset,
      count: count,
      enrolledCourseIds: filterType == CourseFilterType.enrolled
          ? _preferences.getStringList('enrolled_course_ids')
          : null,
    );

    /// Remote Source를 통해 API 호출
    final response = await _remoteSource.getCourseList(
      queryParameters: query.toQuery(),
    );

    /// 응답 데이터가 없으면 빈 리스트 반환
    final data = response.data;
    if (data == null) return [];

    /// 응답 데이터를 Course 모델로 변환하여 반환
    final courses = data['courses'] as List<dynamic>;
    return courses
        .map((json) => Course.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Course>> getEnrolledCourses() async {
    /// enrolled 필터 타입으로 강좌 목록 조회
    /// 내부적으로 수강 중인 강좌 ID 목록으로 필터링하여 조회
    return fetchCourses(filterType: CourseFilterType.enrolled);
  }
}
