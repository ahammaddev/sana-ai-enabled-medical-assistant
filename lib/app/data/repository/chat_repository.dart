import 'dart:convert';

import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sana/app/data/models/message_model.dart';
import 'package:sana/app/data/providers/base_provider.dart';
import 'package:sana/app/utils/constants/config/app_urls.dart';

class ChatRepository extends GetConnect {
  Future<MessageModel> getMessage({required String prompt}) async {
    final Map<String, dynamic> body = {"message": prompt};

    final http.Response response = await BaseProvider().postDataWithToken(
      url: AppUrls.url,
      body: body,
      token: AppUrls.token,
      timeOut: 150,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final now = DateTime.now();
      final time = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      final message = MessageModel.fromJson(data);
      message.bottimestamp = time;

      return message;
    } else {
      return MessageModel();
    }
  }
}
