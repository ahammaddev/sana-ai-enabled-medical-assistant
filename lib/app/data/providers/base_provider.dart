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
    LogMessage.printLogMessage(title: 'post url', message: url);
    LogMessage.printLogMessage(title: 'post body', message: jsonEncode(body));
    LogMessage.printLogMessage(title: 'post token', message: AppUrls.token);
    final http.Response response = await http
        .post(
          headers: headerData,
          Uri.parse(AppUrls.url),
          body: jsonEncode(body),
        )
        .timeout(Duration(seconds: timeOut));

    LogMessage.printLogMessage(
      title: 'post response url: ${Uri.parse(url)}',
      message: response.body,
    );

    return response;
  }
}
