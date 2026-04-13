import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:sana/app/modules/chat/views/bot_chat_bubble.dart';
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
        body: BotChatBubble(),
      ),
    );
  }
}
