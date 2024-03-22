import 'package:cotwcompanion/widgets/button/switch_icon.dart';
import 'package:cotwcompanion/widgets/title/title_button_icon.dart';
import 'package:flutter/material.dart';

class WidgetTitleSwitchIcon extends WidgetTitleButtonIcon {
  final String? _activeIcon;
  final Color? _activeButtonColor;
  final Color? _activeButtonBackground;
  final bool _isActive;

  const WidgetTitleSwitchIcon(
    super.title, {
    super.key,
    super.subtext,
    required super.icon,
    String? activeIcon,
    super.buttonColor,
    Color? activeButtonColor,
    super.buttonBackground,
    Color? activeButtonBackground,
    super.alignRight,
    required super.onTap,
    required bool isActive,
  })  : _isActive = isActive,
        _activeIcon = activeIcon,
        _activeButtonColor = activeButtonColor,
        _activeButtonBackground = activeButtonBackground;

  Widget _buildSwitch() {
    return WidgetSwitchIcon(
      icon,
      activeIcon: _activeIcon,
      color: color,
      activeColor: _activeButtonColor,
      background: buttonBackground,
      activeBackground: _activeButtonBackground,
      isActive: _isActive,
      onTap: onTap,
    );
  }

  @override
  Widget? buildAdditional() => _buildSwitch();
}
