// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/widgets/text_field.dart';
import 'package:cotwcompanion/widgets/title_info_icon.dart';
import 'package:flutter/material.dart';

class FilterRangeSet extends StatefulWidget {
  final String icon, text;
  final bool decimal;
  final num min, max;
  final FilterKey filterKeyLower, filterKeyUpper;

  const FilterRangeSet({
    Key? key,
    required this.icon,
    required this.text,
    required this.decimal,
    required this.min,
    required this.max,
    required this.filterKeyLower,
    required this.filterKeyUpper,
  }) : super(key: key);

  @override
  FilterRangeSetState createState() => FilterRangeSetState();
}

class FilterRangeSetState extends State<FilterRangeSet> {
  final TextEditingController _controllerMin = TextEditingController();
  final TextEditingController _controllerMax = TextEditingController();

  @override
  void initState() {
    _setupControllers();
    super.initState();
  }

  void _setupControllers() {
    if (widget.decimal) {
      _controllerMin.text =
          HelperFilter.getDoubleValue(widget.filterKeyLower) == widget.min ? "" : HelperFilter.getDoubleValue(widget.filterKeyLower).toString().replaceFirst(".0", "");
      _controllerMax.text =
          HelperFilter.getDoubleValue(widget.filterKeyUpper) == widget.max ? "" : HelperFilter.getDoubleValue(widget.filterKeyUpper).toString().replaceFirst(".0", "");
    } else {
      _controllerMin.text = HelperFilter.getIntValue(widget.filterKeyLower) == widget.min ? "" : HelperFilter.getIntValue(widget.filterKeyLower).toString();
      _controllerMax.text = HelperFilter.getIntValue(widget.filterKeyUpper) == widget.max ? "" : HelperFilter.getIntValue(widget.filterKeyUpper).toString();
    }
    _controllerMin.addListener(() => _setValues());
    _controllerMax.addListener(() => _setValues());
  }

  void _setValues() {
    if (widget.decimal) {
      double min = _controllerMin.text.isEmpty ? widget.min.toDouble() : double.tryParse(_controllerMin.text) ?? widget.min.toDouble();
      double max = _controllerMax.text.isEmpty ? widget.max.toDouble() : double.tryParse(_controllerMax.text) ?? widget.max.toDouble();
      setState(() {
        HelperFilter.changeDoubleValue(widget.filterKeyLower, min);
        HelperFilter.changeDoubleValue(widget.filterKeyUpper, max);
      });
    } else {
      int min = _controllerMin.text.isEmpty ? widget.min.toInt() : int.tryParse(_controllerMin.text) ?? widget.min.toInt();
      int max = _controllerMax.text.isEmpty ? widget.max.toInt() : int.tryParse(_controllerMax.text) ?? widget.max.toInt();
      setState(() {
        HelperFilter.changeIntValue(widget.filterKeyLower, min);
        HelperFilter.changeIntValue(widget.filterKeyUpper, max);
      });
    }
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
