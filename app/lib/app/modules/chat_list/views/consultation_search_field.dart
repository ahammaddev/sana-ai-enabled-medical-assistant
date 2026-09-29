import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sana/app/modules/chat_list/controllers/chat_list_controller.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';

class ConsultationSearchField extends GetView<ChatListController> {
  const ConsultationSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral,
        border: Border.all(width: 1, color: AppColors.secondary.withAlpha(40)),
      ),
      child: TextField(
        controller: controller.searchController,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search consultations...',
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.secondary,
          ),
          prefixIcon: const Icon(Icons.search, color: AppColors.secondary),
          suffixIcon: Obx(() {
            if (controller.searchQuery.value.isEmpty) {
              return const SizedBox.shrink();
            }
            return IconButton(
              icon: const Icon(Icons.clear, size: 18),
              onPressed: controller.searchController.clear,
            );
          }),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
