import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:flutter/material.dart';

class WidgetDropDown extends StatelessWidget {
  final int _value;
  final List<DropdownMenuItem> _items;
  final Function _onChange;

  const WidgetDropDown({
    super.key,
    required int value,
    required List<DropdownMenuItem> items,
    required Function onChange,
  })  : _value = value,
        _items = items,
        _onChange = onChange;

  double get _height => Values.dropDown;

  Widget _buildWidgets() {
    return DropdownButton(
      elevation: 0,
      menuMaxHeight: 300,
      itemHeight: _height,
      padding: EdgeInsets.zero,
      dropdownColor: Interface.dropDown,
      icon: const SizedBox.shrink(),
      underline: const SizedBox.shrink(),
      isExpanded: true,
      value: _value,
      items: _items,
      onChanged: (dynamic value) => _onChange(value),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
