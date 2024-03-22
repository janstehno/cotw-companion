import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/handling/slider.dart';
import 'package:cotwcompanion/widgets/title/title_icon.dart';
import 'package:flutter/material.dart';

class WidgetFilterValue extends StatefulWidget {
  final FilterKey _filterKeyLower;
  final FilterKey _filterKeyUpper;
  final String _icon;
  final String _text;

  const WidgetFilterValue(
    FilterKey filterKeyLower,
    FilterKey filterKeyUpper, {
    super.key,
    required String icon,
    required String text,
  })  : _filterKeyLower = filterKeyLower,
        _filterKeyUpper = filterKeyUpper,
        _icon = icon,
        _text = text;

  FilterKey get filterKeyLower => _filterKeyLower;

  FilterKey get filterKeyUpper => _filterKeyUpper;

  String get icon => _icon;

  String get text => _text;

  @override
  State<StatefulWidget> createState() => WidgetFilterValueState();
}

class WidgetFilterValueState extends State<WidgetFilterValue> {
  num get _min => HelperFilter.getDefaultValue(widget.filterKeyLower);

  num get _max => HelperFilter.getDefaultValue(widget.filterKeyUpper);

  Widget _buildSlider() {
    return WidgetSlider(
      min: _min.toDouble(),
      max: _max.toDouble(),
      values: [HelperFilter.getIntValue(widget.filterKeyLower).toDouble()],
      onChange: (id, lower, upper) => setState(() => HelperFilter.changeNumValue(widget.filterKeyLower, lower.toInt())),
    );
  }

  Widget _buildWidgets() {
    return Column(
      children: [
        WidgetTitleIcon(
          widget.text,
          icon: widget.icon,
        ),
        WidgetPadding.h30v20(child: _buildSlider())
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
