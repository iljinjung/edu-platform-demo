/// 검색 기능의 상태를 관리하는 클래스
class SearchState {
  /// 검색 기능 활성화 여부
  bool isEnabled;

  /// 비활성화 시간 (초)
  final int cooldownSeconds;

  /// 생성자
  SearchState({
    this.isEnabled = true,
    this.cooldownSeconds = 2,
  });

  /// 검색 버튼 클릭 처리
  ///
  /// 클릭 시 검색 버튼을 비활성화하고 [cooldownSeconds] 후에 다시 활성화
  ///
  /// Returns: Future that completes when the cooldown is finished
  Future<void> handleSearchTap() async {
    if (!isEnabled) return;

    isEnabled = false;
    await Future.delayed(Duration(seconds: cooldownSeconds));
    isEnabled = true;
  }
}
