import 'dart:convert';

import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sana/app/data/models/message_model.dart';
import 'package:sana/app/data/providers/base_provider.dart';
import 'package:sana/app/utils/constants/config/app_urls.dart';

class ChatRepository extends GetConnect {
  Future<MessageModel> getMessage({required String prompt}) async {
    final Map<String, dynamic> body = {'message': prompt};

    MessageModel message = MessageModel();
    final now = DateTime.now();
    final time = DateFormat('yyyyy.MMMM.dd GGG hh:mm aaa').format(now);
    message.usertimestamp = time;

    message.userMessage = prompt;

    final http.Response response = await BaseProvider().postDataWithToken(
      url: AppUrls.url,
      body: body,
      token: AppUrls.token,
      timeOut: 8,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      message = MessageModel.fromJson(data);

      final now = DateTime.now();
      final time = DateFormat('yyyyy.MMMM.dd GGG hh:mm aaa').format(now);
      message.botMessage = time;

      return message;
    } else {
      return MessageModel();
    }
  }
}
