import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sana/app/modules/chat/controllers/chat_controller.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';

class UserChatBubble extends GetView<ChatController> {
  final String usermessage;
  final String usertimestamp;

  const UserChatBubble({
    super.key,
    required this.usermessage,
    required this.usertimestamp,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxWidth = MediaQuery.of(context).size.width * 0.78;

    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'USER QUERY',
                style: theme.textTheme.bodySmall!.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
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
                border: Border.all(
                  width: 1,
                  color: AppColors.secondary.withAlpha(40),
                ),
              ),
              child: Text(
                usermessage,
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontSize: 15,
                  height: 1.35,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            usertimestamp,
            style: theme.textTheme.bodySmall!.copyWith(
              color: Colors.grey.withAlpha(150),
            ),
          ),
        ],
      ),
    );
  }
}
