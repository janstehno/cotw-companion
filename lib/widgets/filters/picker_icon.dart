// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/widgets/filters/picker.dart';
import 'package:cotwcompanion/widgets/switch_icon.dart';
import 'package:flutter/material.dart';

class FilterPickerIcon extends FilterPicker {
  const FilterPickerIcon({
    super.key,
    required super.icon,
    required super.text,
    required super.filterKey,
    required super.labels,
    required super.colors,
    required super.backgrounds,
  });

  @override
  FilterPickerIconState createState() => FilterPickerIconState();
}

class FilterPickerIconState extends FilterPickerState {
  final double _buttonSize = 30;

  @override
  Widget buildItem(int index, int key) {
    return WidgetSwitchIcon(
        buttonSize: _buttonSize,
        icon: widget.labels[index],
        activeColor: widget.colors[index],
        activeBackground: widget.backgrounds[index],
        isActive: HelperFilter.getBoolValueList(widget.filterKey, key),
        onTap: () {
          setState(() {
            HelperFilter.switchListValue(widget.filterKey, key);
          });
        });
  }
}
