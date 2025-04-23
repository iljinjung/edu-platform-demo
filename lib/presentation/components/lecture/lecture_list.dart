import 'package:flutter/material.dart';
import 'package:edu_platform_demo/core/theme/app_text_style.dart';
import 'package:edu_platform_demo/core/theme/app_colors.dart';
import 'package:edu_platform_demo/data/model/lecture.dart';

/// 강의 목록을 표시하는 위젯
///
/// 강좌에 포함된 강의들의 목록을 수직으로 표시하며, 각 강의는 다음 요소들을 포함합니다:
/// - 강의 제목
/// - 강의 설명
/// - 미리보기 여부
class LectureList extends StatelessWidget {
  /// 표시할 강의 목록
  final List<Lecture> items;

  /// 컴포넌트의 너비
  final double width;

  const LectureList({
    super.key,
    required this.items,
    this.width = 343,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildLectureItems(),
        ),
      ],
    );
  }

  /// 강의 목록 아이템들을 생성합니다.
  ///
  /// 각 강의 아이템 사이에 연결선을 추가하여 반환합니다.
  List<Widget> _buildLectureItems() {
    return List.generate(items.length * 2 - 1, (index) {
      if (index.isEven) {
        final item = items[index ~/ 2];
        return _LectureListItem(
          title: item.title,
          description: item.description,
          isOpened: item.isOpened,
          isPreview: item.isPreview,
          width: width,
          showBottomLine: index ~/ 2 < items.length - 1,
          showTopLine: index ~/ 2 > 0,
        );
      } else {
        return _LectureConnector(isOpened: items[index ~/ 2].isOpened);
      }
    });
  }
}

/// 개별 강의 항목을 표시하는 위젯
///
/// 강의의 제목, 설명, 상태 및 미리보기 여부를 표시합니다.
/// 상태에 따라 텍스트 색상과 연결선이 다르게 표시됩니다.
class _LectureListItem extends StatelessWidget {
  final String title;
  final String description;
  final bool isOpened;
  final bool isPreview;
  final double width;
  final bool showBottomLine;
  final bool showTopLine;

  const _LectureListItem({
    required this.title,
    required this.description,
    required this.isOpened,
    required this.isPreview,
    required this.width,
    required this.showBottomLine,
    required this.showTopLine,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(
        children: [
          _buildMainContent(),
          if (showTopLine) _buildTopLine(),
          if (showBottomLine) _buildBottomLine(),
        ],
      ),
    );
  }

  /// 강의 항목의 주요 내용을 구성합니다.
  Widget _buildMainContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBulletPoint(),
        const SizedBox(width: 8),
        Expanded(
          child: _buildTextContent(),
        ),
      ],
    );
  }

  /// 강의 항목의 불릿 포인트를 생성합니다.
  Widget _buildBulletPoint() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Container(
        width: 16,
        height: 16,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: OvalBorder(
            side: BorderSide(
              width: 2,
              color: isOpened ? AppColors.primary : AppColors.gray300,
            ),
          ),
        ),
      ),
    );
  }

  /// 강의 제목과 설명을 포함한 텍스트 내용을 구성합니다.
  Widget _buildTextContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 6),
          _buildTitleRow(),
          const SizedBox(height: 4),
          _buildDescription(),
        ],
      ),
    );
  }

  /// 강의 제목과 미리보기 태그를 포함한 행을 구성합니다.
  Widget _buildTitleRow() {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyle.listTitle,
          ),
        ),
        if (isPreview) _buildPreviewTag(),
      ],
    );
  }

  /// 미리보기 태그를 생성합니다.
  Widget _buildPreviewTag() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: ShapeDecoration(
        color: AppColors.primary.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Text(
        '미리보기',
        style: AppTextStyle.tag.copyWith(
          color: AppColors.primary,
        ),
      ),
    );
  }

  /// 강의 설명을 표시하는 텍스트를 생성합니다.
  Widget _buildDescription() {
    return Text(
      description,
      style: AppTextStyle.description,
    );
  }

  /// 상단 연결선을 생성합니다.
  Widget _buildTopLine() {
    return Positioned(
      left: 8,
      top: 0,
      child: CustomPaint(
        size: const Size(2, 12),
        painter: _TopLinePainter(isOpened: isOpened),
      ),
    );
  }

  /// 하단 연결선을 생성합니다.
  Widget _buildBottomLine() {
    return Positioned(
      left: 8,
      top: 28,
      child: CustomPaint(
        size: const Size(2, 48),
        painter: _BottomLinePainter(isOpened: isOpened),
      ),
    );
  }
}

/// 강의 항목 사이의 연결선을 그리는 위젯
class _LectureConnector extends StatelessWidget {
  final bool isOpened;

  const _LectureConnector({required this.isOpened});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 4,
      child: CustomPaint(
        painter: _ConnectorPainter(isOpened: isOpened),
      ),
    );
  }
}

/// 강의 항목 사이의 연결선을 그리는 CustomPainter
class _ConnectorPainter extends CustomPainter {
  final bool isOpened;

  _ConnectorPainter({required this.isOpened});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isOpened ? AppColors.primary : AppColors.gray300
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 강의 항목 상단의 연결선을 그리는 CustomPainter
class _TopLinePainter extends CustomPainter {
  final bool isOpened;

  _TopLinePainter({required this.isOpened});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isOpened ? AppColors.primary : AppColors.gray300
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(0, 0),
      Offset(0, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 강의 항목 하단의 연결선을 그리는 CustomPainter
class _BottomLinePainter extends CustomPainter {
  final bool isOpened;

  _BottomLinePainter({required this.isOpened});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isOpened ? AppColors.primary : AppColors.gray300
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(0, 0),
      Offset(0, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
