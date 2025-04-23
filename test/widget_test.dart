// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edu_platform_demo/di/bindings.dart';
import 'package:edu_platform_demo/presentation/view/home/home_view.dart';
import 'package:edu_platform_demo/presentation/components/button/app_button.dart';
import 'package:edu_platform_demo/presentation/components/card/course_card.dart';

import 'package:edu_platform_demo/main.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('Home screen test', (WidgetTester tester) async {
    // SharedPreferences 테스트 설정
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(prefs);

    // 초기 바인딩 설정
    InitialBinding().dependencies();

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // HomeView가 표시되는지 확인
    expect(find.byType(HomeView), findsOneWidget);

    // 코스 카드가 표시되는지 확인
    expect(find.byType(CourseCard), findsNWidgets(5));

    // 강의 제목이 표시되는지 확인
    expect(find.text('플러터로 시작하는 크로스플랫폼 앱 개발'), findsOneWidget);

    // 수강 신청 버튼이 표시되는지 확인
    expect(find.byType(AppButton), findsOneWidget);
    expect(find.text('수강 신청'), findsOneWidget);

    // 강의 목록의 첫 번째 강의가 표시되는지 확인
    expect(find.text('Flutter 소개와 개발 환경 설정'), findsOneWidget);
  });
}
