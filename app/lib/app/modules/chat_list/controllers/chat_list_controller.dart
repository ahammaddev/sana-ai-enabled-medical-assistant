import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sana/app/data/models/consultation_model.dart';
import 'package:sana/app/data/repository/database_repository.dart';
import 'package:sana/app/utils/constants/helpers/custom_snackbar.dart';
import 'package:sana/app/utils/routes/app_pages.dart';

class ChatListController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<ConsultationModel> conversations = <ConsultationModel>[].obs;
  final RxString searchQuery = ''.obs;
  final TextEditingController searchController = TextEditingController();
  final AppDatabase _dbService = AppDatabase.instance;

  List<ConsultationModel> get filteredConversations {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) {
      return conversations;
    }
    return conversations.where((conv) {
      final titleText = conv.title.toLowerCase();
      final lastMsgText = conv.lastMessage?.toLowerCase() ?? '';
      return titleText.contains(query) || lastMsgText.contains(query);
    }).toList();
  }

  Future<void> fetchConversations() async {
    isLoading.value = true;
    try {
      final fetched = await _dbService.getConversations();
      conversations.assignAll(fetched);
    } catch (e) {
      CustomSnackbars.failure(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteConversation(String sessionId) async {
    try {
      await _dbService.deleteConversation(sessionId);
      conversations.removeWhere((c) => c.id == sessionId);
      CustomSnackbars.success(
        title: 'Deleted',
        message: 'Consultation deleted from history.',
      );
    } catch (e) {
      CustomSnackbars.failure(title: 'Error', message: e.toString());
    }
  }

  Future<void> clearAllConversations() async {
    try {
      await _dbService.clearAllConversations();
      conversations.clear();
      CustomSnackbars.success(
        title: 'Cleared',
        message: 'All consultation history cleared.',
      );
    } catch (e) {
      CustomSnackbars.failure(title: 'Error', message: e.toString());
    }
  }

  void openConversation(ConsultationModel conversation) {
    Get.toNamed(
      Routes.CHAT,
      arguments: {'sessionId': conversation.id, 'title': conversation.title},
    )?.then((_) => fetchConversations());
  }

  void newConsultation() {
    Get.toNamed(
      Routes.CHAT,
      arguments: {'sessionId': null, 'title': null},
    )?.then((_) => fetchConversations());
  }

  @override
  void onInit() {
    super.onInit();
    fetchConversations();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
