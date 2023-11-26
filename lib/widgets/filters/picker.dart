// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/widgets/title_info_icon.dart';
import 'package:flutter/cupertino.dart';

abstract class FilterPicker extends StatefulWidget {
  final String icon, text;
  final FilterKey filterKey;
  final List<String> labels;
  final List<Color> colors, backgrounds;

  const FilterPicker({
    Key? key,
    required this.icon,
    required this.text,
    required this.filterKey,
    this.labels = const [],
    this.colors = const [],
    this.backgrounds = const [],
  }) : super(key: key);
}

abstract class FilterPickerState extends State<FilterPicker> {
  final double _wrapSpace = 10;

  late final List<int> values;

  @override
  void initState() {
    values = HelperFilter.getDefaultListKeys(widget.filterKey);
    super.initState();
  }

  buildItem(int index, int key) {}

  List<Widget> _buildSwitches() {
    List<Widget> switches = [];
    for (int index = 0; index < values.length; index++) {
      int key = values[index];
      switches.add(buildItem(index, key));
    }
    return switches;
  }

  Widget _buildWidgets() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: widget.icon,
        text: widget.text,
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Wrap(
          spacing: _wrapSpace,
          runSpacing: _wrapSpace,
          alignment: WrapAlignment.start,
          children: _buildSwitches(),
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
