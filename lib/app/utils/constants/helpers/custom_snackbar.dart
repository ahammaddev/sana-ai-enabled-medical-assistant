import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';

/// Flat, square notices styled like the in-chat status blocks
/// (thin accent bar, uppercase label, `> message.` line).
class CustomSnackbars {
  CustomSnackbars._();

  static void failure({required String title, required String message}) {
    _show(
      title: title,
      message: message,
      icon: Icons.error_outline_rounded,
      accent: AppColors.tertiary,
      textColor: AppColors.tertiary,
    );
  }

  static void success({required String title, required String message}) {
    _show(
      title: title,
      message: message,
      icon: Icons.check_circle_outline_rounded,
      accent: AppColors.primary,
      textColor: AppColors.primarydark,
    );
  }

  static void _show({
    required String title,
    required String message,
    required IconData icon,
    required Color accent,
    required Color textColor,
  }) {
    // Replace any visible notice instead of queueing behind it.
    Get.closeAllSnackbars();
    Get.showSnackbar(
      GetSnackBar(
        messageText: _SnackbarContent(
          title: title,
          message: message,
          icon: icon,
          accent: accent,
          textColor: textColor,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        borderRadius: 0,
        duration: const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 400),
        forwardAnimationCurve: Curves.easeOutCubic,
        reverseAnimationCurve: Curves.easeInCubic,
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}

class _SnackbarContent extends StatelessWidget {
  const _SnackbarContent({
    required this.title,
    required this.message,
    required this.icon,
    required this.accent,
    required this.textColor,
  });

  final String title;
  final String message;
  final IconData icon;
  final Color accent;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final outline = BorderSide(width: 1, color: accent.withAlpha(40));
    final text = message.trim();

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
      decoration: BoxDecoration(
        color: Color.alphaBlend(accent.withAlpha(12), Colors.white),
        border: Border(
          left: BorderSide(width: 2, color: accent),
          top: outline,
          right: outline,
          bottom: outline,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withAlpha(50),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            color: accent.withAlpha(20),
            child: Icon(icon, size: 18, color: accent),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title.toUpperCase(),
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
                if (text.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    '> $text',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: textColor.withAlpha(170),
                      height: 1.3,
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            tooltip: 'Dismiss',
            visualDensity: VisualDensity.compact,
            icon: Icon(Icons.close, size: 16, color: textColor.withAlpha(150)),
            onPressed: Get.closeCurrentSnackbar,
          ),
        ],
      ),
    );
  }
}
