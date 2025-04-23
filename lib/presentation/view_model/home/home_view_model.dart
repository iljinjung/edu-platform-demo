import 'dart:async';
import 'dart:io';
import 'dart:developer' as dev;

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/foundation.dart';

import '../../../core/constants/api_constants.dart';
import '../../../data/model/course.dart';
import '../../../domain/model/course_filter_type.dart';
import '../../../domain/repository/course_list_repository.dart';

/// 홈 화면의 상태를 관리하는 ViewModel
///
/// 주요 기능:
/// - 추천/무료 강좌 무한 스크롤
/// - 수강 중인 강좌 목록 표시
/// - 에러 상태 관리 및 처리
class HomeViewModel extends GetxController {
  /// 강좌 목록 조회를 위한 Repository
  final CourseListRepository courseListRepository;

  /// 생성자
  ///
  /// [courseListRepository]는 필수로 주입받아야 합니다.
  HomeViewModel({
    required this.courseListRepository,
  });

  /// 추천 강좌 페이징 컨트롤러
  ///
  /// 무한 스크롤을 위한 상태 관리
  /// [firstPageKey]는 0부터 시작하여 [ApiConstants.defaultPageSize] 단위로 증가
  final PagingController<int, Course> recommendedPagingController =
      PagingController(firstPageKey: 0);

  /// 무료 강좌 페이징 컨트롤러
  ///
  /// 무한 스크롤을 위한 상태 관리
  /// [firstPageKey]는 0부터 시작하여 [ApiConstants.defaultPageSize] 단위로 증가
  final PagingController<int, Course> freePagingController =
      PagingController(firstPageKey: 0);

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

  /// 재시도 가능 여부
  ///
  /// true일 경우 재시도 버튼을 표시
  final RxBool canRetry = false.obs;

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

  @override
  void onInit() {
    super.onInit();
    _initPagingControllers();

    _fetchCourses(
      0,
      CourseFilterType.free,
      freePagingController,
    );

    _fetchCourses(
      0,
      CourseFilterType.recommended,
      recommendedPagingController,
    );

    _loadEnrolledCourses();
  }

  @override
  void onClose() {
    recommendedPagingController.dispose();
    freePagingController.dispose();
    super.onClose();
  }

  /// 페이징 컨트롤러 초기화
  ///
  /// 각 카테고리(추천, 무료)별 페이지 요청 리스너 등록
  /// 스크롤이 끝에 도달하면 자동으로 다음 페이지 요청
  void _initPagingControllers() {
    recommendedPagingController.addPageRequestListener((pageKey) {
      _fetchCourses(
        pageKey,
        CourseFilterType.recommended,
        recommendedPagingController,
      );
    });

    freePagingController.addPageRequestListener((pageKey) {
      _fetchCourses(
        pageKey,
        CourseFilterType.free,
        freePagingController,
      );
    });
  }

