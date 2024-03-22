import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/subtitle/subtitle_indicator.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetSectionIndicator extends WidgetSubtitleIndicator {
  final Color? _background;

  const WidgetSectionIndicator(
    super.text, {
    super.key,
    super.subtext,
    super.color,
    super.indicatorSize = Values.indicatorSize,
    super.indicatorColor,
    super.indicatorLeft,
    Color? background,
  })  : _background = background,
        super(maxLines: 2, upperCase: false);

  @override
  double get height => Values.section;

  @override
  Color get titleBackground => _background ?? Interface.body;

  @override
  Widget buildTitle() {
    return WidgetText(
      text,
      color: titleColor,
      style: Style.normal.s16.w300,
      maxLines: maxLines,
    );
  }
}
