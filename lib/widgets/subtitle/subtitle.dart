import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:flutter/material.dart';

class WidgetSubtitle extends WidgetTitle {
  const WidgetSubtitle(
    super.text, {
    super.key,
    super.subtext,
    super.color,
    super.maxLines,
    super.upperCase,
  });

  @override
  double get height => Values.subtitle;

  @override
  Color get titleBackground => Interface.subtitle;

  @override
  Widget buildTitle() {
    return WidgetText(
      upperCase ? text.toUpperCase() : text,
      color: titleColor,
      style: Style.condensed.s16.w600,
      maxLines: maxLines,
    );
  }
}
