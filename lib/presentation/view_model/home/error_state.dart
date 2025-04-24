/// 에러 상태를 나타내는 클래스
class ErrorState {
  final String message;
  final bool canRetry;
  final Function() onRetry;

  ErrorState({
    required this.message,
    required this.canRetry,
    required this.onRetry,
  });
}
