import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';

/// Flat, square confirmation dialogs styled like the in-chat status blocks
/// and snackbars (thin accent bar, uppercase label, `> message.` line).
class ConfirmDialog {
  ConfirmDialog._();

  static void destructive({
    required String title,
    required String message,
    required String confirmText,
    required VoidCallback onConfirm,
  }) {
    Get.dialog(
      _ConfirmDialogContent(
        title: title,
        message: message,
        confirmText: confirmText,
        icon: Icons.delete_outline_rounded,
        accent: AppColors.tertiary,
        onConfirm: () {
          Get.back();
          onConfirm();
        },
      ),
      barrierColor: AppColors.primarydark.withAlpha(60),
      transitionDuration: const Duration(milliseconds: 200),
    );
  }
}

class _ConfirmDialogContent extends StatelessWidget {
  const _ConfirmDialogContent({
    required this.title,
    required this.message,
    required this.confirmText,
    required this.icon,
    required this.accent,
    required this.onConfirm,
  });

  final String title;
  final String message;
  final String confirmText;
  final IconData icon;
  final Color accent;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final outline = BorderSide(
      width: 1,
      color: AppColors.secondary.withAlpha(40),
    );
    const buttonShape = RoundedRectangleBorder(borderRadius: BorderRadius.zero);
    final labelStyle = theme.textTheme.labelLarge?.copyWith(letterSpacing: 1.0);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: buttonShape,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(width: 2, color: accent),
              top: outline,
              right: outline,
              bottom: outline,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondary.withAlpha(60),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    color: accent.withAlpha(20),
                    child: Icon(icon, size: 20, color: accent),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title.toUpperCase(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: accent,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                color: accent.withAlpha(10),
                child: Text(
                  '> ${message.trim()}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.primarydark.withAlpha(200),
                    height: 1.35,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '> this action cannot be undone.',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 10.5,
                  color: AppColors.secondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(
                          color: AppColors.secondary.withAlpha(80),
                          width: 1,
                        ),
                        shape: buttonShape,
                      ),
                      onPressed: Get.back,
                      child: Text(
                        'CANCEL',
                        style: labelStyle?.copyWith(
                          color: AppColors.primarydark,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        shape: buttonShape,
                      ),
                      onPressed: onConfirm,
                      child: Text(
                        confirmText.toUpperCase(),
                        style: labelStyle?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
