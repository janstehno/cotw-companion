import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/button/button.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:flutter/material.dart';

class WidgetButtonIcon extends WidgetButton {
  final String _icon;
  final double? _size;
  final Color? _color;

  const WidgetButtonIcon(
    String icon, {
    super.key,
    Color? color,
    double? size,
    super.background,
    required super.onTap,
  })  : _icon = icon,
        _color = color,
        _size = size;

  double get iconSize => _size ?? Values.indicatorSize;

  Color get iconColor => _color ?? Interface.alwaysDark;

  @override
  Widget? buildCenter() {
    return WidgetIcon.withSize(
      _icon,
      color: iconColor,
      size: iconSize,
    );
  }
}
