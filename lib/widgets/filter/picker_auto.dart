import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/button/switch_text.dart';
import 'package:cotwcompanion/widgets/filter/picker.dart';
import 'package:flutter/material.dart';

class WidgetFilterPickerAuto extends WidgetFilterPicker {
  const WidgetFilterPickerAuto(
    super.filterKey, {
    super.key,
    required super.icon,
    required super.text,
  });

  @override
  State<StatefulWidget> createState() => WidgetFilterPickerAutoState();
}

class WidgetFilterPickerAutoState extends WidgetFilterPickerState {
  @override
  Widget buildItem(int i, int key) {
    return AnimatedContainer(
      width: Values.tapSize,
      height: Values.tapSize,
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 200),
      child: WidgetSwitchText(
        "${widget.values.elementAt(i)}",
        isActive: HelperFilter.getBoolValueList(widget.filterKey, key),
        onTap: () => setState(() => HelperFilter.switchListValue(widget.filterKey, key)),
      ),
    );
  }
}
