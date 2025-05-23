// Mocks generated by Mockito 5.4.4 from annotations
// in edu_platform_demo/test/presentation/view_model/home/home_view_model_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:edu_platform_demo/domain/model/course.dart' as _i4;
import 'package:edu_platform_demo/domain/model/course_filter_type.dart' as _i5;
import 'package:edu_platform_demo/domain/repository/course_list_repository.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [CourseListRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCourseListRepository extends _i1.Mock
    implements _i2.CourseListRepository {
  MockCourseListRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.Course>> fetchCourses({
    _i5.CourseFilterType? filterType = _i5.CourseFilterType.all,
    int? offset = 0,
    int? count = 10,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchCourses,
          [],
          {
            #filterType: filterType,
            #offset: offset,
            #count: count,
          },
        ),
        returnValue: _i3.Future<List<_i4.Course>>.value(<_i4.Course>[]),
      ) as _i3.Future<List<_i4.Course>>);

  @override
  _i3.Future<List<_i4.Course>> getEnrolledCourses() => (super.noSuchMethod(
        Invocation.method(
          #getEnrolledCourses,
          [],
        ),
        returnValue: _i3.Future<List<_i4.Course>>.value(<_i4.Course>[]),
      ) as _i3.Future<List<_i4.Course>>);
}
