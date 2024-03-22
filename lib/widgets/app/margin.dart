import 'package:cotwcompanion/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetMargin extends StatelessWidget {
  final EdgeInsets? _margin;
  final Color? _background;
  final Alignment? _alignment;
  final Widget _child;

  WidgetMargin.all(
    double margin, {
    super.key,
    Color? background,
    Alignment? alignment,
    required Widget child,
  })  : _background = background,
        _alignment = alignment,
        _margin = EdgeInsets.all(margin),
        _child = child;

  WidgetMargin.fromLTRB(
    double left,
    double top,
    double right,
    double bottom, {
    super.key,
    Color? background,
    Alignment? alignment,
    required Widget child,
  })  : _background = background,
        _alignment = alignment,
        _margin = EdgeInsets.fromLTRB(left, top, right, bottom),
        _child = child;

  WidgetMargin.top(
    double top, {
    super.key,
    Color? background,
    Alignment? alignment,
    required Widget child,
  })  : _background = background,
        _alignment = alignment,
        _margin = EdgeInsets.only(top: top),
        _child = child;

  WidgetMargin.bottom(
    double bottom, {
    super.key,
    Color? background,
    Alignment? alignment,
    required Widget child,
  })  : _background = background,
        _alignment = alignment,
        _margin = EdgeInsets.only(bottom: bottom),
        _child = child;

  WidgetMargin.left(
    double left, {
    super.key,
    Color? background,
    Alignment? alignment,
    required Widget child,
  })  : _background = background,
        _alignment = alignment,
        _margin = EdgeInsets.only(left: left),
        _child = child;

  WidgetMargin.right(
    double right, {
    super.key,
    Color? background,
    Alignment? alignment,
    required Widget child,
  })  : _background = background,
        _alignment = alignment,
        _margin = EdgeInsets.only(right: right),
        _child = child;

  EdgeInsets get margin => _margin ?? const EdgeInsets.all(0);

  Alignment get alignment => _alignment ?? Alignment.centerLeft;

  Color get background => _background ?? Interface.transparent;

  Widget _buildWidgets() {
    return Container(
      color: background,
      alignment: alignment,
      margin: margin,
      child: _child,
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
