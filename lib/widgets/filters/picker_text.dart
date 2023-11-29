// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/filters/picker.dart';
import 'package:cotwcompanion/widgets/switch_text.dart';
import 'package:flutter/material.dart';

class FilterPickerText extends FilterPicker {
  const FilterPickerText({
    super.key,
    required super.icon,
    required super.text,
    required super.filterKey,
    required super.labels,
    super.colors,
    super.backgrounds,
  });

  @override
  FilterPickerTextState createState() => FilterPickerTextState();
}

class FilterPickerTextState extends FilterPickerState {
  final double _buttonHeight = 30;

  @override
  Widget buildItem(int index, int key) {
    return WidgetSwitchText(
        buttonHeight: _buttonHeight,
        text: widget.labels.elementAt(index),
        activeColor: widget.colors.isEmpty ? Interface.accent : widget.colors.elementAt(index),
        activeBackground: widget.backgrounds.isEmpty ? Interface.primary : widget.backgrounds.elementAt(index),
        isActive: HelperFilter.getBoolValueList(widget.filterKey, key),
        onTap: () {
          setState(() {
            HelperFilter.switchListValue(widget.filterKey, key);
          });
        });
  }
}
