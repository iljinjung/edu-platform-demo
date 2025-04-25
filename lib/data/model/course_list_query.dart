import 'package:edu_platform_demo/core/constants/api_constants.dart';
import 'package:edu_platform_demo/domain/model/course_filter_type.dart';

/// 강좌 목록 조회 API 요청에 사용되는 쿼리 파라미터를 관리하는 클래스
class CourseListQuery {
  /// 페이지네이션을 위한 시작 위치
  final int offset;

  /// 한 번에 가져올 강좌 수
  final int count;

  /// 추천 강좌 필터링 여부
  final bool? isRecommended;

  /// 무료 강좌 필터링 여부
  final bool? isFree;

  /// 특정 강좌 ID 목록으로 필터링
  final List<String>? courseIds;

  /// CourseListQuery 생성자
  ///
  /// [offset]은 페이지네이션을 위한 시작 위치입니다. 기본값은 0입니다.
  /// [count]는 한 번에 가져올 강좌 수입니다. 기본값은 [ApiConstants.defaultPageSize]입니다.
  /// [isRecommended]가 true이면 추천 강좌만 조회합니다.
  /// [isFree]가 true이면 무료 강좌만 조회합니다.
  /// [courseIds]가 지정되면 해당 ID 목록에 포함된 강좌만 조회합니다.
  const CourseListQuery({
    this.offset = 0,
    this.count = ApiConstants.defaultPageSize,
    this.isRecommended,
    this.isFree,
    this.courseIds,
  });

  /// CourseListQuery를 API 요청에 사용할 Map으로 변환
  ///
  /// 빈 courseIds는 무시되어 filter_conditions에 포함되지 않습니다.
  Map<String, dynamic> toQuery() {
    final Map<String, dynamic> map = {
      'offset': offset,
      'count': count,
    };

    if (isRecommended != null) map['filter_is_recommended'] = isRecommended;
    if (isFree != null) map['filter_is_free'] = isFree;
    if (courseIds?.isNotEmpty ?? false) {
      map['filter_conditions'] = {
        'course_ids': courseIds,
      };
    }

    return map;
  }

  /// 필터 타입과 기본 파라미터로 CourseListQuery 생성
  ///
  /// [filterType]에 따라 적절한 필터링 파라미터가 설정됩니다.
  /// [enrolledCourseIds]가 null이거나 빈 리스트인 경우 enrolled 타입에서도 courseIds는 null이 됩니다.
  factory CourseListQuery.fromFilterType({
    required CourseFilterType filterType,
    int offset = 0,
    int count = ApiConstants.defaultPageSize,
    List<String>? enrolledCourseIds,
  }) {
    switch (filterType) {
      case CourseFilterType.recommended:
        return CourseListQuery(
          offset: offset,
          count: count,
          isRecommended: true,
        );
      case CourseFilterType.free:
        return CourseListQuery(
          offset: offset,
          count: count,
          isFree: true,
        );
      case CourseFilterType.enrolled:
        return CourseListQuery(
          offset: offset,
          count: count,
          courseIds:
              (enrolledCourseIds?.isEmpty ?? true) ? null : enrolledCourseIds,
        );
      case CourseFilterType.all:
        return CourseListQuery(
          offset: offset,
          count: count,
        );
    }
  }
}
