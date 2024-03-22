import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/widgets/button/switch.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:flutter/material.dart';

class WidgetSwitchIcon extends WidgetSwitch {
  final String _icon;
  final String? _aIcon;
  final Color? _color;
  final Color? _aColor;

  const WidgetSwitchIcon(
    String icon, {
    super.key,
    String? activeIcon,
    Color? color,
    Color? activeColor,
    super.background,
    super.activeBackground,
    required super.onTap,
    required super.isActive,
  })  : _icon = icon,
        _aIcon = activeIcon,
        _color = color,
        _aColor = activeColor;

  String get icon => _icon;

  String get actualIcon => isActive ? _aIcon ?? _icon : _icon;

  Color get iconColor => isActive
      ? _aColor ?? Interface.alwaysDark
      : _color ?? (buttonBackground == Interface.disabled ? Interface.disabledForeground : Interface.alwaysDark);

  @override
  Widget? buildCenter() {
    return WidgetIcon(
      actualIcon,
      color: iconColor,
    );
  }
}
