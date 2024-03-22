import 'package:cotwcompanion/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetPadding extends StatelessWidget {
  final EdgeInsets? _padding;
  final Color? _background;
  final Alignment? _alignment;
  final Widget _child;

  const WidgetPadding(
    EdgeInsets padding, {
    super.key,
    Color? background,
    Alignment? alignment,
    required Widget child,
  })  : _background = background,
        _alignment = alignment,
        _padding = padding,
        _child = child;

  WidgetPadding.all(
    double padding, {
    super.key,
    Color? background,
    Alignment? alignment,
    required Widget child,
  })  : _background = background,
        _alignment = alignment,
        _padding = EdgeInsets.all(padding),
        _child = child;

  WidgetPadding.fromLTRB(
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
        _padding = EdgeInsets.fromLTRB(left, top, right, bottom),
        _child = child;

  const WidgetPadding.a30({
    super.key,
    Color? background,
    Alignment? alignment,
    required Widget child,
  })  : _background = background,
        _alignment = alignment,
        _padding = const EdgeInsets.all(30),
        _child = child;

  const WidgetPadding.h30({
    super.key,
    Color? background,
    Alignment? alignment,
    required Widget child,
  })  : _background = background,
        _alignment = alignment,
        _padding = const EdgeInsets.symmetric(horizontal: 30),
        _child = child;

  const WidgetPadding.h30v20({
    super.key,
    Color? background,
    Alignment? alignment,
    required Widget child,
  })  : _background = background,
        _alignment = alignment,
        _padding = const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        _child = child;

  EdgeInsets get padding => _padding ?? const EdgeInsets.all(0);

  Alignment get alignment => _alignment ?? Alignment.centerLeft;

  Color get background => _background ?? Interface.transparent;

  Widget _buildWidgets() {
    return Container(
      color: background,
      alignment: alignment,
      padding: padding,
      child: _child,
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
