import 'dart:io';
import 'dart:async';

import 'package:edu_platform_demo/data/model/course.dart';
import 'package:edu_platform_demo/data/model/lecture.dart';
import 'package:edu_platform_demo/domain/repository/course_detail_repository.dart';
import 'package:edu_platform_demo/domain/repository/enrollment_repository.dart';
import 'package:edu_platform_demo/presentation/view_model/detail/course_detail_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([CourseDetailRepository, EnrollmentRepository])
import 'course_detail_view_model_test.mocks.dart';

void main() {
  late MockCourseDetailRepository mockDetailRepo;
  late MockEnrollmentRepository mockEnrollRepo;
  late CourseDetailViewModel viewModel;

  // 테스트용 더미 데이터
  final testCourse = Course(
    id: 1,
    title: '테스트 강좌',
    description: '# 마크다운 설명\n\n테스트 강좌입니다.',
    shortDescription: '테스트 강좌 짧은 설명',
    imageFileUrl: 'https://test.com/image.jpg',
    logoFileUrl: 'https://test.com/logo.jpg',
    taglist: ['테스트', '강좌'],
    isRecommended: true,
    isFree: true,
    isFavorite: true,
  );

  final testLectures = [
    Lecture(
      id: 1,
      title: '1강. 소개',
      description: '강좌 소개',
      orderNo: 1,
    ),
    Lecture(
      id: 2,
      title: '2강. 본론',
      description: '강좌 본론',
      orderNo: 2,
    ),
  ];

  setUp(() {
    mockDetailRepo = MockCourseDetailRepository();
    mockEnrollRepo = MockEnrollmentRepository();
    viewModel = CourseDetailViewModel(
      courseDetailRepository: mockDetailRepo,
      enrollmentRepository: mockEnrollRepo,
    );
  });

  group('loadCourseDetail 테스트', () {
    test('정상 케이스 - 모든 데이터가 성공적으로 로드됨', () async {
      // given
      when(mockDetailRepo.getCourse(1)).thenAnswer((_) async => testCourse);
      when(mockDetailRepo.getLectures(courseId: 1))
          .thenAnswer((_) async => testLectures);
      when(mockEnrollRepo.isEnrolled(1)).thenAnswer((_) async => true);

      // when
      await viewModel.loadCourseDetail(1);

      // then
      expect(viewModel.course, testCourse);
      expect(viewModel.lectures, testLectures);
      expect(viewModel.isEnrolled, true);
      expect(viewModel.isLoading, false);
      expect(viewModel.hasError, false);
      expect(viewModel.canRetry, false);
      expect(viewModel.lecturesLoadFailed, false);
    });

    test('네트워크 오류 - 강좌 정보 로드 실패', () async {
      // given
      when(mockDetailRepo.getCourse(1))
          .thenThrow(const SocketException('네트워크 오류'));

      // when
      await viewModel.loadCourseDetail(1);

      // then
      expect(viewModel.course, isNull);
      expect(viewModel.lectures, isEmpty);
      expect(viewModel.isLoading, false);
      expect(viewModel.hasError, true);
      expect(viewModel.errorMessage, '인터넷 연결을 확인해주세요.');
      expect(viewModel.canRetry, true);
    });

    test('타임아웃 - 강좌 정보 로드 실패', () async {
      // given
      when(mockDetailRepo.getCourse(1)).thenThrow(TimeoutException('타임아웃'));

      // when
      await viewModel.loadCourseDetail(1);

      // then
      expect(viewModel.course, isNull);
      expect(viewModel.hasError, true);
      expect(viewModel.errorMessage, '서버 응답이 지연되고 있어요. 잠시 후 다시 시도해주세요.');
      expect(viewModel.canRetry, true);
    });

    test('부분 실패 - 강좌 정보는 성공, 강의 목록 로드 실패', () async {
      // given
      when(mockDetailRepo.getCourse(1)).thenAnswer((_) async => testCourse);
      when(mockDetailRepo.getLectures(courseId: 1))
          .thenThrow(Exception('강의 목록 로드 실패'));
      when(mockEnrollRepo.isEnrolled(1)).thenAnswer((_) async => false);

      // when
      await viewModel.loadCourseDetail(1);

      // then
      expect(viewModel.course, testCourse);
      expect(viewModel.lectures, isEmpty);
      expect(viewModel.lecturesLoadFailed, true);
      expect(viewModel.hasError, false);
      expect(viewModel.isLoading, false);
    });

    test('부분 실패 - 수강 상태 확인 실패시 기본값 유지', () async {
      // given
      when(mockDetailRepo.getCourse(1)).thenAnswer((_) async => testCourse);
      when(mockDetailRepo.getLectures(courseId: 1))
          .thenAnswer((_) async => testLectures);
      when(mockEnrollRepo.isEnrolled(1)).thenThrow(Exception('수강 상태 확인 실패'));

      // when
      await viewModel.loadCourseDetail(1);

      // then
      expect(viewModel.course, testCourse);
      expect(viewModel.lectures, testLectures);
      expect(viewModel.isEnrolled, false); // 기본값 유지
      expect(viewModel.hasError, false);
      expect(viewModel.isLoading, false);
    });
  });

  group('toggleEnrollment 테스트', () {
    setUp(() async {
      // 기본 상태 설정을 위해 loadCourseDetail 호출
      when(mockDetailRepo.getCourse(1)).thenAnswer((_) async => testCourse);
      when(mockDetailRepo.getLectures(courseId: 1))
          .thenAnswer((_) async => testLectures);
      when(mockEnrollRepo.isEnrolled(1)).thenAnswer((_) async => false);
      await viewModel.loadCourseDetail(1);
    });

    test('수강 신청 성공', () async {
      // given
      when(mockEnrollRepo.toggleEnrollment(1)).thenAnswer((_) async => null);

      // when
      await viewModel.toggleEnrollment();

      // then
      expect(viewModel.isEnrolled, true);
      expect(viewModel.hasError, false);
      verify(mockEnrollRepo.toggleEnrollment(1)).called(1);
    });

    test('수강 취소 성공', () async {
      // given - 먼저 수강 신청 상태로 만들기
      when(mockEnrollRepo.toggleEnrollment(1)).thenAnswer((_) async => null);
      await viewModel.toggleEnrollment(); // 수강 신청

      // when
      await viewModel.toggleEnrollment(); // 수강 취소

      // then
      expect(viewModel.isEnrolled, false);
      expect(viewModel.hasError, false);
      verify(mockEnrollRepo.toggleEnrollment(1)).called(2);
    });

    test('네트워크 오류 발생', () async {
      // given
      when(mockEnrollRepo.toggleEnrollment(1))
          .thenThrow(const SocketException('네트워크 오류'));

      // when
      await viewModel.toggleEnrollment();

      // then
      expect(viewModel.isEnrolled, false); // 상태 변경 없음
      expect(viewModel.hasError, true);
      expect(viewModel.errorMessage, '인터넷 연결을 확인해주세요.');
    });

    test('타임아웃 발생', () async {
      // given
      when(mockEnrollRepo.toggleEnrollment(1))
          .thenThrow(TimeoutException('타임아웃'));

      // when
      await viewModel.toggleEnrollment();

      // then
      expect(viewModel.isEnrolled, false); // 상태 변경 없음
      expect(viewModel.hasError, true);
      expect(viewModel.errorMessage, '서버 응답이 지연되고 있어요. 잠시 후 다시 시도해주세요.');
    });
  });

  group('기타 기능 테스트', () {
    test('shouldShowMarkdown - 설명이 있는 경우', () async {
      // given
      when(mockDetailRepo.getCourse(1)).thenAnswer((_) async => testCourse);
      when(mockDetailRepo.getLectures(courseId: 1))
          .thenAnswer((_) async => testLectures);
      when(mockEnrollRepo.isEnrolled(1)).thenAnswer((_) async => false);

      // when
      await viewModel.loadCourseDetail(1);

      // then
      expect(viewModel.shouldShowMarkdown, true);
    });

    test('shouldShowMarkdown - 설명이 없는 경우', () async {
      // given
      final courseWithoutDesc = Course(
        id: 1,
        title: '설명 없는 강좌',
        description: '',
        shortDescription: '짧은 설명',
        imageFileUrl: 'image.jpg',
        logoFileUrl: 'logo.jpg',
        taglist: ['태그'],
        isRecommended: true,
        isFree: true,
        isFavorite: true,
      );
      when(mockDetailRepo.getCourse(1))
          .thenAnswer((_) async => courseWithoutDesc);
      when(mockDetailRepo.getLectures(courseId: 1))
          .thenAnswer((_) async => testLectures);
      when(mockEnrollRepo.isEnrolled(1)).thenAnswer((_) async => false);

      // when
      await viewModel.loadCourseDetail(1);

      // then
      expect(viewModel.shouldShowMarkdown, false);
    });

    test('clearError - 에러 상태 초기화', () async {
      // given - 에러 상태 만들기
      when(mockDetailRepo.getCourse(1))
          .thenThrow(const SocketException('네트워크 오류'));
      await viewModel.loadCourseDetail(1);
      expect(viewModel.hasError, true);
      expect(viewModel.canRetry, true);

      // when
      viewModel.clearError();

      // then
      expect(viewModel.hasError, false);
      expect(viewModel.errorMessage, isEmpty);
      expect(viewModel.canRetry, false);
    });

    test('reloadLectures - 강의 목록 재로드 성공', () async {
      // given - 먼저 강의 목록 로드 실패 상태 만들기
      when(mockDetailRepo.getCourse(1)).thenAnswer((_) async => testCourse);
      when(mockDetailRepo.getLectures(courseId: 1))
          .thenThrow(Exception('초기 로드 실패'));
      await viewModel.loadCourseDetail(1);
      expect(viewModel.lecturesLoadFailed, true);

      // when - 재로드 시도
      when(mockDetailRepo.getLectures(courseId: 1))
          .thenAnswer((_) async => testLectures);
      await viewModel.reloadLectures();

      // then
      expect(viewModel.lectures, testLectures);
      expect(viewModel.lecturesLoadFailed, false);
    });

    test('reloadLectures - 강의 목록 재로드 실패', () async {
      // given - 먼저 정상 상태로 만들기
      when(mockDetailRepo.getCourse(1)).thenAnswer((_) async => testCourse);
      when(mockDetailRepo.getLectures(courseId: 1))
          .thenAnswer((_) async => testLectures);
      await viewModel.loadCourseDetail(1);
      expect(viewModel.lectures, testLectures);

      // when - 재로드 실패
      when(mockDetailRepo.getLectures(courseId: 1))
          .thenThrow(Exception('재로드 실패'));
      await viewModel.reloadLectures();

      // then
      expect(viewModel.lectures, isEmpty);
      expect(viewModel.lecturesLoadFailed, true);
    });
  });
}
