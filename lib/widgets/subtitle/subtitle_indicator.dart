import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/indicator/indicator.dart';
import 'package:cotwcompanion/widgets/subtitle/subtitle.dart';
import 'package:flutter/material.dart';

class WidgetSubtitleIndicator extends WidgetSubtitle {
  final double? _indicatorSize;
  final Color? _indicatorColor;
  final bool _indicatorLeft;

  const WidgetSubtitleIndicator(
    super.title, {
    super.key,
    super.subtext,
    super.color,
    super.maxLines,
    super.upperCase,
    double? indicatorSize,
    Color? indicatorColor,
    bool indicatorLeft = false,
  })  : _indicatorSize = indicatorSize,
        _indicatorColor = indicatorColor,
        _indicatorLeft = indicatorLeft;

  bool get indicatorLeft => _indicatorLeft;

  double get size => _indicatorSize ?? Values.indicatorSize;

  Color get _color => _indicatorColor ?? Interface.primary;

  Widget buildIndicator() {
    return WidgetIndicator(
      _color,
      size: size,
    );
  }

  @override
  Widget? buildBefore() {
    if (_indicatorLeft) return buildIndicator();
    return null;
  }

  @override
  Widget? buildAfter() {
    if (_indicatorLeft) return null;
    return buildIndicator();
  }
}
