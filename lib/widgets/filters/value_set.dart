// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/widgets/text_field_indicator.dart';
import 'package:cotwcompanion/widgets/title_info_icon.dart';
import 'package:flutter/material.dart';

class FilterValueSet extends StatefulWidget {
  final String icon, text;
  final FilterKey filterKey;
  final bool decimal;
  final num min, max;
  final num defaultValue;

  const FilterValueSet({
    Key? key,
    required this.icon,
    required this.text,
    required this.filterKey,
    required this.decimal,
    required this.min,
    required this.max,
    required this.defaultValue,
  }) : super(key: key);

  @override
  FilterValueSetState createState() => FilterValueSetState();
}

class FilterValueSetState extends State<FilterValueSet> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _setupControllers();
    super.initState();
  }

  void _setupControllers() {
    if (widget.decimal) {
      _controller.text =
          HelperFilter.getDoubleValue(widget.filterKey) == widget.defaultValue ? "" : HelperFilter.getDoubleValue(widget.filterKey).toString().replaceFirst(".0", "");
    } else {
      _controller.text = HelperFilter.getIntValue(widget.filterKey) == widget.defaultValue ? "" : HelperFilter.getIntValue(widget.filterKey).toString();
    }
    _controller.addListener(() => _setValue());
  }

  void _setValue() {
    if (widget.decimal) {
      double value = _controller.text.isEmpty ? widget.defaultValue.toDouble() : double.tryParse(_controller.text) ?? widget.defaultValue.toDouble();
      setState(() {
        HelperFilter.changeDoubleValue(widget.filterKey, value);
      });
    } else {
      int value = _controller.text.isEmpty ? widget.defaultValue.toInt() : int.tryParse(_controller.text) ?? widget.defaultValue.toInt();
      setState(() {
        HelperFilter.changeIntValue(widget.filterKey, value.toInt());
      });
    }
  }

  Widget _buildWidgets() {
    double value = double.tryParse(_controller.text) ?? widget.defaultValue.toDouble();
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: widget.icon,
        text: widget.text,
      ),
      Row(
        children: [
          Expanded(
            child: WidgetTextFieldIndicator(
              controller: _controller,
              correct: _controller.text.isNotEmpty ? ((value >= widget.min) && (value <= widget.max)) || (value == 0) : true,
            ),
          ),
        ],
      )
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
