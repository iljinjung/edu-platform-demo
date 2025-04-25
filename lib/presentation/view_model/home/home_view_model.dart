import 'dart:async';
import 'dart:io';
import 'dart:developer' as dev;

import 'package:edu_platform_demo/data/model/course.dart';
import 'package:edu_platform_demo/domain/model/course_filter_type.dart';
import 'package:edu_platform_demo/domain/repository/course_list_repository.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/foundation.dart';

import 'error_state.dart';
import 'search_state.dart';
import 'course_paging_state.dart';
import 'error_handler.dart';

/// 홈 화면의 상태를 관리하는 ViewModel
///
/// 주요 기능:
/// - 추천/무료 강좌 무한 스크롤
/// - 수강 중인 강좌 목록 표시
/// - 에러 상태 관리 및 처리
class HomeViewModel extends GetxController {
  /// 강좌 목록 조회를 위한 Repository
  final CourseListRepository courseListRepository;

  /// 검색 상태 관리
  final _searchState = SearchState().obs;
  bool get isSearchEnabled => _searchState.value.isEnabled;

  /// 추천 강좌 페이징 상태
  late final CoursePagingState _recommendedPagingState;
  PagingController<int, Course> get recommendedPagingController =>
      _recommendedPagingState.pagingController;

  /// 무료 강좌 페이징 상태
  late final CoursePagingState _freePagingState;
  PagingController<int, Course> get freePagingController =>
      _freePagingState.pagingController;

  /// 수강 중인 강좌 목록
  ///
  /// GetX의 [RxList]를 사용하여 반응형으로 상태 관리
  /// 목록이 변경되면 UI가 자동으로 업데이트됨
  final RxList<Course> enrolledCourses = <Course>[].obs;

  /// 로딩 상태
  ///
  /// true일 경우 로딩 중, false일 경우 로딩 완료
  /// 주로 수강 중인 강좌 목록 로딩 시 사용
  final RxBool isLoading = false.obs;

  /// 에러 메시지
  ///
  /// UI에서 표시할 사용자 친화적인 에러 메시지
  /// null이면 에러가 없는 상태
  final RxnString errorMessage = RxnString();

  /// 네트워크 연결 상태 (내부용)
  ///
  /// 네트워크 에러 발생 시 false로 설정되며,
  /// 성공적인 API 호출 시 true로 복원됨
  final _isConnected = true.obs;

  /// 수강 중인 강좌가 없는 상태
  ///
  /// 로딩 중이 아니고 수강 중인 강좌 목록이 비어있을 때 true
  bool get hasNoEnrolledCourses => !isLoading.value && enrolledCourses.isEmpty;

  /// 에러 처리
  final _errorHandler = ErrorHandler();
  ErrorState? get currentError => _errorHandler.currentError.value;

  /// 생성자
  ///
  /// [courseListRepository]는 필수로 주입받아야 합니다.
  HomeViewModel({
    required this.courseListRepository,
  }) {
    _initPagingStates();
  }

  @override
  void onInit() {
    super.onInit();
    _loadEnrolledCourses();
  }

  @override
  void onClose() {
    _recommendedPagingState.dispose();
    _freePagingState.dispose();
    super.onClose();
  }

  /// 페이징 상태 초기화
  void _initPagingStates() {
    _recommendedPagingState = CoursePagingState(
      repository: courseListRepository,
      filterType: CourseFilterType.recommended,
      onError: _errorHandler.handleError,
      onConnectionChanged: (isConnected) => _isConnected.value = isConnected,
    );

    _freePagingState = CoursePagingState(
      repository: courseListRepository,
      filterType: CourseFilterType.free,
      onError: _errorHandler.handleError,
      onConnectionChanged: (isConnected) => _isConnected.value = isConnected,
    );
  }

  /// 수강 중인 강좌 목록 로드
  ///
  /// [enrolledCourses]를 최신 데이터로 업데이트
  /// 로딩 상태를 [isLoading]으로 표시
  Future<void> _loadEnrolledCourses() async {
    try {
      dev.log('HomeViewModel._loadEnrolledCourses 시작');
      isLoading(true);

      if (!_isConnected.value) {
        dev.log('HomeViewModel._loadEnrolledCourses - 네트워크 연결 없음');
        throw const SocketException('인터넷 연결을 확인해주세요.');
      }

      final courses = await courseListRepository.getEnrolledCourses();
      debugPrint('코스 아이디: 수강 중인 강좌 목록 요청 완료 - 총 ${courses.length}개');
      for (var course in courses) {
        debugPrint('코스 아이디: 수강 중인 강좌 - courseId: ${course.id}');
      }

      enrolledCourses.assignAll(courses);
      debugPrint('코스 아이디: 수강 중인 강좌 목록 업데이트 완료');
      _errorHandler.clearError();
      _isConnected.value = true;
    } on SocketException catch (e) {
      dev.log('HomeViewModel._loadEnrolledCourses - SocketException 발생',
          error: e);
      _isConnected.value = false;

      _errorHandler.handleError(ErrorState(
        message: '인터넷 연결을 확인해주세요.',
        canRetry: true,
        onRetry: () => _loadEnrolledCourses(),
      ));
    } on TimeoutException catch (e) {
      dev.log('HomeViewModel._loadEnrolledCourses - TimeoutException 발생',
          error: e);

      _errorHandler.handleError(ErrorState(
        message: '서버 응답이 지연되고 있어요. 잠시 후 다시 시도해주세요.',
        canRetry: true,
        onRetry: () => _loadEnrolledCourses(),
      ));
    } catch (error) {
      dev.log('HomeViewModel._loadEnrolledCourses - 예상치 못한 에러 발생',
          error: error);

      _errorHandler.handleError(ErrorState(
        message: '내 학습 강좌를 불러오지 못했어요.',
        canRetry: true,
        onRetry: () => _loadEnrolledCourses(),
      ));
    } finally {
      isLoading(false);
      dev.log(
          'HomeViewModel._loadEnrolledCourses 종료 - isLoading: ${isLoading.value}');
    }
  }

  /// 모든 강좌 목록 새로고침
  ///
  /// - 추천 강좌 목록
  /// - 무료 강좌 목록
  /// - 수강 중인 강좌 목록
  /// - 네트워크 상태 초기화
  Future<void> refreshAll() async {
    dev.log('HomeViewModel.refreshAll 시작');
    _errorHandler.clearError();
    recommendedPagingController.refresh();
    freePagingController.refresh();
    await _loadEnrolledCourses();
    dev.log('HomeViewModel.refreshAll 종료');
  }

  /// 수강 중인 강좌 목록을 새로고침합니다.
  Future<void> refreshEnrolledCourses() async {
    debugPrint('코스 아이디: 수강 중인 강좌 목록 새로고침 시작');
    await _loadEnrolledCourses();
    debugPrint('코스 아이디: 수강 중인 강좌 목록 새로고침 완료');
  }

  /// 검색 버튼 클릭 처리
  Future<void> handleSearchTap() async {
    await _searchState.value.handleSearchTap();
    _searchState.refresh();
  }

  /// 에러 상태 초기화
  void clearError() {
    _errorHandler.clearError();
  }
}
