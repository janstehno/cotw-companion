import 'package:flutter/material.dart';

class TextEditingControllerWorkaround extends TextEditingController {
  TextEditingControllerWorkaround({
    super.text,
  });

  void setTextAndPosition(String newText) {
    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: text.length),
      composing: TextRange.empty,
    );
  }
}
