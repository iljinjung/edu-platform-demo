import 'package:flutter/material.dart';
import 'package:edu_platform_demo/core/theme/app_colors.dart';
import 'package:edu_platform_demo/core/theme/app_text_style.dart';
import 'package:flutter/foundation.dart';

/// 강좌의 제목 영역을 표시하는 컴포넌트
///
/// 두 가지 레이아웃을 지원합니다:
/// 1. 커버 이미지가 있는 경우: 로고와 제목을 가로로 배치 + 커버 이미지
/// 2. 커버 이미지가 없는 경우: 로고, 제목, 설명을 세로로 배치
class CourseTitleArea extends StatelessWidget {
  /// 강좌 제목
  final String title;

  /// 강좌 설명 (선택)
  final String? description;

  /// 강좌 로고 이미지 URL
  final String? logoFileUrl;

  /// 강좌 커버 이미지 URL
  final String? imageFileUrl;

  /// 컴포넌트의 너비 (선택, 기본값: double.infinity)
  final double? width;

  const CourseTitleArea({
    super.key,
    required this.title,
    required this.logoFileUrl,
    required this.imageFileUrl,
    this.description,
    this.width,
  });

  /// 커버 이미지 존재 여부
  bool get hasCoverImage => imageFileUrl != null && imageFileUrl!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    debugPrint('코스 타이틀: 제목 - $title');
    debugPrint('코스 타이틀: 로고 URL - $logoFileUrl');
    debugPrint('코스 타이틀: 이미지 URL - $imageFileUrl');
    debugPrint('코스 타이틀: hasCoverImage - $hasCoverImage');

    return Container(
      width: width ?? double.infinity,
      child: hasCoverImage ? _buildWithCover() : _buildWithoutCover(),
    );
  }

  /// 이미지를 표시하는 위젯을 생성합니다.
  Widget _buildImage(String? url,
      {double? width, double? height, BoxFit? fit}) {
    debugPrint('코스 타이틀: _buildImage 호출 - URL: $url');

    // URL이 null이거나 비어있는 경우 처리
    if (url == null || url.isEmpty) {
      debugPrint('코스 타이틀: URL이 null이거나 비어있음');
      return Container(
        width: width,
        height: height,
        color: AppColors.gray100,
        child: const Center(
          child: Icon(
            Icons.image_not_supported,
            color: Colors.black45,
          ),
        ),
      );
    }

    // 네트워크 이미지 표시
    debugPrint('코스 타이틀: 네트워크 이미지 로드 시도 - $url');
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('코스 타이틀: 이미지 로드 실패 - $error');
        return Container(
          width: width,
          height: height,
          color: AppColors.gray100,
          child: const Center(
            child: Icon(
              Icons.error_outline,
              color: Colors.black45,
            ),
          ),
        );
      },
    );
  }

  /// 커버 이미지가 있는 경우의 레이아웃
  Widget _buildWithCover() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 36,
                height: 36,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: AppColors.gray100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _buildImage(logoFileUrl, width: 36, height: 36),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.sectionTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        if (imageFileUrl != null && imageFileUrl!.isNotEmpty)
          Container(
            width: double.infinity,
            height: 200,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            child:
                _buildImage(imageFileUrl, width: double.infinity, height: 200),
          ),
      ],
    );
  }

  /// 커버 이미지가 없는 경우의 레이아웃
  Widget _buildWithoutCover() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: AppColors.gray100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _buildImage(logoFileUrl, width: 56, height: 56),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTextStyle.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (description != null && description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              description!,
              style: AppTextStyle.shortDescription,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
