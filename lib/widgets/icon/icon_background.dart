import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:flutter/material.dart';

class WidgetIconBackground extends StatelessWidget {
  final String _icon;
  final Color _color;
  final Color? _background;
  final double _size;

  const WidgetIconBackground(
    String icon, {
    super.key,
    required Color color,
    Color? background,
    double size = Values.tapSize,
  })  : _icon = icon,
        _size = size,
        _background = background,
        _color = color;

  double get _iconSize =>
      (Values.indicatorSize / (Values.tapSize - 2)) * _size - ((Values.indicatorSize * 2) / (Values.tapSize - 2));

  Widget _buildIcon() {
    return WidgetIcon.withSize(
      _icon,
      color: _color,
      size: _iconSize,
    );
  }

  Widget _buildWidgets() {
    return Container(
      width: _size,
      height: _size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(_size / 4),
      ),
      child: _buildIcon(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
