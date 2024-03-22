import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/section/section_indicator.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetTextSubtextIndicator extends WidgetSectionIndicator {
  final bool _isShown;

  const WidgetTextSubtextIndicator(
    super.text, {
    super.key,
    super.subtext,
    super.color,
    super.indicatorSize = Values.dotSize,
    super.indicatorColor,
    bool isShown = true,
  }) : _isShown = isShown;

  @override
  double get height => Values.entry * 2;

  @override
  Widget buildTitle() {
    return WidgetText(
      text,
      color: titleColor,
      style: Style.normal.s16.w300,
    );
  }

  @override
  Widget buildIndicator() {
    if (_isShown) return super.buildIndicator();
    return const SizedBox.shrink();
  }

  @override
  Widget buildContainer() {
    return Container(
      height: height,
      color: titleBackground,
      child: buildRow(),
    );
  }
}
