class ApiConstants {
  static const String baseUrl =
      'https://api-rest.elice.io/org/academy'; // API 기본 URL로 변경 필요

  // API Endpoints
  static const String courseList = '/course/list/';
  static const String courseGet = '/course/get/';
  static const String lectureList = '/lecture/list/';

  // API Parameters
  static const String courseId = 'course_id';
  static const String offset = 'offset';
  static const String count = 'count';

  // Pagination
  static const int defaultPageSize = 10;
}
