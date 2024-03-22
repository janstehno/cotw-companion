import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:flutter/material.dart';

class WidgetTextField extends StatelessWidget {
  final bool _numberOnly, _decimal;
  final TextEditingController _textController;

  const WidgetTextField({
    super.key,
    bool numberOnly = false,
    bool decimal = true,
    required TextEditingController textController,
  })  : _numberOnly = numberOnly,
        _decimal = decimal,
        _textController = textController;

  InputBorder get _textFieldBorder =>
      const OutlineInputBorder(borderSide: BorderSide(width: 0.05, color: Interface.transparent));

  TextInputType get _keyboard {
    if (_numberOnly) {
      return TextInputType.numberWithOptions(
        decimal: _decimal,
        signed: false,
      );
    }
    return TextInputType.text;
  }

  Widget _buildWidgets() {
    return TextField(
      keyboardType: _keyboard,
      maxLines: 1,
      cursorHeight: 22,
      controller: _textController,
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: Interface.dark,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        border: _textFieldBorder,
        disabledBorder: _textFieldBorder,
        enabledBorder: _textFieldBorder,
        focusedBorder: _textFieldBorder,
        errorBorder: _textFieldBorder,
        focusedErrorBorder: _textFieldBorder,
      ),
      style: Style.normal.s16.w300.copyWith(color: Interface.dark),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
