import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_dialog.dart';

class AppConfirmDialog {
  static Future<void> show({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    IconData icon = Icons.help_outline_rounded,
    bool isDestructive = true,
  }) {
    final color = isDestructive ? Colors.red : const Color(0xFF6C5CE7);
    return AppDialog.show(
      title: title,
      message: message,
      icon: icon,
      iconBackgroundColor: color.withAlpha(30),
      iconColor: color,
      primaryButtonText: confirmText,
      primaryButtonColor: color,
      secondaryButtonText: cancelText,
      onPrimaryTap: () {
        Get.back(); // dialog বন্ধ
        onConfirm();
      },
    );
  }
}
