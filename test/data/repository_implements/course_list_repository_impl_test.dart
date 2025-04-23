import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:edu_platform_demo/core/constants/api_constants.dart';
import 'package:edu_platform_demo/data/repository_implements/course_list_repository_impl.dart';
import 'package:edu_platform_demo/data/source/remote/course_remote_source.dart';
import 'package:edu_platform_demo/domain/model/course_filter_type.dart';

@GenerateNiceMocks([
  MockSpec<CourseRemoteSource>(),
  MockSpec<SharedPreferences>(),
])
import 'course_list_repository_impl_test.mocks.dart';

void main() {
  late MockCourseRemoteSource mockRemoteSource;
  late MockSharedPreferences mockPreferences;
  late CourseListRepositoryImpl repository;

  const enrolledCoursesKey = 'enrolled_course_ids';

  setUp(() {
    mockRemoteSource = MockCourseRemoteSource();
    mockPreferences = MockSharedPreferences();
    repository = CourseListRepositoryImpl(
      remoteSource: mockRemoteSource,
      preferences: mockPreferences,
    );
  });

  group('fetchCourses', () {
    final mockCourseList = [
      {
        'id': 18818,
        'title': '도레미 파이썬 Vol.1',
        'short_description': '파이썬 기초 강좌',
        'description': '파이썬 프로그래밍의 기초를 배우는 강좌입니다.',
        'image_file_url': 'https://example.com/python1.jpg',
        'logo_file_url': 'https://example.com/python1-logo.jpg',
        'taglist': ['프로그래밍', '파이썬', '입문'],
        'is_recommended': true,
        'is_free': false,
      },
      {
        'id': 21503,
        'title': '도레미 파이썬 Vol.2',
        'short_description': '파이썬 중급 강좌',
        'description': '파이썬 프로그래밍의 중급 개념을 배우는 강좌입니다.',
        'image_file_url': 'https://example.com/python2.jpg',
        'logo_file_url': 'https://example.com/python2-logo.jpg',
        'taglist': ['프로그래밍', '파이썬', '중급'],
        'is_recommended': false,
        'is_free': true,
      },
    ];

    test('기본 파라미터로 강좌 목록 조회', () async {
      // given
      when(mockRemoteSource.getCourseList(
              queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => Response(
                data: {'courses': mockCourseList},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      // when
      final courses = await repository.fetchCourses();

      // then
      verify(mockRemoteSource.getCourseList(queryParameters: {
        'offset': 0,
        'count': ApiConstants.defaultPageSize,
      })).called(1);

      expect(courses.length, 2);
      expect(courses[0].id, 18818);
      expect(courses[1].id, 21503);
    });

    test('추천 강좌 필터링 조회', () async {
      // given
      when(mockRemoteSource.getCourseList(
              queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => Response(
                data: {'courses': mockCourseList},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      // when
      await repository.fetchCourses(filterType: CourseFilterType.recommended);

      // then
      verify(mockRemoteSource.getCourseList(queryParameters: {
        'offset': 0,
        'count': ApiConstants.defaultPageSize,
        'filter_is_recommended': true,
      })).called(1);
    });

    test('무료 강좌 필터링 조회', () async {
      // given
      when(mockRemoteSource.getCourseList(
              queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => Response(
                data: {'courses': mockCourseList},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      // when
      await repository.fetchCourses(filterType: CourseFilterType.free);

      // then
      verify(mockRemoteSource.getCourseList(queryParameters: {
        'offset': 0,
        'count': ApiConstants.defaultPageSize,
        'filter_is_free': true,
      })).called(1);
    });

    test('수강 중인 강좌 필터링 조회', () async {
      // given
      when(mockPreferences.getStringList(enrolledCoursesKey))
          .thenReturn(['18818', '21503']);

      when(mockRemoteSource.getCourseList(
              queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => Response(
                data: {'courses': mockCourseList},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      // when
      await repository.fetchCourses(filterType: CourseFilterType.enrolled);

      // then
      verify(mockRemoteSource.getCourseList(queryParameters: {
        'offset': 0,
        'count': ApiConstants.defaultPageSize,
        'filter_conditions': {
          'course_ids': ['18818', '21503']
        },
      })).called(1);
    });

    test('응답 데이터가 없을 경우 빈 리스트 반환', () async {
      // given
      when(mockRemoteSource.getCourseList(
              queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => Response(
                data: null,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      // when
      final courses = await repository.fetchCourses();

      // then
      expect(courses, isEmpty);
    });

    test('페이지네이션 파라미터 적용', () async {
      // given
      when(mockRemoteSource.getCourseList(
              queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => Response(
                data: {'courses': mockCourseList},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      // when
      await repository.fetchCourses(
        offset: 20,
        count: 10,
      );

      // then
      verify(mockRemoteSource.getCourseList(queryParameters: {
        'offset': 20,
        'count': 10,
      })).called(1);
    });
  });

  group('getEnrolledCourses', () {
    test('수강 중인 강좌 목록 조회', () async {
      // given
      when(mockPreferences.getStringList(enrolledCoursesKey))
          .thenReturn(['18818']);

      when(mockRemoteSource.getCourseList(
        queryParameters: {
          'offset': 0,
          'count': 1, // enrolledIds.length와 일치
          'filter_conditions': {
            'course_ids': ['18818']
          },
        },
      )).thenAnswer((_) async => Response(
            data: {
              'courses': [
                {
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
              ]
            },
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      // when
      final courses = await repository.getEnrolledCourses();

      // then
      verify(mockRemoteSource.getCourseList(
        queryParameters: {
          'offset': 0,
          'count': 1, // enrolledIds.length와 일치
          'filter_conditions': {
            'course_ids': ['18818']
          },
        },
      )).called(1);

      expect(courses.length, 1);
      expect(courses[0].id, 18818);
    });

    test('수강 중인 강좌가 없을 경우 API 호출 없이 빈 리스트 반환', () async {
      // given
      when(mockPreferences.getStringList(enrolledCoursesKey)).thenReturn([]);

      // when
      final courses = await repository.getEnrolledCourses();

      // then
      verifyNever(mockRemoteSource.getCourseList(
        queryParameters: anyNamed('queryParameters'),
      ));
      expect(courses, isEmpty);
    });
  });
}