  /// 강좌 목록 조회
  ///
  /// [pageKey]: 페이지 시작 위치 (offset)
  /// [filterType]: 강좌 필터 타입 (추천/무료)
  /// [controller]: 결과를 저장할 페이징 컨트롤러
  ///
  /// API 호출 결과를 페이징 컨트롤러에 추가하고,
  /// 마지막 페이지 여부를 판단하여 처리
  Future<void> _fetchCourses(
    int pageKey,
    CourseFilterType filterType,
    PagingController<int, Course> controller,
  ) async {
    try {
      dev.log(
          'HomeViewModel._fetchCourses 시작 - pageKey: $pageKey, filterType: $filterType');
      dev.log('현재 컨트롤러 상태 - itemList: ${controller.itemList?.length ?? 0}개');

      // 네트워크 연결 확인
      if (!_isConnected.value) {
        dev.log('HomeViewModel._fetchCourses - 네트워크 연결 없음');
        throw const SocketException('인터넷 연결을 확인해주세요.');
      }

      final courses = await courseListRepository.fetchCourses(
        filterType: filterType,
        offset: pageKey,
        count: ApiConstants.defaultPageSize,
      );

      dev.log('HomeViewModel._fetchCourses - 강좌 데이터 수신: ${courses.length}개');
      if (courses.isNotEmpty) {
        // dev.log(
        //     'HomeViewModel._fetchCourses - 첫 번째 강좌 데이터: ${courses.first.toJson()}');
        // dev.log(
        //     'HomeViewModel._fetchCourses - 마지막 강좌 데이터: ${courses.last.toJson()}');
      }

      final isLastPage = courses.length < ApiConstants.defaultPageSize;
      if (isLastPage) {
        dev.log('HomeViewModel._fetchCourses - 마지막 페이지 도달');
        controller.appendLastPage(courses);
      } else {
        // dev.log(
        //     'HomeViewModel._fetchCourses - 다음 페이지 있음, 다음 pageKey: ${pageKey + ApiConstants.defaultPageSize}');
        controller.appendPage(
          courses,
          pageKey + ApiConstants.defaultPageSize,
        );
      }

      dev.log(
          '컨트롤러 업데이트 후 상태 - itemList: ${controller.itemList?.length ?? 0}개');

      // 성공 시 에러 상태 초기화
      errorMessage.value = null;
      canRetry.value = false;
      _isConnected.value = true;
    } on SocketException catch (e) {
      dev.log('HomeViewModel._fetchCourses - SocketException 발생', error: e);
      _handleError(
        controller: controller,
        message: '인터넷 연결을 확인해주세요.',
        error: e,
        canRetry: true,
      );
      _isConnected.value = false;
    } on TimeoutException catch (e) {
      dev.log('HomeViewModel._fetchCourses - TimeoutException 발생', error: e);
      _handleError(
        controller: controller,
        message: '서버 응답이 지연되고 있어요. 잠시 후 다시 시도해주세요.',
        error: e,
        canRetry: true,
      );
    } catch (error) {
      dev.log('HomeViewModel._fetchCourses - 예상치 못한 에러 발생', error: error);
      _handleError(
        controller: controller,
        message: '강좌 목록을 불러오지 못했어요. 잠시 후 다시 시도해주세요.',
        error: error,
      );
    }
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
      errorMessage.value = null;
      canRetry.value = false;
      _isConnected.value = true;
    } on SocketException catch (e) {
      dev.log('HomeViewModel._loadEnrolledCourses - SocketException 발생',
          error: e);
      errorMessage.value = '인터넷 연결을 확인해주세요.';
      _isConnected.value = false;
      print('Error loading enrolled courses: $e');
      canRetry.value = true;
    } on TimeoutException catch (e) {
      dev.log('HomeViewModel._loadEnrolledCourses - TimeoutException 발생',
          error: e);
      errorMessage.value = '서버 응답이 지연되고 있어요. 잠시 후 다시 시도해주세요.';
      print('Error loading enrolled courses: $e');
      canRetry.value = true;
    } catch (error) {
      dev.log('HomeViewModel._loadEnrolledCourses - 예상치 못한 에러 발생',
          error: error);
      errorMessage.value = '내 학습 강좌를 불러오지 못했어요.';
      print('Error loading enrolled courses: $error');
      canRetry.value = true;
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
    errorMessage.value = null;
    canRetry.value = false;
    recommendedPagingController.refresh();
    freePagingController.refresh();
    await _loadEnrolledCourses();
    dev.log('HomeViewModel.refreshAll 종료');
  }

  /// 에러 처리를 위한 헬퍼 메서드
  ///
  /// [controller]: 에러를 설정할 페이징 컨트롤러
  /// [message]: 사용자에게 표시할 에러 메시지
  /// [error]: 발생한 에러 객체 (로깅용)
  /// [canRetry]: 재시도 가능 여부
  void _handleError({
    required PagingController<int, Course> controller,
    required String message,
    required Object error,
    bool canRetry = false,
  }) {
    dev.log('HomeViewModel._handleError',
        error: error,
        name: 'HomeViewModel',
        stackTrace: error is Error ? error.stackTrace : null);

    controller.error = error;
    errorMessage.value = message;
    this.canRetry.value = canRetry;
    print('Error fetching courses: $error');
  }

  /// 수강 중인 강좌 목록을 새로고침합니다.
  Future<void> refreshEnrolledCourses() async {
    debugPrint('코스 아이디: 수강 중인 강좌 목록 새로고침 시작');
    await _loadEnrolledCourses();
    debugPrint('코스 아이디: 수강 중인 강좌 목록 새로고침 완료');
  }
}
