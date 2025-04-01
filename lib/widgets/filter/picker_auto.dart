import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/button/switch_text.dart';
import 'package:cotwcompanion/widgets/filter/picker.dart';
import 'package:flutter/material.dart';

class WidgetFilterPickerAuto<E> extends WidgetFilterPicker {
  WidgetFilterPickerAuto({
    super.key,
    required super.filter,
    required super.filterKey,
    required super.bitKeys,
  });

  @override
  State<StatefulWidget> createState() => WidgetFilterPickerAutoState();
}

class WidgetFilterPickerAutoState extends WidgetFilterPickerState {
  void _toggleFilter(int i) {
    setState(() {
      widget.filter.toggle(widget.filterKey, i);
    });
  }

  @override
  Widget buildItem(int i) {
    return AnimatedContainer(
      width: Values.tapSize,
      height: Values.tapSize,
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 200),
      child: WidgetSwitchText(
        "${widget.bitKeys.elementAt(i)}",
        isActive: widget.filter.isEnabled(widget.filterKey, i),
        onTap: () => _toggleFilter(i),
      ),
    );
  }
}
