// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/widgets/filters/picker.dart';
import 'package:cotwcompanion/widgets/switch_text.dart';
import 'package:flutter/material.dart';

class FilterPickerAuto extends FilterPicker {
  const FilterPickerAuto({
    super.key,
    required super.icon,
    required super.text,
    required super.filterKey,
  });

  @override
  FilterPickerAutoState createState() => FilterPickerAutoState();
}

class FilterPickerAutoState extends FilterPickerState {
  final double _buttonHeight = 30;

  @override
  Widget buildItem(int index, int key) {
    return WidgetSwitchText(
        buttonHeight: _buttonHeight,
        text: "${values[index]}",
        isActive: HelperFilter.getBoolValueList(widget.filterKey, key),
        onTap: () {
          setState(() {
            HelperFilter.switchListValue(widget.filterKey, key);
          });
        });
  }
}
