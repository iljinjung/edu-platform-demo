import 'dart:io';

import 'package:edu_platform_demo/core/constants/api_constants.dart';
import 'package:edu_platform_demo/domain/model/course.dart';
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

  final testCourses = [
    Course(
      id: 1,
      title: 'Test Course 1',
      description: 'Description 1',
      shortDescription: 'Short Description 1',
      imageFileUrl: 'image1.jpg',
      logoFileUrl: 'logo1.jpg',
      taglist: ['tag1'],
      isRecommended: true,
      isFree: true,
      isFavorite: true,
    ),
    Course(
      id: 2,
      title: 'Test Course 2',
      description: 'Description 2',
      shortDescription: 'Short Description 2',
      imageFileUrl: 'image2.jpg',
      logoFileUrl: 'logo2.jpg',
      taglist: ['tag2'],
      isRecommended: true,
      isFree: true,
      isFavorite: true,
    ),
  ];

  setUp(() {
    mockRepository = MockCourseListRepository();

    // 기본 stub 설정
    when(mockRepository.fetchCourses(
      filterType: anyNamed('filterType'),
      offset: anyNamed('offset'),
      count: anyNamed('count'),
    )).thenAnswer((_) async => testCourses);

    when(mockRepository.getEnrolledCourses()).thenAnswer((_) async => []);

    viewModel = HomeViewModel(courseListRepository: mockRepository);
  });

  tearDown(() {
    viewModel.dispose();
  });

  group('HomeViewModel Tests', () {
    test('수강 중인 강좌 로드 성공 테스트', () async {
      // Given
      when(mockRepository.getEnrolledCourses())
          .thenAnswer((_) async => testCourses);

      // When
      await viewModel.refreshAll();

      // Then
      expect(viewModel.enrolledCourses, equals(testCourses));
      expect(viewModel.hasNoEnrolledCourses, false);
      expect(viewModel.currentError, isNull);
    });

    test('수강 중인 강좌 로드 실패 - 네트워크 에러 테스트', () async {
      // Given
      when(mockRepository.getEnrolledCourses())
          .thenThrow(const SocketException('네트워크 에러'));

      // When
      await viewModel.refreshAll();

      // Then
      expect(viewModel.enrolledCourses, isEmpty);
      expect(viewModel.hasNoEnrolledCourses, true);
      expect(viewModel.currentError?.message, '인터넷 연결을 확인해주세요.');
      expect(viewModel.currentError?.canRetry, true);
    });

    test('에러 상태 초기화 테스트', () async {
      // Given - 먼저 에러 상태 발생시키기
      when(mockRepository.getEnrolledCourses())
          .thenThrow(const SocketException('네트워크 에러'));
      await viewModel.refreshAll();

      // When
      viewModel.clearError();

      // Then
      expect(viewModel.currentError, isNull);
    });

    test('수강 중인 강좌 새로고침 테스트', () async {
      // Given
      when(mockRepository.getEnrolledCourses())
          .thenAnswer((_) async => testCourses);

      // When
      await viewModel.refreshEnrolledCourses();

      // Then
      expect(viewModel.enrolledCourses, equals(testCourses));
      expect(viewModel.currentError, isNull);
    });
  });
}
