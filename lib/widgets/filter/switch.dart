import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/widgets/section/section_indicator_tap.dart';
import 'package:flutter/material.dart';

class WidgetFilterSwitch extends StatefulWidget {
  final FilterKey _filterKey;
  final int _index;
  final String _text;

  const WidgetFilterSwitch(
    FilterKey filterKey, {
    super.key,
    required int i,
    required String text,
  })  : _filterKey = filterKey,
        _index = i,
        _text = text;

  FilterKey get filterKey => _filterKey;

  int get i => _index;

  String get text => _text;

  @override
  State<StatefulWidget> createState() => WidgetFilterSwitchState();
}

class WidgetFilterSwitchState extends State<WidgetFilterSwitch> {
  Widget _buildWidgets() {
    return WidgetSectionIndicatorTap(
      widget.text,
      background: Utils.backgroundAt(widget.i),
      indicatorColor: HelperFilter.getBoolValue(widget.filterKey) ? Interface.primary : Interface.disabled,
      onTap: () {
        setState(() {
          HelperFilter.switchValue(widget.filterKey);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
