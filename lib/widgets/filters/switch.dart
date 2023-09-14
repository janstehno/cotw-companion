// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/widgets/tap_text_indicator.dart';
import 'package:flutter/material.dart';

class FilterSwitch extends StatefulWidget {
  final String text;
  final FilterKey filterKey;

  const FilterSwitch({
    Key? key,
    required this.text,
    required this.filterKey,
  }) : super(key: key);

  @override
  FilterSwitchState createState() => FilterSwitchState();
}

class FilterSwitchState extends State<FilterSwitch> {
  Widget _buildWidgets() {
    return WidgetTapTextIndicator(
        text: widget.text,
        isActive: HelperFilter.getBoolValue(widget.filterKey),
        onTap: () {
          setState(() {
            HelperFilter.switchValue(widget.filterKey);
          });
        });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
