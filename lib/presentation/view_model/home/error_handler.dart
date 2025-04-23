import 'package:get/get.dart';
import 'error_state.dart';

/// 에러 처리를 담당하는 클래스
class ErrorHandler {
  /// 현재 에러 상태
  final Rxn<ErrorState> currentError = Rxn<ErrorState>();

  /// 에러 발생 시 호출되는 메서드
  void handleError(ErrorState error) {
    currentError.value = error;
  }

  /// 에러 상태 초기화
  void clearError() {
    currentError.value = null;
  }
}
