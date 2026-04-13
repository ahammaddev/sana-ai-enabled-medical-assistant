import 'package:get/get.dart';

import '../../modules/chat/bindings/chat_binding.dart';
import '../../modules/chat/views/chat_view.dart';
import '../../modules/global/bindings/global_binding.dart';
import '../../modules/global/views/global_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CHAT;

  static final routes = [
    GetPage(
      name: _Paths.GLOBAL,
      page: () => const GlobalView(),
      binding: GlobalBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
  ];
}
