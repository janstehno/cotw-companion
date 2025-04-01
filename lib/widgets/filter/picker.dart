import 'package:collection/collection.dart';
import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:flutter/material.dart';

abstract class WidgetFilterPicker<E> extends StatefulWidget {
  final Filter _filter;
  final FilterKey _filterKey;
  final List<E> _bitKeys;
  final List<String> _labels;
  final List<Color> _colors;
  final List<Color> _backgrounds;

  WidgetFilterPicker({
    super.key,
    required Filter filter,
    required FilterKey filterKey,
    required List<E> bitKeys,
    List<String> labels = const [],
    List<Color> colors = const [],
    List<Color> backgrounds = const [],
  })  : _filter = filter,
        _filterKey = filterKey,
        _bitKeys = bitKeys,
        _labels = labels,
        _colors = colors,
        _backgrounds = backgrounds,
        assert(colors.isEmpty || colors.length == bitKeys.length),
        assert(labels.isEmpty || labels.length == bitKeys.length),
        assert(backgrounds.isEmpty || backgrounds.length == bitKeys.length);

  Filter get filter => _filter;

  FilterKey get filterKey => _filterKey;

  List<E> get bitKeys => _bitKeys;

  List<String> get labels => _labels;

  List<Color> get colors => _colors;

  get backgrounds => _backgrounds;
}

abstract class WidgetFilterPickerState extends State<WidgetFilterPicker> {
  Widget buildItem(int i);

  List<Widget> _listSwitches(BuildContext context) {
    return widget.bitKeys.mapIndexed((i, key) => buildItem(i)).toList();
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetPadding.h30v20(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        children: _listSwitches(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
