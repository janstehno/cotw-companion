import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/subtitle/subtitle.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetSectionTap extends WidgetSubtitle {
  final Color? _background;
  final Function _onTap;

  const WidgetSectionTap(
    super.text, {
    super.key,
    super.subtext,
    super.color,
    Color? background,
    required Function onTap,
  })  : _background = background,
        _onTap = onTap,
        super(
          maxLines: 1,
          upperCase: false,
        );

  @override
  double get height => Values.section;

  @override
  Color get titleBackground => _background ?? Interface.body;

  @override
  Widget buildContainer() {
    return GestureDetector(
      onTap: () => _onTap(),
      child: super.buildContainer(),
    );
  }

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
