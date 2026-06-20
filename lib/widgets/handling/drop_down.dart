import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WidgetDropDown<V> extends StatelessWidget {
  final ValueListenable<V> _valueListenable;
  final Color? _background;
  final List<DropdownItem<V>> _items;
  final Function _onChange;

  const WidgetDropDown({
    super.key,
    required ValueListenable<V> valueListenable,
    Color? background,
    required List<DropdownItem<V>> items,
    required Function onChange,
  })  : _valueListenable = valueListenable,
        _background = background,
        _items = items,
        _onChange = onChange;

  double get _height => Values.dropDown;

  Color get _actualBackground => _background ?? Interface.body;

  Widget _buildWidgets() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<V>(
        isExpanded: true,
        valueListenable: _valueListenable,
        onChanged: (value) async => await _onChange(value),
        items: _items,
        buttonStyleData: ButtonStyleData(
          height: _height,
          padding: const EdgeInsets.only(right: 25),
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
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(color: _actualBackground),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
