import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:edu_platform_demo/presentation/components/lecture/lecture_list.dart';
import 'package:edu_platform_demo/data/model/lecture.dart';

@widgetbook.UseCase(
  name: '기본 강의 목록',
  type: LectureList,
)
Widget buildDefaultLectureList(BuildContext context) {
  final width = context.knobs.double.slider(
    label: '너비',
    description: '컴포넌트의 너비',
    initialValue: 343,
    min: 200,
    max: 500,
  );

  final lectures = [
    Lecture(
      id: 1,
      title: '1. 플러터 소개',
      description: '플러터의 기본 개념과 특징을 알아봅니다.',
      isOpened: true,
      isPreview: false,
    ),
    Lecture(
      id: 2,
      title: '2. 개발 환경 설정',
      description: '플러터 개발을 위한 환경을 설정합니다.',
      isOpened: false,
      isPreview: false,
    ),
    Lecture(
      id: 3,
      title: '3. 첫 번째 앱 만들기',
      description: '간단한 앱을 만들어보며 플러터의 기본을 익힙니다.',
      isOpened: false,
      isPreview: false,
    ),
  ];

  return Center(
    child: LectureList(
      items: lectures,
      width: width,
    ),
  );
}

@widgetbook.UseCase(
  name: '미리보기 강의가 포함된 목록',
  type: LectureList,
)
Widget buildLectureListWithPreview(BuildContext context) {
  final width = context.knobs.double.slider(
    label: '너비',
    description: '컴포넌트의 너비',
    initialValue: 343,
    min: 200,
    max: 500,
  );

  final lectures = [
    Lecture(
      id: 1,
      title: '1. 플러터 소개',
      description: '플러터의 기본 개념과 특징을 알아봅니다.',
      isOpened: true,
      isPreview: true,
    ),
    Lecture(
      id: 2,
      title: '2. 개발 환경 설정',
      description: '플러터 개발을 위한 환경을 설정합니다.',
      isOpened: false,
      isPreview: true,
    ),
    Lecture(
      id: 3,
      title: '3. 첫 번째 앱 만들기',
      description: '간단한 앱을 만들어보며 플러터의 기본을 익힙니다.',
      isOpened: false,
      isPreview: false,
    ),
    Lecture(
      id: 4,
      title: '4. 위젯의 이해',
      description: '플러터의 핵심인 위젯에 대해 자세히 알아봅니다.',
      isOpened: false,
      isPreview: false,
    ),
  ];

  return Center(
    child: LectureList(
      items: lectures,
      width: width,
    ),
  );
}
