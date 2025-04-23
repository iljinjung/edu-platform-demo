import 'package:edu_platform_demo/data/model/course.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:edu_platform_demo/core/theme/app_colors.dart';
import 'package:edu_platform_demo/core/theme/app_text_style.dart';
import 'package:edu_platform_demo/presentation/components/card/course_card.dart';
import 'package:edu_platform_demo/presentation/view_model/home/home_view_model.dart';

class HomeView extends GetView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/logos/logo.png',
              width: 147.10,
              height: 32,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.all(4),
              child: Image.asset(
                'assets/images/icons/search.png',
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
        toolbarHeight: 64,
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshAll,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '무료 과목',
                    style: AppTextStyle.sectionTitle,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: SizedBox(
                    height: 250,
                    child: PagedListView<int, Course>(
                      pagingController: controller.freePagingController,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(16),
                      builderDelegate: PagedChildBuilderDelegate<Course>(
                        itemBuilder: (context, course, index) => Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: CourseCard(
                            imageFileUrl: course.imageFileUrl,
                            logoFileUrl: course.logoFileUrl,
                            title: course.title,
                            shortDescription: course.shortDescription,
                            taglist: course.taglist,
                          ),
                        ),
                        noItemsFoundIndicatorBuilder: (_) =>
                            const Center(child: Text('표시할 강좌가 없습니다.')),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '추천 과목',
                    style: AppTextStyle.sectionTitle,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: SizedBox(
                    height: 250,
                    child: PagedListView<int, Course>(
                      pagingController: controller.recommendedPagingController,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(16),
                      builderDelegate: PagedChildBuilderDelegate<Course>(
                        itemBuilder: (context, course, index) => Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: CourseCard(
                            imageFileUrl: course.imageFileUrl,
                            logoFileUrl: course.logoFileUrl,
                            title: course.title,
                            shortDescription: course.shortDescription,
                            taglist: course.taglist,
                          ),
                        ),
                        noItemsFoundIndicatorBuilder: (_) =>
                            const Center(child: Text('표시할 강좌가 없습니다.')),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '내 학습',
                    style: AppTextStyle.sectionTitle,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (controller.hasNoEnrolledCourses) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Center(child: Text('수강 중인 강좌가 없습니다.')),
                      );
                    }

                    return SizedBox(
                      height: 250,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(16),
                        itemCount: controller.enrolledCourses.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final course = controller.enrolledCourses[index];
                          return CourseCard(
                            imageFileUrl: course.imageFileUrl,
                            logoFileUrl: course.logoFileUrl,
                            title: course.title,
                            shortDescription: course.shortDescription,
                            taglist: course.taglist,
                          );
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
