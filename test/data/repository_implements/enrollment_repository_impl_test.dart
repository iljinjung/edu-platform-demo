import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:edu_platform_demo/data/repository_implements/enrollment_repository_impl.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
import 'enrollment_repository_impl_test.mocks.dart';

void main() {
  late MockSharedPreferences mockPreferences;
  late EnrollmentRepositoryImpl repository;

  const enrolledCoursesKey = 'enrolled_course_ids';

  setUp(() {
    mockPreferences = MockSharedPreferences();
    repository = EnrollmentRepositoryImpl(preferences: mockPreferences);
  });

  group('toggleEnrollment', () {
    test('수강 신청되지 않은 강좌 등록 시 목록에 추가', () async {
      // given
      const courseId = 18818;
      when(mockPreferences.getStringList(enrolledCoursesKey))
          .thenReturn(['21503', '20330']);

      // when
      await repository.toggleEnrollment(courseId);

      // then
      verify(mockPreferences.setStringList(
        enrolledCoursesKey,
        ['21503', '20330', '18818'],
      )).called(1);
    });

    test('이미 수강 신청된 강좌 취소 시 목록에서 제거', () async {
      // given
      const courseId = 21503;
      when(mockPreferences.getStringList(enrolledCoursesKey))
          .thenReturn(['21503', '20330']);

      // when
      await repository.toggleEnrollment(courseId);

      // then
      verify(mockPreferences.setStringList(
        enrolledCoursesKey,
        ['20330'],
      )).called(1);
    });

    test('저장된 목록이 없을 경우 빈 리스트로 시작', () async {
      // given
      const courseId = 18818;
      when(mockPreferences.getStringList(enrolledCoursesKey)).thenReturn(null);

      // when
      await repository.toggleEnrollment(courseId);

      // then
      verify(mockPreferences.setStringList(
        enrolledCoursesKey,
        ['18818'],
      )).called(1);
    });
  });

  group('isEnrolled', () {
    test('수강 신청된 강좌 확인 시 true 반환', () async {
      // given
      const courseId = 21503;
      when(mockPreferences.getStringList(enrolledCoursesKey))
          .thenReturn(['21503', '20330']);

      // when
      final result = await repository.isEnrolled(courseId);

      // then
      expect(result, true);
    });

    test('수강 신청되지 않은 강좌 확인 시 false 반환', () async {
      // given
      const courseId = 18818;
      when(mockPreferences.getStringList(enrolledCoursesKey))
          .thenReturn(['21503', '20330']);

      // when
      final result = await repository.isEnrolled(courseId);

      // then
      expect(result, false);
    });

    test('저장된 목록이 없을 경우 false 반환', () async {
      // given
      const courseId = 18818;
      when(mockPreferences.getStringList(enrolledCoursesKey)).thenReturn(null);

      // when
      final result = await repository.isEnrolled(courseId);

      // then
      expect(result, false);
    });

    test('SharedPreferences 에러 발생 시 false 반환', () async {
      // given
      const courseId = 18818;
      when(mockPreferences.getStringList(enrolledCoursesKey))
          .thenThrow(Exception('SharedPreferences error'));

      // when
      final result = await repository.isEnrolled(courseId);

      // then
      expect(result, false);
    });
  });
}
