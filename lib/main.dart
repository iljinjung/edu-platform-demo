import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edu_platform_demo/app/routes/app_pages.dart';
import 'package:edu_platform_demo/core/theme/app_theme.dart';
import 'package:edu_platform_demo/di/bindings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Edu Platform Demo',
      theme: AppTheme.lightTheme,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
