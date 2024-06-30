import 'package:cotwcompanion/helpers/hunting_pass.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/widgets/section/section_indicator_tap.dart';
import 'package:flutter/material.dart';

class WidgetFilterSwitchHuntingPass extends StatefulWidget {
  final FilterKey _filterKey;
  final int _index;
  final String _text;
  final HelperHuntingPass _helperHuntingPass;

  const WidgetFilterSwitchHuntingPass(
    FilterKey filterKey, {
    super.key,
    required int i,
    required String text,
    required HelperHuntingPass helperHuntingPass,
  })  : _filterKey = filterKey,
        _index = i,
        _text = text,
        _helperHuntingPass = helperHuntingPass;

  FilterKey get filterKey => _filterKey;

  int get i => _index;

  String get text => _text;

  HelperHuntingPass get helperHuntingPass => _helperHuntingPass;

  @override
  State<StatefulWidget> createState() => WidgetFilterSwitchHuntingPassState();
}

class WidgetFilterSwitchHuntingPassState extends State<WidgetFilterSwitchHuntingPass> {
  Widget _buildWidgets() {
    return WidgetSectionIndicatorTap(
      widget.text,
      background: Utils.backgroundAt(widget.i),
      indicatorColor: widget.helperHuntingPass.getValue(widget.filterKey) ? Interface.primary : Interface.disabled,
      onTap: () {
        setState(() {
          widget.helperHuntingPass.switchValue(widget.filterKey);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
