// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/switch_sort.dart';
import 'package:cotwcompanion/widgets/title_info_icon.dart';
import 'package:flutter/material.dart';

class FilterSorterIcon extends StatefulWidget {
  final String icon, text;
  final FilterKey filterKey;
  final List<int> values;
  final List<String> icons;
  final List<bool> criteria;
  final List<String> preferences;

  const FilterSorterIcon({
    Key? key,
    required this.icon,
    required this.text,
    required this.filterKey,
    required this.values,
    required this.icons,
    required this.criteria,
    required this.preferences,
  }) : super(key: key);

  @override
  FilterSorterIconState createState() => FilterSorterIconState();
}

class FilterSorterIconState extends State<FilterSorterIcon> {
  double _getSwitchSize() {
    double itemWidth = 30;
    double screenWidth = MediaQuery.of(context).size.width;
    double itemsBetween = (widget.values.length - 1) * 10 + 60;
    double availableWidth = screenWidth - itemsBetween;
    double itemsWidth = widget.values.length * itemWidth;
    double calcWidth = availableWidth / widget.values.length;
    return availableWidth > itemsWidth ? itemWidth : calcWidth;
  }

  List<Widget> _buildSwitches() {
    List<Widget> switches = [];
    for (int index = 0; index < widget.values.length; index++) {
      int key = widget.values[index];
      bool criteria = widget.criteria[index];
      String preference = widget.preferences[index];
      int order = HelperFilter.getSortValue(widget.filterKey, key, "order");
      bool ascended = HelperFilter.getSortValue(widget.filterKey, key, "ascended");
      bool active = HelperFilter.getSortValue(widget.filterKey, key, "active");
      switches.add(Container(
          margin: const EdgeInsets.only(right: 10),
          child: WidgetSwitchSort(
            size: _getSwitchSize(),
            icon: widget.icons[index],
            orderNumber: order,
            isAscended: ascended,
            isActive: active,
            onTap: () {
              setState(() {
                HelperFilter.useSort(widget.filterKey, key, criteria, preference);
              });
            },
          )));
    }
    switches.add(
      WidgetButtonIcon(
          buttonSize: _getSwitchSize(),
          icon: "assets/graphics/icons/reload.svg",
          onTap: () {
            setState(() {
              HelperFilter.resetSort(widget.filterKey);
            });
          }),
    );
    return switches;
  }

  Widget _buildWidgets() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: widget.icon,
        text: widget.text,
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: _buildSwitches(),
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
