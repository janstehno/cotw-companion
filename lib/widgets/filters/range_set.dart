// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/widgets/text_field_indicator.dart';
import 'package:cotwcompanion/widgets/title_info_icon.dart';
import 'package:flutter/material.dart';

class FilterRangeSet extends StatefulWidget {
  final String icon, text;
  final FilterKey filterKeyLower, filterKeyUpper;
  final bool decimal;

  const FilterRangeSet({
    Key? key,
    required this.icon,
    required this.text,
    required this.decimal,
    required this.filterKeyLower,
    required this.filterKeyUpper,
  }) : super(key: key);

  @override
  FilterRangeSetState createState() => FilterRangeSetState();
}

class FilterRangeSetState extends State<FilterRangeSet> {
  final TextEditingController _controllerMin = TextEditingController();
  final TextEditingController _controllerMax = TextEditingController();

  late final num min, max;

  @override
  void initState() {
    min = HelperFilter.getDefaultValue(widget.filterKeyLower);
    max = HelperFilter.getDefaultValue(widget.filterKeyUpper);
    _setupControllers();
    super.initState();
  }

  void _setupControllers() {
    if (widget.decimal) {
      _controllerMin.text =
          HelperFilter.getDoubleValue(widget.filterKeyLower) == min ? "" : HelperFilter.getDoubleValue(widget.filterKeyLower).toString().replaceFirst(".0", "");
      _controllerMax.text =
          HelperFilter.getDoubleValue(widget.filterKeyUpper) == max ? "" : HelperFilter.getDoubleValue(widget.filterKeyUpper).toString().replaceFirst(".0", "");
    } else {
      _controllerMin.text = HelperFilter.getIntValue(widget.filterKeyLower) == min ? "" : HelperFilter.getIntValue(widget.filterKeyLower).toString();
      _controllerMax.text = HelperFilter.getIntValue(widget.filterKeyUpper) == max ? "" : HelperFilter.getIntValue(widget.filterKeyUpper).toString();
    }
    _controllerMin.addListener(() => _setValues());
    _controllerMax.addListener(() => _setValues());
  }

  void _setValues() {
    if (widget.decimal) {
      double newMin = _controllerMin.text.isEmpty ? min.toDouble() : double.tryParse(_controllerMin.text) ?? min.toDouble();
      double newMax = _controllerMax.text.isEmpty ? max.toDouble() : double.tryParse(_controllerMax.text) ?? max.toDouble();
      setState(() {
        HelperFilter.changeDoubleValue(widget.filterKeyLower, newMin);
        HelperFilter.changeDoubleValue(widget.filterKeyUpper, newMax);
      });
    } else {
      int newMin = _controllerMin.text.isEmpty ? min.toInt() : int.tryParse(_controllerMin.text) ?? min.toInt();
      int newMax = _controllerMax.text.isEmpty ? max.toInt() : int.tryParse(_controllerMax.text) ?? max.toInt();
      setState(() {
        HelperFilter.changeIntValue(widget.filterKeyLower, newMin);
        HelperFilter.changeIntValue(widget.filterKeyUpper, newMax);
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
            child: WidgetTextFieldIndicator(
              icon: "assets/graphics/icons/range_min.svg",
              controller: _controllerMin,
              correct: _controllerMin.text.isNotEmpty ? (double.tryParse(_controllerMin.text) ?? min - 1) >= min : true,
            ),
          ),
          Expanded(
            child: WidgetTextFieldIndicator(
              icon: "assets/graphics/icons/range_max.svg",
              controller: _controllerMax,
              correct: _controllerMax.text.isNotEmpty ? (double.tryParse(_controllerMax.text) ?? max + 1) <= max : true,
            ),
          )
        ],
      )
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
