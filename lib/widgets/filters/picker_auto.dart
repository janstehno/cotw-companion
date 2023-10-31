// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/widgets/switch_text.dart';
import 'package:cotwcompanion/widgets/title_info_icon.dart';
import 'package:flutter/material.dart';

class FilterPickerAuto extends StatefulWidget {
  final String icon, text;
  final FilterKey filterKey;
  final List<int> values;

  const FilterPickerAuto({
    Key? key,
    required this.icon,
    required this.text,
    required this.filterKey,
    required this.values,
  }) : super(key: key);

  @override
  FilterPickerAutoState createState() => FilterPickerAutoState();
}

class FilterPickerAutoState extends State<FilterPickerAuto> {
  final double _buttonHeight = 30;
  final double _wrapSpace = 10;

  List<Widget> _buildSwitches() {
    List<Widget> switches = [];
    for (int index = 0; index < widget.values.length; index++) {
      int key = widget.values[index];
      switches.add(
        WidgetSwitchText(
            buttonHeight: _buttonHeight,
            text: "${widget.values[index]}",
            isActive: HelperFilter.getBoolValueList(widget.filterKey, key),
            onTap: () {
              setState(() {
                HelperFilter.switchListValue(widget.filterKey, key);
              });
            }),
      );
    }
    return switches;
  }

  Widget _buildWidgets() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: widget.icon,
        text: widget.text,
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Wrap(
          spacing: _wrapSpace,
          runSpacing: _wrapSpace,
          alignment: WrapAlignment.start,
          children: _buildSwitches(),
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
