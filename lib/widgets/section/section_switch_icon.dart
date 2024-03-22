import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:cotwcompanion/widgets/title/title_switch_icon.dart';
import 'package:flutter/material.dart';

class WidgetSectionSwitchIcon extends WidgetTitleSwitchIcon {
  final Color? _background;

  const WidgetSectionSwitchIcon(
    super.title, {
    super.key,
    super.subtext,
    required super.icon,
    super.activeIcon,
    super.buttonColor,
    super.activeButtonColor,
    super.buttonBackground,
    super.activeButtonBackground,
    super.alignRight,
    required super.onTap,
    required super.isActive,
    Color? background,
  }) : _background = background;

  Color get _titleBackground => _background ?? super.titleBackground;

  @override
  Widget buildTitle() {
    return WidgetText(
      text,
      color: titleColor,
      style: Style.normal.s16.w300,
      maxLines: maxLines,
    );
  }

  @override
  Widget buildContainer() {
    return SizedBox(
      height: height,
      child: WidgetPadding.h30(
        background: _titleBackground,
        child: buildRow(),
      ),
    );
  }
}
