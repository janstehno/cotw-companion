// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetDropDown extends StatelessWidget {
  final int value;
  final List<DropdownMenuItem> items;
  final Function onTap;

  final double height = 60;
  final double maxHeight = 300;

  const WidgetDropDown({
    Key? key,
    required this.value,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    return DropdownButton(
      dropdownColor: Interface.dropDown,
      underline: const SizedBox.shrink(),
      icon: const SizedBox.shrink(),
      elevation: 0,
      itemHeight: height,
      menuMaxHeight: maxHeight,
      isExpanded: true,
      value: value,
      onChanged: (dynamic value) {
        onTap(value);
      },
      items: items,
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
