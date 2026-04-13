import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sana/app/modules/chat/controllers/chat_controller.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';

class PromptField extends GetView<ChatController> {
  const PromptField({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.neutral,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withAlpha(50),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: controller.promptController,
                decoration: InputDecoration(
                  hint: Text(
                    'Consult sana or describe symptoms',
                    style: theme.textTheme.bodyMedium,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          InkWell(
            onTap: () => controller.getReply(),
            child: Container(
              decoration: BoxDecoration(color: Color(0xFF005BC0)),
              padding: EdgeInsets.all(17),
              child: Icon(Icons.send, color: AppColors.neutral),
            ),
          ),
        ],
      ),
    );
  }
}
