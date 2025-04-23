import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:edu_platform_demo/presentation/components/title/course_title_area.dart';

@widgetbook.UseCase(
  name: 'With Cover Image',
  type: CourseTitleArea,
)
Widget buildCourseTitleAreaWithCover(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: '플러터로 만드는 멋진 앱',
    description: '강좌의 제목',
  );

  final description = context.knobs.stringOrNull(
    label: 'Description',
    initialValue: '플러터의 기초부터 실전까지 배워보세요',
    description: '강좌에 대한 설명 (선택사항)',
  );

  final logoUrl = context.knobs.stringOrNull(
    label: 'Logo URL',
    initialValue: 'https://picsum.photos/100',
    description: '강좌 로고 이미지 URL (선택사항)',
  );

  final imageUrl = context.knobs.string(
    label: 'Cover Image URL',
    initialValue: 'https://picsum.photos/800/400',
    description: '강좌 커버 이미지 URL',
  );

  final width = context.knobs.double.slider(
    label: 'Width',
    initialValue: 400,
    min: 300,
    max: 800,
    description: '컴포넌트의 너비',
  );

  return Center(
    child: CourseTitleArea(
      title: title,
      description: description,
      logoFileUrl: logoUrl,
      imageFileUrl: imageUrl,
      width: width,
    ),
  );
}

@widgetbook.UseCase(
  name: 'Without Cover Image',
  type: CourseTitleArea,
)
Widget buildCourseTitleAreaWithoutCover(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: '플러터로 만드는 멋진 앱',
    description: '강좌의 제목',
  );

  final description = context.knobs.stringOrNull(
    label: 'Description',
    initialValue: '플러터의 기초부터 실전까지 배워보세요',
    description: '강좌에 대한 설명 (선택사항)',
  );

  final logoUrl = context.knobs.stringOrNull(
    label: 'Logo URL',
    initialValue: 'https://picsum.photos/100',
    description: '강좌 로고 이미지 URL (선택사항)',
  );

  final width = context.knobs.double.slider(
    label: 'Width',
    initialValue: 400,
    min: 300,
    max: 800,
    description: '컴포넌트의 너비',
  );

  return Center(
    child: CourseTitleArea(
      title: title,
      description: description,
      logoFileUrl: logoUrl,
      imageFileUrl: null,
      width: width,
    ),
  );
}

@widgetbook.UseCase(
  name: 'Without Logo',
  type: CourseTitleArea,
)
Widget buildCourseTitleAreaWithoutLogo(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: '플러터로 만드는 멋진 앱',
    description: '강좌의 제목',
  );

  final description = context.knobs.stringOrNull(
    label: 'Description',
    initialValue: '플러터의 기초부터 실전까지 배워보세요',
    description: '강좌에 대한 설명 (선택사항)',
  );

  final width = context.knobs.double.slider(
    label: 'Width',
    initialValue: 400,
    min: 300,
    max: 800,
    description: '컴포넌트의 너비',
  );

  return Center(
    child: CourseTitleArea(
      title: title,
      description: description,
      logoFileUrl: null,
      imageFileUrl: null,
      width: width,
    ),
  );
}
