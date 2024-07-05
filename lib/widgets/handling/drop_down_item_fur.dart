import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/handling/drop_down_item.dart';
import 'package:cotwcompanion/widgets/indicator/indicator.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetDropDownItemFur extends WidgetDropDownItem {
  final Color _color;

  const WidgetDropDownItemFur({
    super.key,
    required super.text,
    required Color color,
  }) : _color = color;

  @override
  Widget buildCenter() {
    return Row(
      children: [
        WidgetIndicator.withSize(
          width: Values.dotSize,
          height: Values.dotSize,
          color: _color,
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
