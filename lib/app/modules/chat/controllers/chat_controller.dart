import 'dart:async';
import 'package:intl/date_symbol_data_local.dart';
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

    Future<void> getReply() async {
      replyLoading.value = true;
      final MessageModel message = await ChatRepository().getMessage(
        prompt: promptController.text,
      );
      if (message.status!.toLowerCase() == 'success') {
        await _dbService.insertMessage(message);
        fetchData();
      }
      replyLoading.value = false;
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
}
