import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/widgets/handling/drop_down_item.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetDropDownItemAnimal extends WidgetDropDownItem {
  final int _level;

  const WidgetDropDownItemAnimal({
    super.key,
    required super.text,
    required int level,
  }) : _level = level;

  @override
  Widget buildCenter() {
    return Row(
      children: [
        WidgetText(
          _level.toString(),
          color: Interface.dark,
          style: Style.normal.s18.w500,
        ),
        const SizedBox(width: 15),
        WidgetText(
          text,
          color: Interface.dark,
          style: Style.normal.s16.w300,
        ),
      ],
    );
  }
}
