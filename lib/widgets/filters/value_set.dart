// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/widgets/text_field.dart';
import 'package:cotwcompanion/widgets/title_info_icon.dart';
import 'package:flutter/material.dart';

class FilterValueSet extends StatefulWidget {
  final String icon, text;
  final FilterKey filterKey;
  final double min, max;
  final double defaultValue;

  const FilterValueSet({
    Key? key,
    required this.icon,
    required this.text,
    required this.filterKey,
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
    _controller.addListener(() => _setValue());
    super.initState();
  }

  void _setValue() {
    double value = _controller.text.isEmpty ? widget.defaultValue : double.tryParse(_controller.text) ?? widget.defaultValue;
    setState(() {
      HelperFilter.changeValue(widget.filterKey, value);
    });
  }

  Widget _buildWidgets() {
    double value = double.tryParse(_controller.text) ?? widget.defaultValue;
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: widget.icon,
        text: widget.text,
      ),
      Row(
        children: [
          Expanded(
            child: WidgetTextField(
              controller: _controller,
              correct: _controller.text.isNotEmpty ? ((value >= widget.min) && (value <= widget.max)) || (value == 0) : true,
            ),
          ),
        ],
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
