import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sana/app/modules/chat/controllers/chat_controller.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';
import 'package:sana/app/utils/constants/helpers/custom_snackbar.dart';

class BotChatBubble extends GetView<ChatController> {
  const BotChatBubble({
    super.key,
    required this.botMessage,
    required this.timestamp,
  });

  final String botMessage;
  final String timestamp;

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: botMessage));
    CustomSnackbars.success(
      title: 'Copied',
      message: 'Consultation response copied to clipboard.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxWidth = MediaQuery.of(context).size.width * 0.82;

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'AHAMMAD INTELLIGENCE',
                style: theme.textTheme.bodySmall!.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 5),
              Obx(
                () => AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.linear,
                  decoration: BoxDecoration(
                    color: controller.blinkController.value
                        ? theme.colorScheme.primary
                        : theme.colorScheme.primary.withAlpha(1),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.grey,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.grey,
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
                border: Border(
                  top: BorderSide(width: 1, color: Colors.white.withAlpha(200)),
                ),
              ),
              child: SelectableText(
                botMessage,
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontSize: 15,
                  height: 1.35,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                timestamp,
                style: theme.textTheme.bodySmall!.copyWith(
                  color: Colors.grey.withAlpha(150),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: _copyToClipboard,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.copy_rounded,
                        size: 11,
                        color: Colors.grey.withAlpha(150),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        'Copy',
                        style: theme.textTheme.bodySmall!.copyWith(
                          fontSize: 10.5,
                          color: Colors.grey.withAlpha(150),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
