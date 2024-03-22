import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/button/switch_icon.dart';
import 'package:cotwcompanion/widgets/filter/picker.dart';
import 'package:flutter/material.dart';

class WidgetFilterPickerIcon extends WidgetFilterPicker {
  const WidgetFilterPickerIcon(
    super.filterKey, {
    super.key,
    required super.icon,
    required super.text,
    required super.labels,
    required super.colors,
    required super.backgrounds,
  });

  @override
  State<StatefulWidget> createState() => WidgetFilterPickerIconState();
}

class WidgetFilterPickerIconState extends WidgetFilterPickerState {
  @override
  Widget buildItem(int i, int key) {
    return AnimatedContainer(
      width: Values.tapSize,
      height: Values.tapSize,
      duration: const Duration(milliseconds: 200),
      child: WidgetSwitchIcon(
        widget.labels.elementAt(i),
        color: Interface.disabledForeground,
        background: Interface.disabled,
        activeColor: widget.colors.elementAt(i),
        activeBackground: widget.backgrounds.elementAt(i),
        isActive: HelperFilter.getBoolValueList(widget.filterKey, key),
        onTap: () => setState(() => HelperFilter.switchListValue(widget.filterKey, key)),
      ),
    );
  }
}
