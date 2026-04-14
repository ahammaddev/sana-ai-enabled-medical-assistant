import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sana/app/data/models/message_model.dart';
import 'package:sana/app/data/repository/chat_repository.dart';
import 'package:sana/app/data/repository/database_repository.dart';
import 'package:sana/app/utils/constants/helpers/custom_snackbar.dart';

class ChatController extends GetxController {
  RxBool isloading = false.obs;
  RxBool replyLoading = false.obs;
  RxBool blinkController = false.obs;
  RxList<MessageModel> messages = <MessageModel>[].obs;
  final TextEditingController promptController = TextEditingController();
  final AppDatabase _dbService = AppDatabase.instance;

  void blinking() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      blinkController.value = !blinkController.value;
    });
  }

  Future<void> fetchData() async {
    isloading.value = true;
    try {
      final fetchedMessages = await _dbService.getMessage();
      messages.assignAll(fetchedMessages);
    } catch (e) {
      CustomSnackbars.failure(title: 'Error', message: e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> getReply() async {
    final now = DateTime.now();
    final time = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    print(time);

    // 1. Initial State: Create the message with just the user's input
    MessageModel message = MessageModel(
      userMessage: promptController.text,
      usertimestamp: time,
    );

    // 2. CRITICAL: Capture the auto-generated ID from SQLite
    // When you insert without an ID, SQLite creates one. We must save this ID
    // so we can update this exact row later instead of creating a new one.
    int generatedId = await _dbService.insertMessage(message);
    message.id = generatedId;
    promptController.clear();
    fetchData();

    replyLoading.value = true;

    try {
      // 3. Fetch the bot's reply from the API
      final tempmessage = await ChatRepository().getMessage(
        prompt: message.userMessage!, // Use the saved text
      );

      if (tempmessage.status?.toLowerCase() == 'success') {
        // 4. Update the local object with the bot's response
        message.botMessage =
            tempmessage.botMessage; // Note: Ensure this matches your model
        message.bottimestamp = tempmessage.bottimestamp;
        message.status = tempmessage.status;

        // 5. PUSH TO DB: Call insert again. Because message.id is not null,
        // ConflictAlgorithm.replace will update the existing row with the bot's data.
        await _dbService.updateMessage(message);

        // 6. Refresh the UI to display the newly saved bot reply
        fetchData();
      } else {
        // Handle API failure gracefully (optional but recommended)
        message.status = 'failed';
        await _dbService.updateMessage(message);
        fetchData();
      }
    } catch (e) {
      // Handle network or parsing errors
      message.status = 'error';
      await _dbService.updateMessage(message);
      fetchData();
    } finally {
      replyLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
    blinking();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
