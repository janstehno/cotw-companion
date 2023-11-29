// Copyright (c) 2023 Jan Stehno

import 'package:flutter/material.dart';

class TextEditingControllerWorkaround extends TextEditingController {
  TextEditingControllerWorkaround({required String text}) : super(text: text);

  void setTextAndPosition(String newText) {
    value = value.copyWith(text: newText, selection: TextSelection.collapsed(offset: text.length), composing: TextRange.empty);
  }
}
