import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/section/section_tap.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class WidgetSectionMenu extends WidgetSectionTap {
  final String _icon;
  final Color _color;

  const WidgetSectionMenu(
    super.text, {
    super.key,
    required String icon,
    Color? color,
    required super.onTap,
  })  : _icon = icon,
        _color = color ?? Interface.primary,
        super(background: Interface.transparent);

  @override
  double get height => Values.menu;

  Widget _buildIcon() {
    return SimpleShadow(
      sigma: 0.5,
      offset: const Offset(1.4, 1.4),
      child: WidgetIcon(
        _icon,
        color: _color,
      ),
    );
  }

  Widget _buildText() {
    return WidgetText(
      super.text,
      color: Interface.alwaysLight,
      style: Style.normal.s16.w500,
    );
  }

  @override
  Widget buildCenter() {
    return SimpleShadow(
      sigma: 4,
      child: Row(
        children: [
          WidgetMargin.right(
            15,
            child: _buildIcon(),
          ),
          Expanded(child: _buildText()),
        ],
      ),
    );
  }
}
