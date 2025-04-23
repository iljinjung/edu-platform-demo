import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:edu_platform_demo/data/model/course.dart';
import 'package:edu_platform_demo/data/model/lecture.dart';
import 'package:edu_platform_demo/domain/repository/course_detail_repository.dart';
import 'package:edu_platform_demo/domain/repository/enrollment_repository.dart';

/// 강좌 상세 화면의 비즈니스 로직을 담당하는 ViewModel
///
/// 주요 기능:
/// - 강좌 상세 정보 로드 및 표시
/// - 강의 목록 관리
/// - 수강 신청/취소 기능
/// - 에러 처리 및 재시도 기능
class CourseDetailViewModel extends GetxController {
  /// 생성자
  ///
  /// [courseDetailRepository]와 [enrollmentRepository]는 필수 의존성입니다.
  CourseDetailViewModel({
    required this.courseDetailRepository,
    required this.enrollmentRepository,
  });

  /// 강좌 상세 정보와 강의 목록을 조회하는 repository
  final CourseDetailRepository courseDetailRepository;

  /// 수강 신청 상태를 관리하는 repository
  final EnrollmentRepository enrollmentRepository;

  // 상태 관리를 위한 Rx 변수들
  /// 현재 조회 중인 강좌 정보
  final _course = Rx<Course?>(null);

  /// 강좌에 포함된 강의 목록
  final _lectures = RxList<Lecture>([]);

  /// 현재 사용자의 수강 신청 상태
  final _isEnrolled = RxBool(false);

  /// 초기 수강 신청 상태 (뒤로가기 시 변경 여부 확인용)
  bool initialEnrollmentState = false;

  /// 데이터 로딩 상태
  final _isLoading = RxBool(false);

  /// 에러 발생 여부
  final _hasError = RxBool(false);

  /// 에러 메시지
  final _errorMessage = RxString('');

  /// 작업 재시도 가능 여부
  final _canRetry = RxBool(false);

  /// 강의 목록 로드 실패 여부
  final _lecturesLoadFailed = RxBool(false);

  /// 수강 신청 중인지 여부
  final _isEnrolling = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null && arguments['courseId'] != null) {
      final courseId = arguments['courseId'] as int;
      loadCourseDetail(courseId);
    } else {
      _hasError.value = true;
      _errorMessage.value = '강좌 ID가 전달되지 않았습니다.';
    }
  }

  // Getters
  /// 현재 조회 중인 강좌 정보
  Course? get course => _course.value;

  /// 강좌에 포함된 강의 목록
  List<Lecture> get lectures => _lectures;

  /// 현재 사용자의 수강 신청 상태
  bool get isEnrolled => _isEnrolled.value;

  /// 수강 신청 중인지 여부
  bool get isEnrolling => _isEnrolling.value;

  /// 데이터 로딩 상태
  bool get isLoading => _isLoading.value;

  /// 에러 발생 여부
  bool get hasError => _hasError.value;

  /// 작업 재시도 가능 여부
  bool get canRetry => _canRetry.value;

  /// 강의 목록 로드 실패 여부
  bool get lecturesLoadFailed => _lecturesLoadFailed.value;

  /// 에러 메시지
  String get errorMessage => _errorMessage.value;

  /// 강좌 설명의 Markdown 표시 여부
  ///
  /// 설명이 비어있지 않은 경우에만 true를 반환합니다.
  bool get shouldShowMarkdown => course?.markdownHtml?.isNotEmpty ?? false;

  /// 강좌 상세 정보를 로드합니다.
  ///
  /// [courseId]에 해당하는 강좌의 상세 정보, 강의 목록, 수강 상태를 조회합니다.
  /// 각 데이터는 독립적으로 로드되며, 강좌 정보 로드 실패 시에만 전체 실패로 처리됩니다.
  ///
  /// 에러 발생 시:
  /// - 네트워크 연결 문제
  /// - 서버 응답 지연
  /// - 기타 오류
  /// 각각에 대해 적절한 에러 메시지를 표시하고, 재시도 가능 여부를 설정합니다.
  Future<void> loadCourseDetail(int courseId) async {
    _isLoading.value = true;
    _hasError.value = false;
    _errorMessage.value = '';
    _canRetry.value = false;
    _lecturesLoadFailed.value = false;

    // 1. 강좌 정보 로드 - 실패 시 전체 실패로 처리
    try {
      final course = await courseDetailRepository.getCourse(courseId);
      _course.value = course;
      debugPrint('Course 모델: $course');
    } on SocketException {
      _hasError.value = true;
      _errorMessage.value = '인터넷 연결을 확인해주세요.';
      _canRetry.value = true;
      _isLoading.value = false;
      return;
    } on TimeoutException {
      _hasError.value = true;
      _errorMessage.value = '서버 응답이 지연되고 있어요. 잠시 후 다시 시도해주세요.';
      _canRetry.value = true;
      _isLoading.value = false;
      return;
    } catch (e) {
      _hasError.value = true;
      _errorMessage.value = '강좌 정보를 불러오는데 실패했습니다.';
      _canRetry.value = true;
      _isLoading.value = false;
      return;
    }

    // 2. 강의 목록 로드 - 실패해도 계속 진행
    try {
      final lectures =
          await courseDetailRepository.getLectures(courseId: courseId);
      _lectures.assignAll(lectures);
    } catch (e) {
      _lecturesLoadFailed.value = true;
      _lectures.clear();
    }

    // 3. 수강 상태 확인 - 실패해도 계속 진행
    try {
      await _checkEnrollmentStatus();
    } catch (e) {
      // 수강 상태 확인 실패 시 기본값 false 유지
    }

    _isLoading.value = false;
  }

  /// 수강 신청 상태를 토글합니다.
  ///
  /// 현재 수강 중이면 수강 취소, 수강 중이 아니면 수강 신청으로 처리됩니다.
  /// 네트워크 오류나 서버 응답 지연 등의 문제 발생 시 적절한 에러 메시지를 표시합니다.
  Future<void> toggleEnrollment() async {
    if (course == null || _isEnrolling.value) return;

    _isEnrolling.value = true;
    await enrollmentRepository.toggleEnrollment(course!.id);
    _isEnrolled.value = await enrollmentRepository.isEnrolled(course!.id);
    _isEnrolling.value = false;
  }

  /// 에러 상태를 초기화합니다.
  ///
  /// 에러 메시지를 지우고 재시도 가능 상태를 false로 설정합니다.
  void clearError() {
    _hasError.value = false;
    _errorMessage.value = '';
    _canRetry.value = false;
  }

  /// 강의 목록만 다시 로드합니다.
  ///
  /// 강의 목록 로드에 실패한 경우 사용할 수 있습니다.
  /// 실패 시 강의 목록을 비우고 실패 상태를 true로 설정합니다.
  Future<void> reloadLectures() async {
    if (course == null) return;

    try {
      final lectures =
          await courseDetailRepository.getLectures(courseId: course!.id);
      _lectures.assignAll(lectures);
      _lecturesLoadFailed.value = false;
    } catch (e) {
      _lecturesLoadFailed.value = true;
      _lectures.clear();
    }
  }

  Future<void> _checkEnrollmentStatus() async {
    if (course == null) return;

    final wasInitialCheck = _isEnrolled.value == false && _isLoading.value;
    _isEnrolled.value = await enrollmentRepository.isEnrolled(course!.id);

    // 최초 로드 시에만 초기 상태 저장
    if (wasInitialCheck) {
      initialEnrollmentState = _isEnrolled.value;
    }
  }

  void setCourse(Course course) {
    _course.value = course;
    _checkEnrollmentStatus();
  }
}
