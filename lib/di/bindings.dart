import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() async {
    // Shared Preferences 초기화
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.put(sharedPreferences);
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // HomeViewModel 초기화 예정
    // Get.put(HomeViewModel());
  }
}

class CourseDetailBinding extends Bindings {
  @override
  void dependencies() {
    // CourseDetailViewModel 초기화 예정
    // Get.put(CourseDetailViewModel());
  }
}
