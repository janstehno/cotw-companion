import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/section/section_tap.dart';
import 'package:flutter/material.dart';

class WidgetSectionTapIcon extends WidgetSectionTap {
  final String _icon;
  final Color? _iColor;

  const WidgetSectionTapIcon(
    super.text, {
    super.key,
    required String icon,
    super.color,
    super.background,
    required super.onTap,
  })  : _icon = icon,
        _iColor = color;

  Widget _buildIcon() {
    return WidgetIcon(
      _icon,
      color: _iColor ?? titleColor,
    );
  }

  @override
  Widget buildRow() {
    return Row(
      children: [
        _buildIcon(),
        const SizedBox(width: 15),
        Expanded(child: super.buildRow()),
      ],
    );
  }
}
