import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/widgets/section/section_indicator_tap.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/cupertino.dart';

class WidgetSectionIndicatorTapAlign extends WidgetSectionIndicatorTap {
  const WidgetSectionIndicatorTapAlign(
    super.text, {
    super.key,
    super.subtext,
    super.color,
    super.indicatorSize,
    super.indicatorColor,
    super.indicatorLeft,
    super.background,
    required super.onTap,
  });

  TextAlign get _textAlign => indicatorLeft ? TextAlign.start : TextAlign.end;

  @override
  Widget buildTitle() {
    return WidgetText(
      upperCase ? text.toUpperCase() : text,
      color: titleColor,
      style: Style.normal.s16.w300,
      maxLines: maxLines,
      textAlign: _textAlign,
    );
  }
}
