import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:sana/app/modules/chat/views/bot_chat_bubble.dart';
import 'package:sana/app/modules/chat/views/bot_fails.dart';
import 'package:sana/app/modules/chat/views/bot_loading.dart';
import 'package:sana/app/modules/chat/views/prompt_field.dart';
import 'package:sana/app/modules/chat/views/user_chat_bubble.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral,
        image: DecorationImage(
          image: AssetImage('assets/images/lines.png'),
          fit: BoxFit.cover,
          opacity: 0.08,
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.grey.withAlpha(10),
        appBar: AppBar(
          surfaceTintColor: AppColors.neutral,
          backgroundColor: AppColors.neutral,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.robot, color: AppColors.primary),
                  SizedBox(width: 5),
                  Text(
                    'Sana',
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: AppColors.primary,
                      fontSize: 26,
                    ),
                  ),
                ],
              ),
              // Image.asset(''),
            ],
          ),
        ),
        body: Obx(
          () => controller.isloading.value
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        physics: ClampingScrollPhysics(),
                        itemCount: controller.messages.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final message = controller.messages[index];
                          final isNewestMessage = index == 0;
                          print(message.bottimestamp);

                          return Column(
                            children: [
                              UserChatBubble(
                                // SAFE: Provide a fallback instead of forcing a crash
                                usermessage:
                                    message.userMessage ??
                                    'Message unavailable',
                                usertimestamp: message.usertimestamp ?? '',
                              ),

                              // UI FIX: Only show the loading animation for the newest message.
                              // Older messages will fall through to display their actual content.
                              (controller.replyLoading.value && isNewestMessage)
                                  ? const BotLoading()
                                  : message.botMessage != null
                                  ? BotChatBubble(
                                      botMessage: message.botMessage!,
                                      // SAFE: Handle null timestamps gracefully
                                      timestamp: message.bottimestamp ?? '',
                                    )
                                  : const BotFails(),

                              // BotLoading(),
                            ],
                          );
                        },
                      ),
                    ),
                    // SizedBox(height: 10),

                    // BotFails(),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: PromptField(),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '© 2026 MD. FAISAL AHAMMAD',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.primarydark,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
        ),
      ),
    );
  }
}
