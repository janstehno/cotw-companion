import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/section/section_tap.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetSectionMenu extends WidgetSectionTap {
  final String? _icon;

  const WidgetSectionMenu(
    super.text, {
    super.key,
    String? icon,
    required super.onTap,
  })  : _icon = icon,
        super(background: Interface.transparent);

  @override
  double get height => Values.menu;

  Widget _buildIcon() {
    return WidgetIcon.withSize(
      _icon!,
      color: Interface.dark,
      size: Values.iconSize,
    );
  }

  Widget _buildText() {
    return WidgetText(
      super.text,
      color: Interface.dark.withValues(alpha: 0.8),
      style: Style.normal.s16.w300,
    );
  }

  @override
  Widget buildCenter() {
    return Row(
      children: [
        if (_icon != null) WidgetMargin.right(15, child: _buildIcon()),
        Expanded(child: _buildText()),
      ],
    );
  }
}
