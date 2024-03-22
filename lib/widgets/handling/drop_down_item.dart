import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetDropDownItem extends DropdownMenuItem {
  WidgetDropDownItem({
    super.key,
    required super.value,
    required String text,
  }) : super(child: _buildWidgets(text));

  static Color get _background => Interface.dropDown;

  static double get _height => Values.dropDown;

  static Widget _buildWidgets(String text) {
    return SizedBox(
      height: _height,
      child: WidgetPadding.h30(
        background: _background,
        child: WidgetText(
          text,
          color: Interface.dark,
          style: Style.normal.s16.w300,
        ),
      ),
    );
  }
}
