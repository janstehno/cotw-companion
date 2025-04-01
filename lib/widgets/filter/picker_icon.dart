import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/button/switch_icon.dart';
import 'package:cotwcompanion/widgets/filter/picker.dart';
import 'package:flutter/material.dart';

class WidgetFilterPickerIcon<E extends Enum> extends WidgetFilterPicker {
  WidgetFilterPickerIcon({
    super.key,
    required super.filter,
    required super.filterKey,
    required super.bitKeys,
    required super.labels,
    super.colors,
    super.backgrounds,
  });

  @override
  State<StatefulWidget> createState() => WidgetFilterPickerIconState();
}

class WidgetFilterPickerIconState extends WidgetFilterPickerState {
  void _toggleFilter(int i) {
    setState(() {
      widget.filter.toggle(widget.filterKey, widget.bitKeys.elementAt(i).index);
    });
  }

  @override
  Widget buildItem(int i) {
    return AnimatedContainer(
      width: Values.tapSize,
      height: Values.tapSize,
      duration: const Duration(milliseconds: 200),
      child: WidgetSwitchIcon(
        widget.labels.elementAt(i),
        color: Interface.disabledForeground,
        background: Interface.disabled,
        activeColor: widget.colors.isEmpty ? Interface.alwaysDark : widget.colors.elementAt(i),
        activeBackground: widget.backgrounds.isEmpty ? Interface.primary : widget.backgrounds.elementAt(i),
        isActive: widget.filter.isEnabled(widget.filterKey, widget.bitKeys.elementAt(i).index),
        onTap: () => _toggleFilter(i),
      ),
    );
  }
}
