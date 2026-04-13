import 'package:get/get.dart';
import 'package:sana/app/modules/chat/controllers/chat_controller.dart';

import '../controllers/global_controller.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GlobalController());
    Get.put(ChatController());
  }
}
