// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/widgets/text_field.dart';
import 'package:cotwcompanion/widgets/title_info_icon.dart';
import 'package:flutter/material.dart';

class FilterRangeSet extends StatefulWidget {
  final String icon, text;
  final FilterKey filterKeyLower, filterKeyUpper;
  final double min, max;

  const FilterRangeSet({
    Key? key,
    required this.icon,
    required this.text,
    required this.filterKeyLower,
    required this.filterKeyUpper,
    required this.min,
    required this.max,
  }) : super(key: key);

  @override
  FilterRangeSetState createState() => FilterRangeSetState();
}

class FilterRangeSetState extends State<FilterRangeSet> {
  final TextEditingController _controllerMin = TextEditingController();
  final TextEditingController _controllerMax = TextEditingController();

  @override
  void initState() {
    _controllerMin.addListener(() => _setValues());
    _controllerMax.addListener(() => _setValues());
    super.initState();
  }

  void _setValues() {
    double min = _controllerMin.text.isEmpty ? widget.min : double.tryParse(_controllerMin.text) ?? widget.min;
    double max = _controllerMax.text.isEmpty ? widget.max : double.tryParse(_controllerMax.text) ?? widget.max;
    setState(() {
      HelperFilter.changeValue(widget.filterKeyLower, min);
      HelperFilter.changeValue(widget.filterKeyUpper, max);
    });
  }

  Widget _buildWidgets() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: widget.icon,
        text: widget.text,
      ),
      Row(
        children: [
          Expanded(
            child: WidgetTextField(
              icon: "assets/graphics/icons/range_min.svg",
              controller: _controllerMin,
              correct: _controllerMin.text.isNotEmpty ? (double.tryParse(_controllerMin.text) ?? widget.min - 1) >= widget.min : true,
            ),
          ),
          Expanded(
            child: WidgetTextField(
              icon: "assets/graphics/icons/range_max.svg",
              controller: _controllerMax,
              correct: _controllerMax.text.isNotEmpty ? (double.tryParse(_controllerMax.text) ?? widget.max + 1) <= widget.max : true,
            ),
          )
        ],
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
