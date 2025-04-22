import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_style.dart';

/// 앱 전반에서 사용되는 기본 버튼 컴포넌트
///
/// 앱의 디자인 시스템을 따르는 일관된 스타일의 버튼을 제공합니다.
/// 버튼의 색상, 크기, 라벨을 커스터마이징할 수 있습니다.
///
/// [onPressed]가 null이면 버튼이 비활성화됩니다.
/// [width]가 null이면 부모 위젯의 전체 너비를 차지합니다.
/// [color]가 null이면 [AppColors.primary]를 사용합니다.
class AppButton extends StatelessWidget {
  /// 버튼 클릭 시 실행될 콜백
  final VoidCallback? onPressed;

  /// 버튼의 너비 (null이면 double.infinity)
  final double? width;

  /// 버튼에 표시될 텍스트
  final String label;

  /// 버튼의 배경색 (null이면 AppColors.primary)
  final Color? color;

  /// 버튼의 높이 (기본값: 48)
  final double height;

  /// 버튼의 모서리 둥글기 (기본값: 10)
  final double borderRadius;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.color,
    this.height = 48,
    this.borderRadius = 10,
  });

  /// 위험 액션(삭제, 취소 등)을 위한 빨간색 버튼 생성자
  factory AppButton.danger({
    required String label,
    required VoidCallback onPressed,
    double? width,
    double height = 48,
    double borderRadius = 10,
  }) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      width: width,
      color: AppColors.danger,
      height: height,
      borderRadius: borderRadius,
    );
  }

  /// 비활성화된 회색 버튼 생성자
  factory AppButton.disabled({
    required String label,
    double? width,
    double height = 48,
    double borderRadius = 10,
  }) {
    return AppButton(
      label: label,
      width: width,
      color: AppColors.gray300,
      height: height,
      borderRadius: borderRadius,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: color ??
              (onPressed == null ? AppColors.gray300 : AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyle.actionButton,
          ),
        ),
      ),
    );
  }
}
