import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sana/app/modules/chat/views/chat_intro.dart';
import 'package:sana/app/modules/chat/views/message_pair.dart';
import 'package:sana/app/modules/chat/views/prompt_field.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';
import 'package:sana/app/utils/constants/helpers/confirm_dialog.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
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
          leading: Navigator.canPop(context)
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  onPressed: () => Get.back(),
                )
              : null,
          title: Obx(() {
            final title = controller.sessionTitle.value.isNotEmpty
                ? controller.sessionTitle.value
                : 'Sana';
            return Row(
              children: [
                const FaIcon(FontAwesomeIcons.robot, color: AppColors.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: AppColors.primary,
                      fontSize: 22,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          }),
          actions: [
            Obx(
              () => IconButton(
                icon: const Icon(Icons.add, color: AppColors.primary),
                tooltip: 'New Consultation',
                onPressed: controller.replyLoading.value
                    ? null
                    : controller.startNewConsultation,
              ),
            ),
            Obx(() {
              if (controller.messages.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: AppColors.secondary,
                ),
                tooltip: 'Clear Consultation',
                onPressed: controller.replyLoading.value
                    ? null
                    : () => ConfirmDialog.destructive(
                        title: 'Clear Consultation',
                        message:
                            'Are you sure you want to clear this consultation inbox?',
                        confirmText: 'Clear',
                        onConfirm: controller.clearCurrentConsultation,
                      ),
              );
            }),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isloading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  physics: const BouncingScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: controller.messages.length + 1,
                  reverse: true,
                  itemBuilder: (context, index) {
                    if (index == controller.messages.length) {
                      return ChatIntro(showTopics: controller.messages.isEmpty);
                    }
                    final message = controller.messages[index];
                    return MessagePair(
                      key: ValueKey('message_${message.id}'),
                      message: message,
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: PromptField(),
            ),
            const SizedBox(height: 10),
            Text(
              '© 2026 MD. FAISAL AHAMMAD',
              style: theme.textTheme.bodySmall!.copyWith(
                color: AppColors.primarydark,
              ),
            ),
            SizedBox(height: 20 + MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
