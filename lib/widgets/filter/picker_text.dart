import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/widgets/button/switch_text.dart';
import 'package:cotwcompanion/widgets/filter/picker.dart';
import 'package:flutter/material.dart';

class WidgetFilterPickerText extends WidgetFilterPicker {
  const WidgetFilterPickerText(
    super.filterKey, {
    super.key,
    required super.icon,
    required super.text,
    required super.labels,
    super.colors,
    super.backgrounds,
  });

  @override
  State<StatefulWidget> createState() => WidgetFilterPickerTextState();
}

class WidgetFilterPickerTextState extends WidgetFilterPickerState {
  @override
  Widget buildItem(int i, int key) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        WidgetSwitchText(
          widget.labels.elementAt(i),
          activeColor: widget.colors.isEmpty ? Interface.alwaysDark : widget.colors.elementAt(i),
          activeBackground: widget.backgrounds.isEmpty ? Interface.primary : widget.backgrounds.elementAt(i),
          isActive: HelperFilter.getBoolValueList(widget.filterKey, key),
          onTap: () => setState(() => HelperFilter.switchListValue(widget.filterKey, key)),
        ),
      ],
    );
  }
}
