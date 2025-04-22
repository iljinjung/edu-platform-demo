import 'package:get/get.dart';
import 'package:edu_platform_demo/presentation/view/home/home_view.dart';
import 'package:edu_platform_demo/presentation/view/detail/course_detail_view.dart';
import 'package:edu_platform_demo/di/bindings.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.courseDetail,
      page: () => const CourseDetailView(),
      binding: CourseDetailBinding(),
    ),
  ];
}
