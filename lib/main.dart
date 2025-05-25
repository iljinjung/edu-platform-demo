import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Needed for Get.putAsync

import 'package:edu_platform_demo/app/routes/app_pages.dart';
import 'package:edu_platform_demo/core/theme/app_theme.dart';
import 'package:edu_platform_demo/di/bindings.dart';
import 'package:edu_platform_demo/core/migration/migration_service.dart'; // Import MigrationService

Future<void> main() async { // Make main asynchronous
  // Flutter 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences and register it with GetX
  // This makes it available for MigrationService and other parts of the app
  await Get.putAsync(() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  });

  // 화면 세로 모드로 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 초기 바인딩 설정. This will also initialize DatabaseHelper and MigrationService
  // as per the updated InitialBinding.
  InitialBinding().dependencies(); 

  // Get MigrationService instance and run migration
  final migrationService = Get.find<MigrationService>();
  await migrationService.migrateIfNeeded();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Education Platform Demo', // Corrected title
      theme: AppTheme.lightTheme,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
