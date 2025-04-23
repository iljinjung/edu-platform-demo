import 'package:edu_platform_demo/presentation/components/card/course_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edu_platform_demo/presentation/components/title/course_title_area.dart';
import 'package:edu_platform_demo/presentation/components/lecture/lecture_list.dart';
import 'package:edu_platform_demo/presentation/components/button/app_button.dart';
import 'package:edu_platform_demo/data/model/lecture.dart';

class HomeView extends GetView {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // 샘플 강의 데이터
    final lectures = [
      const Lecture(
        id: 1,
        title: 'Flutter 소개와 개발 환경 설정',
        description: 'Flutter의 특징과 장점, 개발 환경 설정 방법을 알아봅니다.',
        isOpened: true,
        isPreview: false,
        orderNo: 1,
      ),
      const Lecture(
        id: 2,
        title: 'Dart 언어 기초와 문법',
        description: 'Flutter 개발에 필요한 Dart 언어의 기초 문법을 학습합니다.',
        isOpened: true,
        isPreview: false,
        orderNo: 2,
      ),
      const Lecture(
        id: 3,
        title: '위젯의 이해와 기본 UI 구현',
        description: 'Flutter의 기본 위젯들을 살펴보고 간단한 UI를 구현해봅니다.',
        isOpened: true,
        isPreview: false,
        orderNo: 3,
      ),
    ];

    // 샘플 코스 카드 데이터
    final courses = List.generate(
        5,
        (index) => {
              'imageFileUrl': 'https://picsum.photos/seed/course$index/400',
              'logoFileUrl': 'https://picsum.photos/seed/logo$index/200',
              'title': 'C언어 챌린지 ${index + 1}',
              'shortDescription': '나의 C언어 실력을 테스트 해보세요!',
              'taglist': ['플러터', '앱개발', '프로그래밍'],
            });

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  // 가로 스크롤되는 코스 카드 목록
                  SizedBox(
                    height: 220,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          for (var i = 0; i < courses.length; i++) ...[
                            if (i > 0) const SizedBox(width: 16),
                            CourseCard(
                              imageFileUrl: null,
                              logoFileUrl: courses[i]['logoFileUrl'] as String,
                              title: courses[i]['title'] as String,
                              shortDescription:
                                  courses[i]['shortDescription'] as String,
                              taglist: (courses[i]['taglist'] as List<String>),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // 커버 이미지가 있는 경우
                  const CourseTitleArea(
                    title: '플러터로 시작하는 크로스플랫폼 앱 개발',
                    logoFileUrl: 'https://picsum.photos/seed/logo1/200',
                    imageFileUrl: 'https://picsum.photos/seed/cover1/400',
                    description: '플러터의 기초부터 실전 프로젝트까지',
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: LectureList(
                      items: lectures,
                      width: double.infinity,
                    ),
                  ),
                  // 하단 버튼의 공간을 확보하기 위한 여백
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          // 하단 고정 버튼
          Positioned(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).padding.bottom + 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: AppButton(
                label: '수강 신청',
                onPressed: () {
                  // TODO: 수강 신청 처리
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
