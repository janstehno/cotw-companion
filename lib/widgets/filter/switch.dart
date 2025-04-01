import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/widgets/section/section_indicator_tap.dart';
import 'package:flutter/material.dart';

class WidgetFilterSwitch<E extends Enum> extends StatefulWidget {
  final Filter _filter;
  final FilterKey _filterKey;
  final E _bitKey;
  final String _text;
  final bool _enabled;

  const WidgetFilterSwitch({
    super.key,
    required Filter filter,
    required FilterKey filterKey,
    required E bitKey,
    required String text,
    bool enabled = true,
  })  : _filter = filter,
        _filterKey = filterKey,
        _bitKey = bitKey,
        _text = text,
        _enabled = enabled;

  Filter get filter => _filter;

  FilterKey get filterKey => _filterKey;

  E get bitKey => _bitKey;

  String get text => _text;

  bool get enabled => _enabled;

  @override
  State<StatefulWidget> createState() => WidgetFilterSwitchState();
}

class WidgetFilterSwitchState extends State<WidgetFilterSwitch> {
  void _toggleFilter() {
    setState(() {
      widget.filter.toggle(widget.filterKey, widget.bitKey.index);
    });
  }

  Widget _buildWidgets() {
    return WidgetSectionIndicatorTap(
      widget.text,
      color: widget.enabled ? Interface.dark : Interface.disabled,
      background: Utils.backgroundAt(widget.bitKey.index),
      indicatorColor: widget.filter.indicatorColor(widget.filterKey, widget.bitKey.index),
      onTap: () {
        if (widget.enabled) _toggleFilter();
      },
      isShown: widget.enabled,
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
