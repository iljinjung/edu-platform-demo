// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:edu_platform_demo_widgetbook/widgetbook/app_button.dart' as _i2;
import 'package:edu_platform_demo_widgetbook/widgetbook/course_card.dart'
    as _i3;
import 'package:edu_platform_demo_widgetbook/widgetbook/course_title_area.dart'
    as _i5;
import 'package:edu_platform_demo_widgetbook/widgetbook/lecture_list.dart'
    as _i4;
import 'package:widgetbook/widgetbook.dart' as _i1;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'presentation',
    children: [
      _i1.WidgetbookFolder(
        name: 'components',
        children: [
          _i1.WidgetbookFolder(
            name: 'button',
            children: [
              _i1.WidgetbookComponent(
                name: 'AppButton',
                useCases: [
                  _i1.WidgetbookUseCase(
                    name: 'Danger',
                    builder: _i2.buildAppButtonDanger,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Default',
                    builder: _i2.buildAppButtonDefault,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Disabled',
                    builder: _i2.buildAppButtonDisabled,
                  ),
                ],
              )
            ],
          ),
          _i1.WidgetbookFolder(
            name: 'card',
            children: [
              _i1.WidgetbookComponent(
                name: 'CourseCard',
                useCases: [
                  _i1.WidgetbookUseCase(
                    name: '기본 강좌 카드',
                    builder: _i3.buildDefaultCourseCard,
                  ),
                  _i1.WidgetbookUseCase(
                    name: '로고만 있는 강좌 카드',
                    builder: _i3.buildCourseCardWithLogoOnly,
                  ),
                  _i1.WidgetbookUseCase(
                    name: '이미지 없는 강좌 카드',
                    builder: _i3.buildCourseCardWithoutImages,
                  ),
                ],
              )
            ],
          ),
          _i1.WidgetbookFolder(
            name: 'lecture',
            children: [
              _i1.WidgetbookComponent(
                name: 'LectureList',
                useCases: [
                  _i1.WidgetbookUseCase(
                    name: '기본 강의 목록',
                    builder: _i4.buildDefaultLectureList,
                  ),
                  _i1.WidgetbookUseCase(
                    name: '미리보기 강의가 포함된 목록',
                    builder: _i4.buildLectureListWithPreview,
                  ),
                ],
              )
            ],
          ),
          _i1.WidgetbookFolder(
            name: 'title',
            children: [
              _i1.WidgetbookComponent(
                name: 'CourseTitleArea',
                useCases: [
                  _i1.WidgetbookUseCase(
                    name: 'With Cover Image',
                    builder: _i5.buildCourseTitleAreaWithCover,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Without Cover Image',
                    builder: _i5.buildCourseTitleAreaWithoutCover,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Without Logo',
                    builder: _i5.buildCourseTitleAreaWithoutLogo,
                  ),
                ],
              )
            ],
          ),
        ],
      )
    ],
  )
];
