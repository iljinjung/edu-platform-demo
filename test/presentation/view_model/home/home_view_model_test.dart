import 'dart:io';

import 'package:edu_platform_demo/core/constants/api_constants.dart';
import 'package:edu_platform_demo/data/model/course.dart';
import 'package:edu_platform_demo/domain/model/course_filter_type.dart';
import 'package:edu_platform_demo/domain/repository/course_list_repository.dart';
import 'package:edu_platform_demo/presentation/view_model/home/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([CourseListRepository])
import 'home_view_model_test.mocks.dart';

void main() {
  late MockCourseListRepository mockRepository;
  late HomeViewModel viewModel;

  setUp(() {
    mockRepository = MockCourseListRepository();
    viewModel = HomeViewModel(courseListRepository: mockRepository);
  });

  tearDown(() {
    viewModel.dispose();
  });

  group('HomeViewModel Tests', () {
    final testCourses = [
      Course(
        id: 1,
        title: 'Test Course 1',
        description: 'Description 1',
        shortDescription: 'Short Description 1',
        imageFileUrl: 'image1.jpg',
        logoFileUrl: 'logo1.jpg',
        taglist: ['tag1'],
      ),
      Course(
        id: 2,
        title: 'Test Course 2',
        description: 'Description 2',
        shortDescription: 'Short Description 2',
        imageFileUrl: 'image2.jpg',
        logoFileUrl: 'logo2.jpg',
        taglist: ['tag2'],
      ),
    ];

    test('초기 상태 테스트', () {
      expect(viewModel.enrolledCourses, isEmpty);
      expect(viewModel.isLoading.value, false);
      expect(viewModel.errorMessage.value, null);
      expect(viewModel.canRetry.value, false);
      expect(viewModel.hasNoEnrolledCourses, true);
    });

    test('수강 중인 강좌 로드 성공 테스트', () async {
      // Given
      when(mockRepository.getEnrolledCourses())
          .thenAnswer((_) async => testCourses);

      // When
      await viewModel.refreshAll();

      // Then
      expect(viewModel.enrolledCourses, equals(testCourses));
      expect(viewModel.hasNoEnrolledCourses, false);
      expect(viewModel.errorMessage.value, null);
      expect(viewModel.canRetry.value, false);
      verify(mockRepository.getEnrolledCourses()).called(1);
    });

    test('수강 중인 강좌 로드 실패 테스트', () async {
      // Given
      when(mockRepository.getEnrolledCourses())
          .thenThrow(const SocketException('네트워크 에러'));

      // When
      await viewModel.refreshAll();

      // Then
      expect(viewModel.enrolledCourses, isEmpty);
      expect(viewModel.hasNoEnrolledCourses, true);
      expect(viewModel.errorMessage.value, '인터넷 연결을 확인해주세요.');
      expect(viewModel.canRetry.value, true);
      verify(mockRepository.getEnrolledCourses()).called(1);
    });

    test('페이징 컨트롤러 동작 테스트', () async {
      // Given
      when(mockRepository.getEnrolledCourses()).thenAnswer((_) async => []);
      when(mockRepository.fetchCourses(
        filterType: CourseFilterType.recommended,
        offset: 0,
        count: ApiConstants.defaultPageSize,
      )).thenAnswer((_) async => testCourses);
      when(mockRepository.fetchCourses(
        filterType: CourseFilterType.free,
        offset: 0,
        count: ApiConstants.defaultPageSize,
      )).thenAnswer((_) async => testCourses);

      // When
      viewModel.onInit();
      viewModel.recommendedPagingController.notifyPageRequestListeners(0);
      viewModel.freePagingController.notifyPageRequestListeners(0);

      // Then
      await untilCalled(mockRepository.fetchCourses(
        filterType: CourseFilterType.recommended,
        offset: 0,
        count: ApiConstants.defaultPageSize,
      ));

      await untilCalled(mockRepository.fetchCourses(
        filterType: CourseFilterType.free,
        offset: 0,
        count: ApiConstants.defaultPageSize,
      ));

      verify(mockRepository.fetchCourses(
        filterType: CourseFilterType.recommended,
        offset: 0,
        count: ApiConstants.defaultPageSize,
      )).called(1);
      verify(mockRepository.fetchCourses(
        filterType: CourseFilterType.free,
        offset: 0,
        count: ApiConstants.defaultPageSize,
      )).called(1);

      expect(
          viewModel.recommendedPagingController.itemList, equals(testCourses));
      expect(viewModel.freePagingController.itemList, equals(testCourses));
      expect(viewModel.errorMessage.value, isNull);
    });

    test('추천 강좌 첫 페이지 로드 테스트', () async {
      // Given
      when(mockRepository.getEnrolledCourses()).thenAnswer((_) async => []);
      when(mockRepository.fetchCourses(
        filterType: CourseFilterType.recommended,
        offset: 0,
        count: ApiConstants.defaultPageSize,
      )).thenAnswer((_) async => testCourses);

      // When
      viewModel.onInit();
      viewModel.recommendedPagingController.notifyPageRequestListeners(0);

      // Then
      await untilCalled(mockRepository.fetchCourses(
        filterType: CourseFilterType.recommended,
        offset: 0,
        count: ApiConstants.defaultPageSize,
      ));

      verify(mockRepository.fetchCourses(
        filterType: CourseFilterType.recommended,
        offset: 0,
        count: ApiConstants.defaultPageSize,
      )).called(1);

      expect(viewModel.recommendedPagingController.error, isNull);
      expect(
          viewModel.recommendedPagingController.itemList, equals(testCourses));
      expect(viewModel.errorMessage.value, isNull);
    });

    test('무료 강좌 첫 페이지 로드 테스트', () async {
      // Given
      when(mockRepository.getEnrolledCourses()).thenAnswer((_) async => []);
      when(mockRepository.fetchCourses(
        filterType: CourseFilterType.free,
        offset: 0,
        count: ApiConstants.defaultPageSize,
      )).thenAnswer((_) async => testCourses);

      // When
      viewModel.onInit();
      viewModel.freePagingController.notifyPageRequestListeners(0);

      // Then
      await untilCalled(mockRepository.fetchCourses(
        filterType: CourseFilterType.free,
        offset: 0,
        count: ApiConstants.defaultPageSize,
      ));

      verify(mockRepository.fetchCourses(
        filterType: CourseFilterType.free,
        offset: 0,
        count: ApiConstants.defaultPageSize,
      )).called(1);

      expect(viewModel.freePagingController.error, isNull);
      expect(viewModel.freePagingController.itemList, equals(testCourses));
      expect(viewModel.errorMessage.value, isNull);
    });

    test('추천 강좌 페이지 요청 테스트', () async {
      // Given
      when(mockRepository.getEnrolledCourses()).thenAnswer((_) async => []);
      when(mockRepository.fetchCourses(
        filterType: CourseFilterType.recommended,
        offset: 0,
        count: ApiConstants.defaultPageSize,
      )).thenAnswer((_) async => testCourses);

      // When
      viewModel.onInit();
      viewModel.recommendedPagingController.notifyPageRequestListeners(0);

      // Then
      await untilCalled(mockRepository.fetchCourses(
        filterType: CourseFilterType.recommended,
        offset: 0,
        count: ApiConstants.defaultPageSize,
      ));

      verify(mockRepository.fetchCourses(
        filterType: CourseFilterType.recommended,
        offset: 0,
        count: ApiConstants.defaultPageSize,
      )).called(1);
    });

    test('무료 강좌 페이지 요청 테스트', () async {
      // Given
      when(mockRepository.getEnrolledCourses()).thenAnswer((_) async => []);
      when(mockRepository.fetchCourses(
        filterType: CourseFilterType.free,
        offset: 0,
        count: ApiConstants.defaultPageSize,
      )).thenAnswer((_) async => testCourses);

      // When
      viewModel.onInit();
      viewModel.freePagingController.notifyPageRequestListeners(0);

      // Then
      await untilCalled(mockRepository.fetchCourses(
        filterType: CourseFilterType.free,
        offset: 0,
        count: ApiConstants.defaultPageSize,
      ));

      verify(mockRepository.fetchCourses(
        filterType: CourseFilterType.free,
        offset: 0,
        count: ApiConstants.defaultPageSize,
      )).called(1);
    });
  });
}
