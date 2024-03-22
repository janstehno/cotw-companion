import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetTextTap extends WidgetText {
  final Function _onTap;

  const WidgetTextTap(
    super.text, {
    super.key,
    required super.color,
    required super.style,
    super.textAlign,
    super.maxLines,
    super.autoSize,
    required Function onTap,
  }) : _onTap = onTap;

  @override
  TextStyle get style => super.style.copyWith(decoration: TextDecoration.underline, decorationColor: color);

  @override
  Widget buildAutoSizeText() {
    return GestureDetector(
      onTap: () => _onTap(),
      child: super.buildAutoSizeText(),
    );
  }

  @override
  Widget buildText() {
    return GestureDetector(
      onTap: () => _onTap(),
      child: super.buildText(),
    );
  }
}
