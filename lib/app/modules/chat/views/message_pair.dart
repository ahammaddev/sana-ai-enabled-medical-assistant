import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sana/app/data/models/message_model.dart';
import 'package:sana/app/modules/chat/controllers/chat_controller.dart';
import 'package:sana/app/modules/chat/views/bot_chat_bubble.dart';
import 'package:sana/app/modules/chat/views/bot_fails.dart';
import 'package:sana/app/modules/chat/views/bot_loading.dart';
import 'package:sana/app/modules/chat/views/user_chat_bubble.dart';
import 'package:sana/app/utils/constants/helpers/date_formatter.dart';

/// A user query followed by Sana's reply (or its loading / failed state).
class MessagePair extends GetView<ChatController> {
  const MessagePair({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UserChatBubble(
            usermessage: message.userMessage ?? 'Message unavailable',
            usertimestamp: DateFormatter.messageTime(
              message.usertimestamp ?? '',
            ),
          ),
          const SizedBox(height: 12),
          Obx(() {
            if (controller.pendingMessageId.value == message.id) {
              return const BotLoading();
            }
            if (message.botMessage != null) {
              return BotChatBubble(
                botMessage: message.botMessage!,
                timestamp: DateFormatter.messageTime(
                  message.bottimestamp ?? '',
                ),
              );
            }
            return BotFails(
              onRetry: controller.replyLoading.value
                  ? null
                  : () => controller.retryMessage(message),
            );
          }),
        ],
      ),
    );
  }
}
