import 'package:cotwcompanion/widgets/button/switch.dart';
import 'package:cotwcompanion/widgets/title/title_icon.dart';
import 'package:flutter/material.dart';

class WidgetTitleIconSwitch extends WidgetTitleIcon {
  final WidgetSwitch _switchButton;

  const WidgetTitleIconSwitch(
    super.text, {
    super.key,
    super.subtext,
    super.color,
    super.maxLines,
    super.upperCase,
    required super.icon,
    required WidgetSwitch switchButton,
    super.iconColor,
    super.iconSize,
  })  : _switchButton = switchButton,
        super(alignRight: false);

  @override
  Widget? buildBefore() {
    return buildIcon();
  }

  @override
  Widget? buildAfter() {
    return _switchButton;
  }
}
