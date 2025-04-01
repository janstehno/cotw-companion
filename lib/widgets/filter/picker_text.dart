import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/widgets/button/switch_text.dart';
import 'package:cotwcompanion/widgets/filter/picker.dart';
import 'package:flutter/material.dart';

class WidgetFilterPickerText<E extends Enum> extends WidgetFilterPicker {
  WidgetFilterPickerText({
    super.key,
    required super.filter,
    required super.filterKey,
    required super.bitKeys,
    required super.labels,
    super.colors,
    super.backgrounds,
  });

  @override
  State<StatefulWidget> createState() => WidgetFilterPickerTextState();
}

class WidgetFilterPickerTextState extends WidgetFilterPickerState {
  void _toggleFilter(int i) {
    setState(() {
      widget.filter.toggle(widget.filterKey, widget.bitKeys.elementAt(i).index);
    });
  }

  @override
  Widget buildItem(int i) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        WidgetSwitchText(
          widget.labels.elementAt(i),
          activeColor: widget.colors.isEmpty ? Interface.alwaysDark : widget.colors.elementAt(i),
          activeBackground: widget.backgrounds.isEmpty ? Interface.primary : widget.backgrounds.elementAt(i),
          isActive: widget.filter.isEnabled(widget.filterKey, widget.bitKeys.elementAt(i).index),
          onTap: () => _toggleFilter(i),
        ),
      ],
    );
  }
}
