// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetTextField extends StatelessWidget {
  final bool decimal, numberOnly;
  final TextEditingController controller;

  const WidgetTextField({
    Key? key,
    this.decimal = true,
    this.numberOnly = false,
    required this.controller,
  }) : super(key: key);

  Widget _buildWidgets() {
    return TextField(
      keyboardType: numberOnly
          ? TextInputType.numberWithOptions(
              decimal: decimal,
              signed: false,
            )
          : TextInputType.text,
      maxLines: 1,
      cursorHeight: 22,
      controller: controller,
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: Interface.dark,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        border: Interface.textFieldBorder(),
        disabledBorder: Interface.textFieldBorder(),
        enabledBorder: Interface.textFieldBorder(),
        focusedBorder: Interface.textFieldBorder(),
        errorBorder: Interface.textFieldBorder(),
        focusedErrorBorder: Interface.textFieldBorder(),
      ),
      style: Interface.s16w300n(Interface.dark),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
