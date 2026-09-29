import 'package:get/get.dart';
import 'package:sana/app/utils/routes/app_pages.dart';

class WelcomeController extends GetxController {
  // Welcome stays at the bottom of the stack, so back always returns here.
  void navigateToChatList() {
    Get.toNamed(Routes.CHAT_LIST);
  }

  void startDirectChat() {
    Get.toNamed(Routes.CHAT, arguments: {'sessionId': null, 'title': null});
  }
}
