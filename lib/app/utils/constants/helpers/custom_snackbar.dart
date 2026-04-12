import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';

class CustomSnackbars {
  CustomSnackbars._();

  static void failure({required String title, required String message}) {
    Get.rawSnackbar(
      title: title,
      message: message,
      snackPosition: SnackPosition.TOP,
      icon: Icon(Icons.error_outline_outlined, color: AppColors.neutral),

      animationDuration: const Duration(seconds: 1),
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(15),
      borderRadius: 4,
      backgroundColor: AppColors.tertiary,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  static void success({required String title, required String message}) {
    Get.rawSnackbar(
      title: title,
      message: message,
      snackPosition: SnackPosition.TOP,
      icon: Icon(Icons.check_circle_outline),
      animationDuration: const Duration(seconds: 1),
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(15),
      borderRadius: 4,
      backgroundColor: AppColors.primary,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}
