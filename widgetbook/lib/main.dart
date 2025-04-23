// lib/widgetbook.dart
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// 이 파일은 다음 단계에서 생성될 예정입니다
import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      // directories 변수는 다음 단계에서 생성될 예정입니다
      directories: directories,
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: ThemeData.light()),
            WidgetbookTheme(name: 'Dark', data: ThemeData.dark()),
          ],
        ),
        DeviceFrameAddon(devices: [
          // 다양한 디바이스
          Devices.ios.iPhoneSE,
          Devices.ios.iPhone13,
          Devices.ios.iPhone13ProMax,
          Devices.android.smallPhone,
          Devices.android.samsungGalaxyA50,
          Devices.android.samsungGalaxyS20,
          Devices.android.largeTablet,
          Devices.ios.iPad,
          Devices.macOS.macBookPro,
          Devices.windows.laptop,
        ]),
      ],
    );
  }
}
