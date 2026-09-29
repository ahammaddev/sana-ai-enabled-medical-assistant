import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sana/app/modules/chat/controllers/chat_controller.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';

class BotChatBubble extends GetView<ChatController> {
  const BotChatBubble({
    super.key,
    required this.botMessage,
    required this.timestamp,
  });

  final String botMessage;
  final String timestamp;

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
            constraints: BoxConstraints(
              maxWidth: maxWidth,
            ),
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
                borderRadius: BorderRadius.circular(5),
                border: Border(
                  top: BorderSide(width: 1, color: Colors.white.withAlpha(200)),
                ),
              ),
              child: Text(
                botMessage,
                style: theme.textTheme.bodySmall!.copyWith(),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            timestamp,
            style: theme.textTheme.bodySmall!.copyWith(
              color: Colors.grey.withAlpha(150),
            ),
          ),
        ],
      ),
    );
  }
}
