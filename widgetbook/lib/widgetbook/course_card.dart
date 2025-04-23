import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:edu_platform_demo/presentation/components/card/course_card.dart';

@widgetbook.UseCase(
  name: '기본 강좌 카드',
  type: CourseCard,
)
Widget buildDefaultCourseCard(BuildContext context) {
  final title = context.knobs.string(
    label: '제목',
    initialValue: '플러터로 만드는 멋진 앱',
    description: '강좌의 제목',
  );

  final shortDescription = context.knobs.string(
    label: '짧은 설명',
    initialValue: '플러터의 기초부터 실전까지 배워보세요',
    description: '강좌에 대한 짧은 설명',
  );

  final logoUrl = context.knobs.stringOrNull(
    label: '로고 URL',
    initialValue: 'https://picsum.photos/100',
    description: '강좌 로고 이미지 URL (선택사항)',
  );

  final imageUrl = context.knobs.stringOrNull(
    label: '커버 이미지 URL',
    initialValue: 'https://picsum.photos/800/400',
    description: '강좌 커버 이미지 URL (선택사항)',
  );

  final taglist = context.knobs.list<String>(
    label: '태그 목록',
    description: '강좌와 관련된 태그들',
    options: ['플러터', '앱개발', '프로그래밍'],
  );

  return Center(
    child: CourseCard(
      title: title,
      shortDescription: shortDescription,
      logoFileUrl: logoUrl,
      imageFileUrl: imageUrl,
      taglist: [],
      courseId: 1,
      onTap: (_) {},
    ),
  );
}

@widgetbook.UseCase(
  name: '로고만 있는 강좌 카드',
  type: CourseCard,
)
Widget buildCourseCardWithLogoOnly(BuildContext context) {
  final title = context.knobs.string(
    label: '제목',
    initialValue: '플러터로 만드는 멋진 앱',
    description: '강좌의 제목',
  );

  final shortDescription = context.knobs.string(
    label: '짧은 설명',
    initialValue: '플러터의 기초부터 실전까지 배워보세요',
    description: '강좌에 대한 짧은 설명',
  );

  final logoUrl = context.knobs.string(
    label: '로고 URL',
    initialValue: 'https://picsum.photos/100',
    description: '강좌 로고 이미지 URL',
  );

  final taglist = context.knobs.list<String>(
    label: '태그 목록',
    description: '강좌와 관련된 태그들',
    options: ['플러터', '앱개발', '프로그래밍'],
  );

  return Center(
    child: CourseCard(
      title: title,
      shortDescription: shortDescription,
      logoFileUrl: logoUrl,
      imageFileUrl: null,
      taglist: [],
      courseId: 1,
      onTap: (_) {},
    ),
  );
}

@widgetbook.UseCase(
  name: '이미지 없는 강좌 카드',
  type: CourseCard,
)
Widget buildCourseCardWithoutImages(BuildContext context) {
  final title = context.knobs.string(
    label: '제목',
    initialValue: '플러터로 만드는 멋진 앱',
    description: '강좌의 제목',
  );

  final shortDescription = context.knobs.string(
    label: '짧은 설명',
    initialValue: '플러터의 기초부터 실전까지 배워보세요',
    description: '강좌에 대한 짧은 설명',
  );

  final taglist = context.knobs.list<String>(
    label: '태그 목록',
    description: '강좌와 관련된 태그들',
    options: ['플러터', '앱개발', '프로그래밍'],
  );

  return Center(
    child: CourseCard(
      title: title,
      shortDescription: shortDescription,
      logoFileUrl: null,
      imageFileUrl: null,
      taglist: [],
      courseId: 1,
      onTap: (_) {},
    ),
  );
}
