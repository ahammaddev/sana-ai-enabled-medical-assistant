import 'package:flutter/material.dart';
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
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: controller.promptController,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (val) {
                  if (val.trim().isNotEmpty && !controller.replyLoading.value) {
                    controller.getReply();
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Consult Sana or describe symptoms...',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.secondary,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Obx(
            () => InkWell(
              onTap: controller.replyLoading.value
                  ? null
                  : () {
                      if (controller.promptController.text.trim().isNotEmpty) {
                        controller.getReply();
                      }
                    },
              child: Container(
                decoration: const BoxDecoration(color: Color(0xFF005BC0)),
                padding: const EdgeInsets.all(17),
                child: controller.replyLoading.value
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.neutral,
                        ),
                      )
                    : const Icon(Icons.send, color: AppColors.neutral),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
