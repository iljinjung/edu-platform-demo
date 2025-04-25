/// 마크다운과 HTML 관련 유틸리티 함수들을 제공하는 클래스
class MarkdownUtils {
  /// 마크다운 형식인지 확인
  static bool isMarkdownFormat(String text) {
    // 일반적인 마크다운 패턴들을 확인
    final markdownPatterns = [
      r'^#{1,6}\s', // 헤더
      r'\*\*.+?\*\*', // 볼드
      r'__.+?__', // 볼드
      r'`{1,3}[^`]+`{1,3}', // 코드
      r'^\s*[-*+]\s', // 리스트
      r'^\s*\d+\.\s', // 숫자 리스트
      r'\[.+?\]\(.+?\)', // 링크
      r'!\[.+?\]\(.+?\)', // 이미지
    ];

    for (final pattern in markdownPatterns) {
      if (RegExp(pattern, multiLine: true).hasMatch(text)) {
        return true;
      }
    }
    return false;
  }

  /// HTML 태그가 포함되어 있는지 확인
  static bool containsHtmlTags(String text) {
    return RegExp(r'<(br|img|input|hr|div|p|span|a)[^>]*>',
            caseSensitive: false)
        .hasMatch(text);
  }

  /// 마크다운 텍스트 전처리
  ///
  /// - HTML의 <br> 태그를 마크다운 줄바꿈으로 변환
  static String preprocessMarkdown(String text) {
    return text.replaceAll('<br>', '  \n');
  }

  /// 주어진 텍스트가 마크다운 렌더러를 사용해야 하는지 확인
  ///
  /// HTML 태그가 없고 마크다운 형식이면 true를 반환
  static bool shouldUseMarkdownRenderer(String? text) {
    if (text == null || text.isEmpty) return false;
    return !containsHtmlTags(text) && isMarkdownFormat(text);
  }
}
