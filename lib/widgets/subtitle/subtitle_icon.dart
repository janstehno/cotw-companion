import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/subtitle/subtitle.dart';
import 'package:flutter/material.dart';

class WidgetSubtitleIcon extends WidgetSubtitle {
  final String _icon;
  final double? _iconSize;
  final Color? _iconColor;
  final bool _alignRight;

  const WidgetSubtitleIcon(
    super.text, {
    super.key,
    super.subtext,
    super.color,
    super.maxLines,
    super.upperCase,
    required String icon,
    Color? iconColor,
    double? iconSize,
    bool alignRight = false,
  })  : _icon = icon,
        _iconColor = iconColor,
        _iconSize = iconSize,
        _alignRight = alignRight;

  double get _size => _iconSize ?? Values.indicatorSize;

  Color get _color => _iconColor ?? super.titleColor;

  Widget buildIcon() {
    return WidgetIcon.withSize(
      _icon,
      color: _color,
      size: _size,
    );
  }

  @override
  Widget? buildBefore() {
    if (_alignRight) return null;
    return buildIcon();
  }

  @override
  Widget? buildAfter() {
    if (_alignRight) return buildIcon();
    return null;
  }
}
