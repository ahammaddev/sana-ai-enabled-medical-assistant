import 'dart:convert';

import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sana/app/data/models/message_model.dart';
import 'package:sana/app/data/providers/base_provider.dart';
import 'package:sana/app/utils/constants/config/app_urls.dart';

class ChatRepository extends GetConnect {
  static const int maxContextExchanges = 6;

  static const int maxContextChars = 600;

  Future<MessageModel> getMessage({
    required String prompt,
    List<MessageModel> history = const [],
  }) async {
    final Map<String, dynamic> body = {
      "message": buildPromptWithContext(prompt: prompt, history: history),
    };

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

  static String buildPromptWithContext({
    required String prompt,
    required List<MessageModel> history,
  }) {
    final answered =
        history
            .where(
              (m) =>
                  (m.userMessage?.trim().isNotEmpty ?? false) &&
                  (m.botMessage?.trim().isNotEmpty ?? false),
            )
            .toList()
          ..sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));

    if (answered.isEmpty) return prompt;

    final recent = answered.length > maxContextExchanges
        ? answered.sublist(answered.length - maxContextExchanges)
        : answered;

    final transcript = recent
        .map(
          (m) =>
              'User: ${_trim(m.userMessage!)}\nSana: ${_trim(m.botMessage!)}',
        )
        .join('\n');

    return 'Previous conversation:\n$transcript\n\nCurrent question: $prompt';
  }

  static String _trim(String text) {
    final clean = text.trim();
    return clean.length > maxContextChars
        ? '${clean.substring(0, maxContextChars)}...'
        : clean;
  }
}
