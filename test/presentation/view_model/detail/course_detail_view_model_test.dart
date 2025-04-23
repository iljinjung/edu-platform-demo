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

  group('기타 기능 테스트', () {
    test('shouldShowMarkdown - 마크다운 HTML이 있는 경우', () async {
      // given
      final courseWithMarkdown = Course(
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
        markdownHtml: '<h1>마크다운 HTML</h1>',
      );
      when(mockDetailRepo.getCourse(1))
          .thenAnswer((_) async => courseWithMarkdown);
      when(mockDetailRepo.getLectures(courseId: 1))
          .thenAnswer((_) async => testLectures);
      when(mockEnrollRepo.isEnrolled(1)).thenAnswer((_) async => false);

      // when
      await viewModel.loadCourseDetail(1);

      // then
      expect(viewModel.shouldShowMarkdown, true);
    });

    test('shouldShowMarkdown - 마크다운 HTML이 없는 경우', () async {
      // given
      final courseWithoutMarkdown = Course(
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
        markdownHtml: '',
      );
      when(mockDetailRepo.getCourse(1))
          .thenAnswer((_) async => courseWithoutMarkdown);
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
      when(mockDetailRepo.getCourse(1)).thenThrow(Exception('에러 발생'));

      // when
      await viewModel.loadCourseDetail(1);
      viewModel.clearError();

      // then
      expect(viewModel.hasError, false);
      expect(viewModel.errorMessage, '');
    });
  });
}
