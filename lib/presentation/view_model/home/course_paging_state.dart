import 'dart:async';
import 'dart:io';
import 'dart:developer' as dev;

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/foundation.dart';

import 'package:edu_platform_demo/core/constants/api_constants.dart';
import 'package:edu_platform_demo/data/model/course.dart';
import 'package:edu_platform_demo/domain/model/course_filter_type.dart';
import 'package:edu_platform_demo/domain/repository/course_list_repository.dart';
import 'error_state.dart';

/// 강좌 목록의 페이징 상태를 관리하는 클래스
class CoursePagingState {
  /// 강좌 목록 조회를 위한 Repository
  final CourseListRepository repository;

  /// 강좌 필터 타입 (추천/무료)
  final CourseFilterType filterType;

  /// 페이징 컨트롤러
  final PagingController<int, Course> pagingController;

  /// 에러 콜백
  final void Function(ErrorState error)? onError;

  /// 네트워크 연결 상태 콜백
  final void Function(bool isConnected)? onConnectionChanged;

  /// 생성자
  CoursePagingState({
    required this.repository,
    required this.filterType,
    this.onError,
    this.onConnectionChanged,
  }) : pagingController = PagingController(firstPageKey: 0) {
    pagingController.addPageRequestListener(_fetchPage);
  }

  /// 페이지 데이터 로드
  Future<void> _fetchPage(int pageKey) async {
    try {
      dev.log(
          'CoursePagingState._fetchPage 시작 - pageKey: $pageKey, filterType: $filterType');

      final courses = await repository.fetchCourses(
        filterType: filterType,
        offset: pageKey,
        count: ApiConstants.defaultPageSize,
      );

      dev.log('CoursePagingState._fetchPage - 강좌 데이터 수신: ${courses.length}개');

      final isLastPage = courses.length < ApiConstants.defaultPageSize;
      if (isLastPage) {
        dev.log('CoursePagingState._fetchPage - 마지막 페이지 도달');
        pagingController.appendLastPage(courses);
      } else {
        pagingController.appendPage(
          courses,
          pageKey + ApiConstants.defaultPageSize,
        );
      }

      onConnectionChanged?.call(true);
    } on SocketException catch (e) {
      dev.log('CoursePagingState._fetchPage - SocketException 발생', error: e);
      onConnectionChanged?.call(false);

      final error = ErrorState(
        message: '인터넷 연결을 확인해주세요.',
        canRetry: true,
        onRetry: () => pagingController.refresh(),
      );
      onError?.call(error);
      pagingController.error = e;
    } on TimeoutException catch (e) {
      dev.log('CoursePagingState._fetchPage - TimeoutException 발생', error: e);

      final error = ErrorState(
        message: '서버 응답이 지연되고 있어요. 잠시 후 다시 시도해주세요.',
        canRetry: true,
        onRetry: () => pagingController.refresh(),
      );
      onError?.call(error);
      pagingController.error = e;
    } catch (e) {
      dev.log('CoursePagingState._fetchPage - 예상치 못한 에러 발생', error: e);

      final error = ErrorState(
        message: '강좌 목록을 불러오지 못했어요. 잠시 후 다시 시도해주세요.',
        canRetry: false,
        onRetry: () {},
      );
      onError?.call(error);
      pagingController.error = e;
    }
  }

  /// 리소스 해제
  void dispose() {
    pagingController.dispose();
  }
}
