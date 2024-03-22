import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:flutter/material.dart';

class WidgetIndicator extends StatelessWidget {
  final double? _width;
  final double? _height;
  final Color _color;
  final Color? _activeColor;
  final bool _isActive;

  const WidgetIndicator(
    Color color, {
    super.key,
    double? size,
    Color? activeColor,
    bool isActive = false,
  })  : _width = size,
        _height = size,
        _color = color,
        _activeColor = activeColor,
        _isActive = isActive;

  const WidgetIndicator.withSize({
    super.key,
    double? width,
    double? height,
    required Color color,
    Color? activeColor,
    bool isActive = false,
  })  : _width = width,
        _height = height,
        _color = color,
        _activeColor = activeColor,
        _isActive = isActive;

  Color get indicatorColor => _isActive ? _activeColor ?? _color : _color;

  double get indicatorWidth => _width ?? indicatorHeight;

  double get indicatorHeight => _height ?? Values.indicatorSize;

  double get radius => (indicatorWidth < indicatorHeight ? indicatorWidth : indicatorHeight) / 2.5;

  Widget _buildWidgets() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: indicatorWidth,
      height: indicatorHeight,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
