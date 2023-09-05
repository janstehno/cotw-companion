// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:logger/logger.dart';

class HelperLogger {
  final Logger _logger =
      Logger(filter: null, output: null, printer: PrettyPrinter(methodCount: 0, noBoxingByDefault: true, colors: true, printEmojis: false, printTime: false));
  final String _identifier;

  HelperLogger(this._identifier);

  void t(String message) {
    _logger.d("[Developer] $_identifier $message");
  }

  void d(String message) {
    _logger.d("[Developer] $_identifier $message");
  }

  void i(String message) {
    _logger.i("[Developer] $_identifier $message");
  }

  void w(String message) {
    _logger.w("[Developer] $_identifier $message");
  }

  void e(String message) {
    _logger.e("[Developer] $_identifier $message");
  }
}
