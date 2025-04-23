import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_style.dart';
import 'package:edu_platform_demo/presentation/components/tag/tag.dart';
import 'package:flutter/foundation.dart';

/// 강좌 정보를 카드 형태로 표시하는 위젯
///
/// 강좌의 이미지, 로고, 제목, 설명 및 태그 목록을 포함합니다.
/// 이미지가 없는 경우 로고를 표시하며, 둘 다 없는 경우 기본 아이콘을 표시합니다.
class CourseCard extends StatelessWidget {
  /// 강좌 커버 이미지 URL
  final String? imageFileUrl;

  /// 강좌 로고 이미지 URL
  final String? logoFileUrl;

  /// 강좌 제목
  final String title;

  /// 강좌 짧은 설명
  final String shortDescription;

  /// 강좌 관련 태그 목록
  final List<String> taglist;

  const CourseCard({
    super.key,
    this.imageFileUrl,
    required this.logoFileUrl,
    required this.title,
    required this.shortDescription,
    required this.taglist,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 230,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageContainer(),
          const SizedBox(height: 8),
          _buildTitle(),
          const SizedBox(height: 2),
          _buildDescription(),
          const SizedBox(height: 8),
          _buildTagList(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  /// 이미지 컨테이너를 생성합니다.
  /// 우선순위: 커버 이미지 > 로고 이미지 > 기본 아이콘
  Widget _buildImageContainer() {
    final hasImage = imageFileUrl != null && imageFileUrl!.isNotEmpty;
    final hasLogo = logoFileUrl != null && logoFileUrl!.isNotEmpty;
    final displayImageUrl =
        hasImage ? imageFileUrl : (hasLogo ? logoFileUrl : null);
    final isLogoOnly = !hasImage && hasLogo;

    return Container(
      width: double.infinity,
      height: 100,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isLogoOnly
            ? const Color(0xFF3A3A4C)
            : (displayImageUrl == null ? AppColors.deepText : null),
        borderRadius: BorderRadius.circular(10),
        image: (displayImageUrl != null && !isLogoOnly)
            ? DecorationImage(
                image: NetworkImage(displayImageUrl),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: displayImageUrl == null
          ? const Center(
              child: Icon(
                Icons.image_not_supported,
                size: 40,
                color: Colors.white,
              ),
            )
          : isLogoOnly
              ? Center(
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(displayImageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : null,
    );
  }

  /// 강좌 제목을 표시하는 위젯을 생성합니다.
  Widget _buildTitle() {
    return SizedBox(
      width: 200,
      child: Text(
        title,
        style: AppTextStyle.cardTitle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// 강좌 설명을 표시하는 위젯을 생성합니다.
  Widget _buildDescription() {
    return SizedBox(
      width: 200,
      child: Text(
        shortDescription,
        style: AppTextStyle.shortDescription,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// 태그 목록을 표시하는 위젯을 생성합니다.
  Widget _buildTagList() {
    return Wrap(
      spacing: 4,
      runSpacing: 2,
      children: taglist
          .take(6) // 최대 6개만 노출
          .map((tag) => Tag(label: tag))
          .toList(),
    );
  }
}
