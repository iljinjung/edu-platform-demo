import 'package:edu_platform_demo/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:edu_platform_demo/presentation/view_model/detail/course_detail_view_model.dart';
import 'package:edu_platform_demo/presentation/components/title/course_title_area.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:edu_platform_demo/core/theme/app_text_style.dart';
import 'package:edu_platform_demo/core/utils/extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:edu_platform_demo/presentation/components/lecture/lecture_list.dart';
import 'package:edu_platform_demo/presentation/components/button/app_button.dart';
import 'package:edu_platform_demo/app/routes/app_pages.dart';

class CourseDetailView extends GetView<CourseDetailViewModel> {
  const CourseDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // 화면 너비에서 좌우 패딩(32)을 뺀 값을 계산
    final contentWidth = context.screenSize.width - 32 - 16;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/images/icons/ic_arrow_back_left.svg',
            width: 24,
            height: 24,
          ),
          onPressed: () {
            if (controller.isEnrolled != controller.initialEnrollmentState) {
              Get.offNamed(Routes.home, arguments: true);
            } else {
              Get.back();
            }
          },
        ),
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.hasError) {
          return Center(
            child: Text(controller.errorMessage),
          );
        }

        final course = controller.course;
        if (course == null) {
          return const Center(
            child: Text('강좌 정보를 찾을 수 없습니다.'),
          );
        }

        return Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CourseTitleArea(
                      title: course.title,
                      description: course.shortDescription,
                      logoFileUrl: course.logoFileUrl,
                      imageFileUrl: course.imageFileUrl,
                    ),
                    if (course.markdownHtml.trim().isNotEmpty) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '과목 소개',
                              style: AppTextStyle.detailTitle,
                            ),
                            const SizedBox(height: 10),
                            Divider(
                              color: AppColors.gray300,
                              height: 1,
                            ),
                            const SizedBox(height: 10),
                            Html(
                              data: course.markdownHtml,
                              style: {
                                "blockquote": Style(
                                  padding: HtmlPaddings.all(12),
                                  margin: Margins.symmetric(vertical: 8),
                                  border: Border(
                                      left: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 4)),
                                  fontStyle: FontStyle.italic,
                                ),
                                "strong": Style(
                                  whiteSpace: WhiteSpace.normal,
                                  fontFamily: 'Noto Sans KR',
                                ),
                                "b": Style(
                                  whiteSpace: WhiteSpace.normal,
                                  fontFamily: 'Noto Sans KR',
                                ),
                                "img": Style(
                                  width: Width(contentWidth),
                                ),
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '커리큘럼',
                            style: AppTextStyle.detailTitle,
                          ),
                          const SizedBox(height: 10),
                          Divider(
                            color: AppColors.gray300,
                            height: 1,
                          ),
                          const SizedBox(height: 16),
                          Obx(() {
                            final lectures = controller.lectures;
                            if (lectures.isEmpty) {
                              return const Center(
                                child: Text('등록된 강의가 없습니다.'),
                              );
                            }
                            return LectureList(
                              items: lectures,
                              width: double.infinity,
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0),
                      Colors.white.withOpacity(0.8),
                      Colors.white,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: AppButton(
                      label: controller.isEnrolled
                          ? '수강 취소하기'
                          : (course.isFree ? '무료로 수강하기' : '수강하기'),
                      onPressed: controller.isEnrolling
                          ? null
                          : () => controller.toggleEnrollment(),
                      color: controller.isEnrolled ? AppColors.danger : null,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
