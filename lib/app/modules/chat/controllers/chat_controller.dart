import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sana/app/data/models/consultation_model.dart';
import 'package:sana/app/data/models/message_model.dart';
import 'package:sana/app/data/repository/chat_repository.dart';
import 'package:sana/app/data/repository/database_repository.dart';
import 'package:sana/app/modules/global/controllers/global_controller.dart';
import 'package:sana/app/utils/constants/helpers/custom_snackbar.dart';
import 'package:sana/app/utils/constants/helpers/date_formatter.dart';

class ChatController extends GetxController {
  final RxString sessionId = ''.obs;
  final RxString sessionTitle = ''.obs;
  final RxString sessionCreatedAt = ''.obs;
  final RxBool isloading = false.obs;
  final RxBool replyLoading = false.obs;
  final RxnInt pendingMessageId = RxnInt();
  final RxBool blinkController = false.obs;
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final TextEditingController promptController = TextEditingController();
  final AppDatabase _dbService = AppDatabase.instance;
  Timer? _blinkTimer;

  void blinking() {
    _blinkTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      blinkController.value = !blinkController.value;
    });
  }

  Future<void> fetchData() async {
    if (sessionId.value.isEmpty) {
      messages.clear();
      return;
    }

    isloading.value = messages.isEmpty;
    try {
      final fetchedMessages = await _dbService.getMessagesBySession(
        sessionId.value,
      );
      if (isClosed) return;
      messages.assignAll(fetchedMessages);
    } catch (e) {
      if (!isClosed) {
        CustomSnackbars.failure(title: 'Error', message: e.toString());
      }
    } finally {
      if (!isClosed) isloading.value = false;
    }
  }

  void sendPrompt(String prompt) {
    if (replyLoading.value) return;
    promptController.text = prompt;
    getReply();
  }

  void startNewConsultation() {
    if (replyLoading.value) return;
    sessionId.value = '';
    sessionTitle.value = '';
    sessionCreatedAt.value = '';
    messages.clear();
    promptController.clear();
  }

  Future<void> clearCurrentConsultation() async {
    try {
      if (sessionId.value.isNotEmpty) {
        await _dbService.deleteConversation(sessionId.value);
      }
      startNewConsultation();
      CustomSnackbars.success(
        title: 'Cleared',
        message: 'This consultation has been cleared.',
      );
    } catch (e) {
      CustomSnackbars.failure(title: 'Error', message: e.toString());
    }
  }

  Future<bool> _ensureOnline() async {
    final global = Get.isRegistered<GlobalController>()
        ? Get.find<GlobalController>()
        : null;
    if (global == null) return true;
    final online = await global.checkInternetConnectivity();
    if (!online) {
      CustomSnackbars.failure(
        title: 'Offline',
        message: 'No internet connection. Please check your network.',
      );
    }
    return online;
  }

  Future<void> getReply() async {
    final promptText = promptController.text.trim();
    if (promptText.isEmpty || replyLoading.value) return;
    if (!await _ensureOnline()) return;

    final time = DateFormatter.now();

    // 1. If this is a new consultation, create the conversation inbox entry
    if (sessionId.value.isEmpty) {
      final newSessionId = DateTime.now().millisecondsSinceEpoch.toString();
      final title = promptText.length > 35
          ? '${promptText.substring(0, 35)}...'
          : promptText;

      await _dbService.insertConversation(
        ConsultationModel(
          id: newSessionId,
          title: title,
          createdAt: time,
          updatedAt: time,
          lastMessage: promptText,
        ),
      );

      sessionId.value = newSessionId;
      sessionTitle.value = title;
      sessionCreatedAt.value = time;
    }

    // 2. Create the message linked to the current consultation sessionId
    final message = MessageModel(
      sessionId: sessionId.value,
      userMessage: promptText,
      usertimestamp: time,
    );

    message.id = await _dbService.insertMessage(message);
    promptController.clear();
    await fetchData();

    await _requestReply(message);
  }

  Future<void> retryMessage(MessageModel message) async {
    if (replyLoading.value || message.userMessage == null) return;
    if (!await _ensureOnline()) return;
    await _requestReply(message);
  }

  /// Fetches the bot reply for [message] and persists the outcome. The
  /// session details are captured up front so the result is written to the
  /// right consultation even if the user switches away mid-request.
  Future<void> _requestReply(MessageModel message) async {
    final targetSessionId = message.sessionId ?? sessionId.value;
    final targetTitle = sessionTitle.value;
    final targetCreatedAt = sessionCreatedAt.value;

    replyLoading.value = true;
    pendingMessageId.value = message.id;

    try {
      // Earlier exchanges of this consultation, sent along as context.
      final sessionMessages = await _dbService.getMessagesBySession(
        targetSessionId,
      );
      final history = sessionMessages
          .where((m) => (m.id ?? 0) < (message.id ?? 0))
          .toList();

      final reply = await ChatRepository().getMessage(
        prompt: message.userMessage!,
        history: history,
      );

      if (reply.status?.toLowerCase() == 'success' &&
          reply.botMessage != null) {
        final replyTime = reply.bottimestamp ?? DateFormatter.now();
        message.botMessage = reply.botMessage;
        message.bottimestamp = replyTime;
        message.status = reply.status;
        await _dbService.updateMessage(message);

        // Update consultation record's last message and updatedAt
        await _dbService.updateConversation(
          ConsultationModel(
            id: targetSessionId,
            title: targetTitle,
            createdAt: targetCreatedAt.isNotEmpty ? targetCreatedAt : replyTime,
            updatedAt: replyTime,
            lastMessage: message.botMessage,
          ),
        );
      } else {
        message.status = 'failed';
        await _dbService.updateMessage(message);
      }
    } catch (e) {
      message.status = 'error';
      await _dbService.updateMessage(message);
    } finally {
      if (!isClosed) {
        replyLoading.value = false;
        pendingMessageId.value = null;
        if (sessionId.value == targetSessionId) await fetchData();
      }
    }
  }

  Future<void> _loadSessionMeta() async {
    try {
      final conversation = await _dbService.getConversation(sessionId.value);
      if (conversation == null || isClosed) return;
      sessionCreatedAt.value = conversation.createdAt;
      if (sessionTitle.value.isEmpty) sessionTitle.value = conversation.title;
    } catch (_) {}
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map) {
      sessionId.value = args['sessionId'] as String? ?? '';
      sessionTitle.value = args['title'] as String? ?? '';
    }
    if (sessionId.value.isNotEmpty) {
      _loadSessionMeta();
      fetchData();
    }
    blinking();
  }

  @override
  void onClose() {
    _blinkTimer?.cancel();
    promptController.dispose();
    super.onClose();
  }
}
