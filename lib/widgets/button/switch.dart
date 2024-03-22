import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/widgets/button/button.dart';
import 'package:flutter/material.dart';

class WidgetSwitch extends WidgetButton {
  final Color? _aBackground;
  final bool _isActive;

  const WidgetSwitch({
    super.key,
    super.width,
    super.background,
    Color? activeBackground,
    required bool isActive,
    required super.onTap,
  })  : _aBackground = activeBackground,
        _isActive = isActive;

  bool get isActive => _isActive;

  @override
  Color get buttonBackground => _isActive ? _aBackground ?? Interface.primary : background ?? Interface.disabled;
}
