import 'package:get/get.dart';

import '../../modules/chat/bindings/chat_binding.dart';
import '../../modules/chat/views/chat_view.dart';
import '../../modules/chat_list/bindings/chat_list_binding.dart';
import '../../modules/chat_list/views/chat_list_view.dart';
import '../../modules/global/bindings/global_binding.dart';
import '../../modules/global/views/global_view.dart';
import '../../modules/welcome/bindings/welcome_binding.dart';
import '../../modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WELCOME;

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
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_LIST,
      page: () => const ChatListView(),
      binding: ChatListBinding(),
    ),
  ];
}
