import 'package:flutter/material.dart';
import 'package:edu_platform_demo/core/theme/app_colors.dart';
import 'package:edu_platform_demo/core/theme/app_text_style.dart';

/// 태그를 표시하는 배지 위젯
///
/// 회색 배경의 둥근 모서리 컨테이너에 텍스트를 표시합니다.
/// 주로 카테고리나 키워드를 나타내는데 사용됩니다.
class Tag extends StatelessWidget {
  /// 태그에 표시될 텍스트
  final String label;

  const Tag({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColors.gray200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Text(
        label,
        style: AppTextStyle.tag,
      ),
    );
  }
}
