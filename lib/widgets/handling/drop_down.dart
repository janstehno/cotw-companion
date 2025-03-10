import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class WidgetDropDown<V> extends StatelessWidget {
  final V _value;
  final Color? _background;
  final List<DropdownMenuItem> _items;
  final Function _onChange;

  const WidgetDropDown({
    super.key,
    required V value,
    Color? background,
    required List<DropdownMenuItem> items,
    required Function onChange,
  })  : _value = value,
        _background = background,
        _items = items,
        _onChange = onChange;

  double get _height => Values.dropDown;

  Color get _actualBackground => _background ?? Interface.body;

  DropdownButton2 get dropdownButton => DropdownButton2(
        isExpanded: true,
        value: _value,
        items: _items,
        onChanged: (dynamic value) => _onChange(value),
        buttonStyleData: ButtonStyleData(
          height: _height,
          padding: EdgeInsets.only(right: 25),
          elevation: 0,
          decoration: BoxDecoration(color: _actualBackground),
        ),
        iconStyleData: IconStyleData(
          icon: const Icon(Icons.arrow_drop_down_rounded),
          iconSize: Values.iconSize,
          iconEnabledColor: Interface.dark,
          iconDisabledColor: Interface.disabled,
        ),
        dropdownStyleData: DropdownStyleData(
          // maxHeight: 300,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(color: _actualBackground),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: _height - 15,
          padding: EdgeInsets.zero,
        ),
      );

  Widget _buildWidgets() {
    return DropdownButtonHideUnderline(child: dropdownButton);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
