import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sana/app/modules/chat_list/controllers/chat_list_controller.dart';
import 'package:sana/app/modules/chat_list/views/consultation_card.dart';
import 'package:sana/app/modules/chat_list/views/consultation_search_field.dart';
import 'package:sana/app/modules/chat_list/views/empty_consultations.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';
import 'package:sana/app/utils/constants/helpers/confirm_dialog.dart';

class ChatListView extends GetView<ChatListController> {
  const ChatListView({super.key});

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
                  tooltip: 'Back',
                  onPressed: () => Get.back(),
                )
              : null,
          title: Row(
            children: [
              const FaIcon(FontAwesomeIcons.robot, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Consultations',
                style: theme.textTheme.titleLarge!.copyWith(
                  color: AppColors.primary,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: AppColors.primary),
              tooltip: 'Refresh',
              onPressed: controller.fetchConversations,
            ),
            Obx(() {
              if (controller.conversations.isEmpty) {
                return const SizedBox.shrink();
              }
              return IconButton(
                icon: const Icon(
                  Icons.delete_sweep_outlined,
                  color: AppColors.secondary,
                ),
                tooltip: 'Clear All Consultations',
                onPressed: () => ConfirmDialog.destructive(
                  title: 'Clear All Consultations',
                  message:
                      'Are you sure you want to delete all past consultation inboxes?',
                  confirmText: 'Clear All',
                  onConfirm: controller.clearAllConversations,
                ),
              );
            }),
          ],
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: ConsultationSearchField(),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value &&
                    controller.conversations.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                final items = controller.filteredConversations;

                if (items.isEmpty) {
                  return EmptyConsultations(
                    isSearching: controller.searchQuery.value.isNotEmpty,
                    onNewConsultation: controller.newConsultation,
                  );
                }

                return RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: controller.fetchConversations,
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: items.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ConsultationCard(
                        key: ValueKey(item.id),
                        consultation: item,
                        onTap: () => controller.openConversation(item),
                        onDelete: () => controller.deleteConversation(item.id),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
        // Hidden when there is no history; the empty state has its own button.
        floatingActionButton: Obx(() {
          if (controller.conversations.isEmpty) return const SizedBox.shrink();
          return FloatingActionButton.extended(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            onPressed: controller.newConsultation,
            icon: const Icon(Icons.add),
            label: const Text(
              'NEW CONSULTATION',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }),
      ),
    );
  }
}
