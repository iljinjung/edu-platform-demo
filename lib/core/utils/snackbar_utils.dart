import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';

/// GetX Snackbar를 쉽게 사용하기 위한 유틸리티 클래스
///
/// 앱 전체에서 일관된 스타일의 스낵바를 표시하기 위해 사용됩니다.
class SnackbarUtils {
  /// 에러 메시지를 표시하는 스낵바
  ///
  /// [message] 표시할 에러 메시지
  static void showError(String message) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    Get.snackbar(
      '알림',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.danger.withOpacity(0.1),
      colorText: AppColors.danger,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      icon: Icon(Icons.error_outline, color: AppColors.danger),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutCirc,
    );
  }

  /// 성공 메시지를 표시하는 스낵바
  ///
  /// [message] 표시할 성공 메시지
  static void showSuccess(String message) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    Get.snackbar(
      '알림',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primary.withOpacity(0.1),
      colorText: AppColors.primary,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      icon: Icon(Icons.check_circle_outline, color: AppColors.primary),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutCirc,
    );
  }

  /// 정보 메시지를 표시하는 스낵바
  ///
  /// [message] 표시할 정보 메시지
  static void showInfo(String message) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    Get.snackbar(
      '알림',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.title.withOpacity(0.1),
      colorText: AppColors.title,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      icon: Icon(Icons.info_outline, color: AppColors.title),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutCirc,
    );
  }

  /// 경고 메시지를 표시하는 스낵바
  ///
  /// [message] 표시할 경고 메시지
  static void showWarning(String message) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    Get.snackbar(
      '알림',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.gray400.withOpacity(0.1),
      colorText: AppColors.gray500,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      icon: Icon(Icons.warning_amber_outlined, color: AppColors.gray500),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutCirc,
    );
  }

  /// 재시도 가능한 에러 메시지를 표시하는 스낵바
  ///
  /// [message] 표시할 에러 메시지
  /// [onRetry] 재시도 버튼 클릭 시 실행할 콜백
  static void showRetryableError(String message, VoidCallback onRetry) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    Get.snackbar(
      '알림',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.danger.withOpacity(0.1),
      colorText: AppColors.danger,
      duration: null,
      margin: const EdgeInsets.all(16),
      icon: Icon(Icons.error_outline, color: AppColors.danger),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutCirc,
      mainButton: TextButton(
        onPressed: onRetry,
        child: Text(
          '재시도',
          style: TextStyle(color: AppColors.danger),
        ),
      ),
    );
  }
}
