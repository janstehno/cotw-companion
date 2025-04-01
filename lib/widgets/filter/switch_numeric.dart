import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/widgets/section/section_indicator_tap.dart';
import 'package:flutter/material.dart';

class WidgetFilterSwitchNumeric extends StatefulWidget {
  final Filter _filter;
  final FilterKey _filterKey;
  final int _bit;
  final String _text;
  final bool _enabled;

  const WidgetFilterSwitchNumeric({
    super.key,
    required Filter filter,
    required FilterKey filterKey,
    required int bit,
    required String text,
    bool enabled = true,
  })  : _filter = filter,
        _filterKey = filterKey,
        _bit = bit,
        _text = text,
        _enabled = enabled;

  Filter get filter => _filter;

  FilterKey get filterKey => _filterKey;

  int get bit => _bit;

  String get text => _text;

  bool get enabled => _enabled;

  @override
  State<StatefulWidget> createState() => WidgetFilterSwitchNumericState();
}

class WidgetFilterSwitchNumericState extends State<WidgetFilterSwitchNumeric> {
  void _toggleFilter() {
    setState(() {
      widget.filter.toggle(widget.filterKey, widget.bit);
    });
  }

  Widget _buildWidgets() {
    return WidgetSectionIndicatorTap(
      widget.text,
      color: widget.enabled ? Interface.dark : Interface.disabled,
      background: Utils.backgroundAt(widget.bit),
      indicatorColor: widget.filter.indicatorColor(widget.filterKey, widget.bit),
      onTap: () {
        if (widget.enabled) _toggleFilter();
      },
      isShown: widget.enabled,
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
