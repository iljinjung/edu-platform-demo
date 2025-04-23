import 'package:edu_platform_demo/presentation/components/button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Default',
  type: AppButton,
)
Widget buildAppButtonDefault(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: '버튼',
    description: '버튼에 표시될 텍스트',
  );

  final isEnabled = context.knobs.boolean(
    label: 'Enabled',
    initialValue: true,
    description: '버튼의 활성화 상태',
  );

  final width = context.knobs.double.slider(
    label: 'Width',
    initialValue: 200,
    min: 100,
    max: 300,
    description: '버튼의 너비',
  );

  final height = context.knobs.double.slider(
    label: 'Height',
    initialValue: 48,
    min: 40,
    max: 60,
    description: '버튼의 높이',
  );

  final borderRadius = context.knobs.double.slider(
    label: 'Border Radius',
    initialValue: 10,
    min: 0,
    max: 20,
    description: '버튼의 모서리 둥글기',
  );

  return Center(
    child: AppButton(
      label: label,
      onPressed: isEnabled ? () {} : null,
      width: width,
      height: height,
      borderRadius: borderRadius,
    ),
  );
}

@widgetbook.UseCase(
  name: 'Danger',
  type: AppButton,
)
Widget buildAppButtonDanger(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: '삭제',
    description: '버튼에 표시될 텍스트',
  );

  final width = context.knobs.double.slider(
    label: 'Width',
    initialValue: 200,
    min: 100,
    max: 300,
    description: '버튼의 너비',
  );

  final height = context.knobs.double.slider(
    label: 'Height',
    initialValue: 48,
    min: 40,
    max: 60,
    description: '버튼의 높이',
  );

  final borderRadius = context.knobs.double.slider(
    label: 'Border Radius',
    initialValue: 10,
    min: 0,
    max: 20,
    description: '버튼의 모서리 둥글기',
  );

  return Center(
    child: AppButton.danger(
      label: label,
      onPressed: () {},
      width: width,
      height: height,
      borderRadius: borderRadius,
    ),
  );
}

@widgetbook.UseCase(
  name: 'Disabled',
  type: AppButton,
)
Widget buildAppButtonDisabled(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: '비활성화',
    description: '버튼에 표시될 텍스트',
  );

  final width = context.knobs.double.slider(
    label: 'Width',
    initialValue: 200,
    min: 100,
    max: 300,
    description: '버튼의 너비',
  );

  final height = context.knobs.double.slider(
    label: 'Height',
    initialValue: 48,
    min: 40,
    max: 60,
    description: '버튼의 높이',
  );

  final borderRadius = context.knobs.double.slider(
    label: 'Border Radius',
    initialValue: 10,
    min: 0,
    max: 20,
    description: '버튼의 모서리 둥글기',
  );

  return Center(
    child: AppButton.disabled(
      label: label,
      width: width,
      height: height,
      borderRadius: borderRadius,
    ),
  );
}
