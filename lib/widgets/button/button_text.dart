import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/widgets/button/button.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetButtonText extends WidgetButton {
  final String _text;
  final Color? _color;

  const WidgetButtonText(
    String text, {
    super.key,
    Color? color,
    super.background,
    required super.onTap,
  })  : _text = text,
        _color = color,
        super(width: 0);

  String get text => _text;

  Color get textColor => _color ?? Interface.alwaysDark;

  @override
  Widget? buildCenter() {
    return WidgetText(
      _text,
      color: textColor,
      style: Style.normal.s14.w500,
    );
  }
}
