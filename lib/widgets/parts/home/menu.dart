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
  final Color _color;

  const WidgetSectionMenu(
    super.text, {
    super.key,
    String? icon,
    Color? color,
    required super.onTap,
  })  : _icon = icon,
        _color = color ?? Interface.primary,
        super(background: Interface.transparent);

  @override
  double get height => _icon == null ? Values.menu - 10 : Values.menu;

  Widget _buildIcon() {
    return WidgetIcon.withSize(
      _icon!,
      color: _color,
      size: Values.indicatorSize,
    );
  }

  Widget _buildText() {
    return WidgetText(
      super.text,
      color: Interface.dark.withOpacity(0.8),
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
