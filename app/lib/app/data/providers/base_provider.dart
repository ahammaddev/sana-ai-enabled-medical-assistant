import 'dart:convert';

import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;
import 'package:sana/app/utils/constants/config/app_urls.dart';
import 'package:sana/app/utils/constants/helpers/log_message.dart';

class BaseProvider extends GetConnect {
  static const int timeoutRequest = 60;

  Map<String, String> headerData = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${AppUrls.token}',
  };

  Future<http.Response> postDataWithToken({
    required String url,
    required dynamic body,
    required String? token,
    required int timeOut,
  }) async {
    try {
      // LogMessage.printLogMessage(title: 'post url', message: url);
      LogMessage.printLogMessage(title: 'post body', message: jsonEncode(body));
      // LogMessage.printLogMessage(title: 'post token', message: token!);
      final http.Response response = await http
          .post(headers: headerData, Uri.parse(url), body: jsonEncode(body))
          .timeout(Duration(seconds: timeOut));

      LogMessage.printLogMessage(title: 'success', message: response.body);

      return response;
    } catch (e) {
      LogMessage.printLogMessage(
        title: 'NETWORK EXCEPTION',
        message: 'Failed! Reason: $e',
      );
      rethrow;
    }
  }
}
