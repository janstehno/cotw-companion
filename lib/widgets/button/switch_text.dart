import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/widgets/button/switch.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetSwitchText extends WidgetSwitch {
  final String _text;
  final String? _aText;
  final Color? _color;
  final Color? _aColor;

  const WidgetSwitchText(
    String text, {
    super.key,
    String? activeText,
    Color? color,
    Color? activeColor,
    super.background,
    super.activeBackground,
    required super.onTap,
    required super.isActive,
  })  : _text = text,
        _aText = activeText,
        _color = color,
        _aColor = activeColor,
        super(width: 0);

  String get actualText => isActive ? _aText ?? _text : _text;

  Color get textColor => isActive
      ? _aColor ?? Interface.alwaysDark
      : _color ?? (buttonBackground == Interface.disabled ? Interface.disabledForeground : Interface.alwaysDark);

  @override
  Widget? buildCenter() {
    return AnimatedContainer(
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(
        left: RegExp(r"^\d{1,2}$").hasMatch(actualText) ? 0 : 10,
        right: RegExp(r"^\d{1,2}$").hasMatch(actualText) ? 0 : 10,
      ),
      child: WidgetText(
        _text,
        color: textColor,
        style: Style.normal.s16.w500,
        textAlign: TextAlign.center,
      ),
    );
  }
}
