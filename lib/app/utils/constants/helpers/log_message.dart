import 'package:flutter/foundation.dart';
import 'dart:developer';

class LogMessage {
  LogMessage._();

  static void printLogMessage({
    required String title,
    required String message,
  }) {
    if (kDebugMode) {
      log('=====================================================');
      log('$title and, the error is: message.');
      log('=====================================================');
    }
  }
}
