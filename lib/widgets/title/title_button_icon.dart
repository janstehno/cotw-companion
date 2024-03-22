import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:flutter/material.dart';

class WidgetTitleButtonIcon extends WidgetTitle {
  final String _icon;
  final Color? _buttonColor;
  final Color? _buttonBackground;
  final bool _alignRight;
  final Function _onTap;

  const WidgetTitleButtonIcon(
    super.title, {
    super.key,
    super.subtext,
    super.color,
    super.maxLines,
    super.upperCase,
    required String icon,
    Color? buttonColor,
    Color? buttonBackground,
    bool alignRight = false,
    required Function onTap,
  })  : _icon = icon,
        _alignRight = alignRight,
        _buttonColor = buttonColor,
        _buttonBackground = buttonBackground,
        _onTap = onTap;

  String get icon => _icon;

  Color? get buttonBackground => _buttonBackground;

  Function get onTap => _onTap;

  Widget _buildButton() {
    return WidgetButtonIcon(
      icon,
      color: _buttonColor,
      background: _buttonBackground,
      onTap: () => onTap(),
    );
  }

  Widget? buildAdditional() => _buildButton();

  @override
  Widget? buildBefore() {
    if (!_alignRight) return buildAdditional();
    return null;
  }

  @override
  Widget? buildAfter() {
    if (_alignRight) return buildAdditional();
    return null;
  }
}
