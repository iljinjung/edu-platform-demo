import 'package:dio/dio.dart';
import 'package:edu_platform_demo/data/repository_implements/course_detail_repository_impl.dart';
import 'package:edu_platform_demo/data/repository_implements/course_list_repository_impl.dart';
import 'package:edu_platform_demo/data/repository_implements/enrollment_repository_impl.dart';
import 'package:edu_platform_demo/data/source/remote/course_remote_source.dart';
import 'package:edu_platform_demo/data/source/remote/lecture_remote_source.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edu_platform_demo/presentation/view_model/home/home_view_model.dart';
import 'package:edu_platform_demo/presentation/view_model/detail/course_detail_view_model.dart';
import 'package:edu_platform_demo/domain/repository/course_list_repository.dart';
import 'package:edu_platform_demo/domain/repository/course_detail_repository.dart';
import 'package:edu_platform_demo/domain/repository/enrollment_repository.dart';
import 'package:edu_platform_demo/core/di/dio_provider.dart';

/// 앱의 공통 의존성을 초기화하는 Binding
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Dio 설정 및 초기화
    final dio = DioProvider.dio;
    Get.put(dio);

    // Remote Sources 초기화 - 추상 타입으로 주입
    Get.put<CourseRemoteSource>(
      CourseRemoteSourceImpl(dio: dio),
    );
    Get.put<LectureRemoteSource>(
      LectureRemoteSourceImpl(dio: dio),
    );
  }
}

/// 홈 화면 관련 의존성을 초기화하는 Binding
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Repository 초기화
    final courseListRepository = CourseListRepositoryImpl(
      remoteSource: Get.find<CourseRemoteSource>(),
      preferences: Get.find<SharedPreferences>(),
    );
    Get.put<CourseListRepository>(courseListRepository);

    // ViewModel 초기화 (lazy)
    Get.lazyPut(() => HomeViewModel(
          courseListRepository: courseListRepository,
        ));
  }
}

/// 강좌 상세 화면 관련 의존성을 초기화하는 Binding
class CourseDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Repository 초기화
    final courseDetailRepository = CourseDetailRepositoryImpl(
      courseRemoteSource: Get.find<CourseRemoteSource>(),
      lectureRemoteSource: Get.find<LectureRemoteSource>(),
    );
    final enrollmentRepository = EnrollmentRepositoryImpl(
      preferences: Get.find<SharedPreferences>(),
    );
    Get.put<CourseDetailRepository>(courseDetailRepository);
    Get.put<EnrollmentRepository>(enrollmentRepository);

    // ViewModel 초기화 (lazy)
    Get.lazyPut(() => CourseDetailViewModel(
          courseDetailRepository: courseDetailRepository,
          enrollmentRepository: enrollmentRepository,
        ));
  }
}
