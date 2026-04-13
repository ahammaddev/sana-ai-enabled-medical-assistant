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
    return Container(
      padding: EdgeInsets.only(right: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                'AHAMMAD INTELLIGENCE',
                style: theme.textTheme.bodySmall!.copyWith(
                  color: AppColors.primary,

                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 5),
              Obx(
                () => AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.linear,
                  decoration: BoxDecoration(
                    color: controller.blinkController.value
                        ? theme.colorScheme.primary
                        : theme.colorScheme.primary.withAlpha(1),
                    shape: BoxShape.circle,
                  ),

                  padding: EdgeInsets.all(4),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.grey,
              boxShadow: [
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
          SizedBox(height: 10),
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
