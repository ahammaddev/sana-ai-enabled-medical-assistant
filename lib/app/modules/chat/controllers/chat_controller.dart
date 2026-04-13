import 'dart:async';

import 'package:get/get.dart';

class ChatController extends GetxController {
  RxBool blinkController = false.obs;

  void blinking() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      blinkController.value = !blinkController.value;
    });
  }

  @override
  void onInit() {
    super.onInit();
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
