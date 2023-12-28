// Copyright (c) 2023 Jan Stehno

import 'package:logger/logger.dart';

class HelperLogger {
  final Logger _logger =
      Logger(filter: null, output: null, printer: PrettyPrinter(methodCount: 0, noBoxingByDefault: true, colors: true, printEmojis: false, printTime: false));
  String identifier = "";

  HelperLogger();

  HelperLogger.appLoading() {
    identifier = "[APP] [LOADING]";
  }

  HelperLogger.logsEdit() {
    identifier = "[LOGS] [EDIT]";
  }

  void t(String message) {
    _logger.d("[🛠️ Developer] $identifier $message");
  }

  void d(String message) {
    _logger.d("[🛠️ Developer] $identifier $message");
  }

  void i(String message) {
    _logger.i("[🛠️ Developer] $identifier $message");
  }

  void w(String message) {
    _logger.w("[🛠️ Developer] $identifier $message");
  }

  void e(String message) {
    _logger.e("[🛠️ Developer] $identifier $message");
  }
}
