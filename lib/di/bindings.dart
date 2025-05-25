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
import 'package:edu_platform_demo/core/networking/dio_wrapper.dart';
import 'package:edu_platform_demo/core/database/db_helper.dart';
import 'package:edu_platform_demo/core/migration/migration_service.dart';

/// 앱의 공통 의존성을 초기화하는 Binding
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Dio 설정 및 초기화
    final dio = DioProvider.dio;
    Get.put(dio);

    // DioWrapper 초기화 및 등록
    final dioWrapper = DioWrapper(dio: dio);
    Get.put(dioWrapper);

    // DatabaseHelper 초기화 및 등록 (싱글턴)
    final dbHelper = DatabaseHelper(); // DatabaseHelper is a singleton via its factory constructor
    Get.put(dbHelper);

    // MigrationService 초기화 및 등록
    // SharedPreferences는 main.dart 또는 그 이전 시점에서 등록되어 Get.find로 찾을 수 있어야 함.
    final migrationService = MigrationService(
      prefs: Get.find<SharedPreferences>(), 
      dbHelper: Get.find<DatabaseHelper>(),
    );
    Get.put(migrationService);
    // 중요: MigrationService의 migrateIfNeeded()를 호출하는 로직이 필요합니다.
    // 이는 보통 앱 시작 시 (예: main.dart 또는 스플래시 화면 ViewModel)에 수행됩니다.
    // 여기서는 등록만 합니다.

    // Remote Sources 초기화 - 추상 타입으로 주입
    Get.put<CourseRemoteSource>(
      CourseRemoteSourceImpl(dioWrapper: Get.find<DioWrapper>()),
    );
    Get.put<LectureRemoteSource>(
      LectureRemoteSourceImpl(dioWrapper: Get.find<DioWrapper>()),
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
      dbHelper: Get.find<DatabaseHelper>(),
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
