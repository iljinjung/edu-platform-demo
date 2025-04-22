import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:edu_platform_demo/core/constants/api_constants.dart';
import 'package:edu_platform_demo/data/repository_implements/course_detail_repository_impl.dart';
import 'package:edu_platform_demo/data/source/remote/course_remote_source.dart';
import 'package:edu_platform_demo/data/source/remote/lecture_remote_source.dart';

@GenerateNiceMocks([
  MockSpec<CourseRemoteSource>(),
  MockSpec<LectureRemoteSource>(),
])
import 'course_detail_repository_impl_test.mocks.dart';

void main() {
  late MockCourseRemoteSource mockCourseRemoteSource;
  late MockLectureRemoteSource mockLectureRemoteSource;
  late CourseDetailRepositoryImpl repository;

  setUp(() {
    mockCourseRemoteSource = MockCourseRemoteSource();
    mockLectureRemoteSource = MockLectureRemoteSource();
    repository = CourseDetailRepositoryImpl(
      courseRemoteSource: mockCourseRemoteSource,
      lectureRemoteSource: mockLectureRemoteSource,
    );
  });

  group('getCourse', () {
    final mockCourseData = {
      'course': {
        'id': 18818,
        'title': '도레미 파이썬 Vol.1',
        'short_description': '파이썬 기초 강좌',
        'description': '파이썬 프로그래밍의 기초를 배우는 강좌입니다.',
        'image_file_url': 'https://example.com/python1.jpg',
        'logo_file_url': 'https://example.com/python1-logo.jpg',
        'taglist': ['프로그래밍', '파이썬', '입문'],
        'is_recommended': true,
        'is_free': false,
      }
    };

    test('강좌 상세 정보 정상 조회', () async {
      // given
      when(mockCourseRemoteSource.getCourseDetail(courseId: '18818'))
          .thenAnswer((_) async => Response(
                data: mockCourseData,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      // when
      final course = await repository.getCourse(18818);

      // then
      verify(mockCourseRemoteSource.getCourseDetail(courseId: '18818'))
          .called(1);
      expect(course.id, 18818);
      expect(course.title, '도레미 파이썬 Vol.1');
      expect(course.shortDescription, '파이썬 기초 강좌');
      expect(course.isRecommended, true);
      expect(course.isFree, false);
    });

    test('응답 데이터가 없는 경우 예외 발생', () async {
      // given
      when(mockCourseRemoteSource.getCourseDetail(courseId: '18818'))
          .thenAnswer((_) async => Response(
                data: null,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      // when & then
      expect(
        () => repository.getCourse(18818),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('No data'),
        )),
      );
    });

    test('course 필드가 없는 경우 예외 발생', () async {
      // given
      when(mockCourseRemoteSource.getCourseDetail(courseId: '18818'))
          .thenAnswer((_) async => Response(
                data: {'other_field': 'value'},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      // when & then
      expect(
        () => repository.getCourse(18818),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('No course data'),
        )),
      );
    });
  });

  group('getLectures', () {
    final mockLectureList = {
      'lectures': [
        {
          'id': 1,
          'title': '1강. 파이썬 설치하기',
          'description': '파이썬 개발 환경 설정하기',
          'duration': '15:30',
          'is_free': true,
          'video_url': 'https://example.com/lecture1.mp4',
          'thumbnail_url': 'https://example.com/thumbnail1.jpg',
        },
        {
          'id': 2,
          'title': '2강. 기본 문법',
          'description': '파이썬 기본 문법 배우기',
          'duration': '20:45',
          'is_free': false,
          'video_url': 'https://example.com/lecture2.mp4',
          'thumbnail_url': 'https://example.com/thumbnail2.jpg',
        },
      ]
    };

    test('강의 목록 정상 조회', () async {
      // given
      when(mockLectureRemoteSource.getLectureList(
        courseId: '18818',
        offset: 0,
        count: ApiConstants.defaultPageSize,
      )).thenAnswer((_) async => Response(
            data: mockLectureList,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      // when
      final lectures = await repository.getLectures(courseId: 18818);

      // then
      verify(mockLectureRemoteSource.getLectureList(
        courseId: '18818',
        offset: 0,
        count: ApiConstants.defaultPageSize,
      )).called(1);

      expect(lectures.length, 2);
      expect(lectures[0].id, 1);
      expect(lectures[0].title, '1강. 파이썬 설치하기');
      expect(lectures[0].isFree, true);
      expect(lectures[1].id, 2);
      expect(lectures[1].title, '2강. 기본 문법');
      expect(lectures[1].isFree, false);
    });

    test('응답 데이터가 없는 경우 빈 리스트 반환', () async {
      // given
      when(mockLectureRemoteSource.getLectureList(
        courseId: '18818',
        offset: 0,
        count: ApiConstants.defaultPageSize,
      )).thenAnswer((_) async => Response(
            data: null,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      // when
      final lectures = await repository.getLectures(courseId: 18818);

      // then
      expect(lectures, isEmpty);
    });

    test('lectures 필드가 없는 경우 빈 리스트 반환', () async {
      // given
      when(mockLectureRemoteSource.getLectureList(
        courseId: '18818',
        offset: 0,
        count: ApiConstants.defaultPageSize,
      )).thenAnswer((_) async => Response(
            data: {'other_field': 'value'},
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      // when
      final lectures = await repository.getLectures(courseId: 18818);

      // then
      expect(lectures, isEmpty);
    });

    test('페이지네이션 파라미터 적용', () async {
      // given
      when(mockLectureRemoteSource.getLectureList(
        courseId: '18818',
        offset: 20,
        count: 10,
      )).thenAnswer((_) async => Response(
            data: mockLectureList,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      // when
      await repository.getLectures(
        courseId: 18818,
        offset: 20,
        count: 10,
      );

      // then
      verify(mockLectureRemoteSource.getLectureList(
        courseId: '18818',
        offset: 20,
        count: 10,
      )).called(1);
    });
  });
}
