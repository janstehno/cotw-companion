import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/title/title_icon.dart';
import 'package:flutter/material.dart';

abstract class WidgetFilterPicker extends StatefulWidget {
  final FilterKey _filterKey;
  final String _icon;
  final String _text;
  final List<String> _labels;
  final List<Color> _colors;
  final List<Color> _backgrounds;

  const WidgetFilterPicker(
    FilterKey filterKey, {
    super.key,
    required String icon,
    required String text,
    List<String> labels = const [],
    List<Color> colors = const [],
    List<Color> backgrounds = const [],
  })  : _filterKey = filterKey,
        _icon = icon,
        _text = text,
        _labels = labels,
        _colors = colors,
        _backgrounds = backgrounds;

  String get text => _text;

  String get icon => _icon;

  FilterKey get filterKey => _filterKey;

  List<String> get labels => _labels;

  List<Color> get colors => _colors;

  get backgrounds => _backgrounds;

  List<int> get values => HelperFilter.getDefaultListKeys(_filterKey);
}

abstract class WidgetFilterPickerState extends State<WidgetFilterPicker> {
  Widget buildItem(int i, int key);

  List<Widget> _listSwitches(BuildContext context) {
    return widget.values.mapIndexed((i, value) => buildItem(i, value)).toList();
  }

  Widget _buildWidgets(BuildContext context) {
    return Column(
      children: [
        WidgetTitleIcon(
          widget.text,
          icon: widget.icon,
        ),
        WidgetPadding.h30v20(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            children: _listSwitches(context),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
