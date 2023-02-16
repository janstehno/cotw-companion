// Copyright (c) 2022 Jan Stehno

import 'package:logger/logger.dart';

class HelperLogger {
  final Logger logger =
      Logger(filter: null, output: null, printer: PrettyPrinter(methodCount: 0, noBoxingByDefault: true, colors: true, printEmojis: false, printTime: false));
  final String identifier;

  HelperLogger(this.identifier);

  void v(String message) {
    logger.v("[Developer] $identifier $message");
  }

  void d(String message) {
    logger.d("[Developer] $identifier $message");
  }

  void i(String message) {
    logger.i("[Developer] $identifier $message");
  }

  void w(String message) {
    logger.w("[Developer] $identifier $message");
  }

  void e(String message) {
    logger.e("[Developer] $identifier $message");
  }
}
