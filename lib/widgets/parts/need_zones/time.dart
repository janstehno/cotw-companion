import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/indicator/indicator.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetNeedZoneTime extends StatelessWidget {
  final int _hour;
  final int _minute;
  final int _second;
  final bool _compact;
  final Function _onClassTap;
  final Function _onViewTap;

  const WidgetNeedZoneTime({
    super.key,
    required int hour,
    required int minute,
    required int second,
    required bool compact,
    required Function onClassTap,
    required Function onViewTap,
  })  : _hour = hour,
        _minute = minute,
        _second = second,
        _compact = compact,
        _onClassTap = onClassTap,
        _onViewTap = onViewTap;

  double get _height => Values.section;

  Widget _buildClassSwitch() {
    return WidgetButtonIcon(
      Assets.graphics.icons.minMax,
      color: Interface.dark,
      background: Interface.transparent,
      onTap: () => _onClassTap(),
    );
  }

  Widget _buildViewSwitch() {
    return WidgetButtonIcon(
      Assets.graphics.icons.fullscreen,
      color: Interface.dark,
      background: Interface.transparent,
      onTap: () => _onViewTap(),
    );
  }

  Widget _buildSwitches(BuildContext context) {
    Orientation orientation = MediaQuery.orientationOf(context);
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        if (_compact) _buildClassSwitch(),
        if (orientation == Orientation.portrait) _buildViewSwitch(),
      ],
    );
  }

  Widget _buildDoubleDot() {
    return SizedBox(
      height: _height,
      child: Wrap(
        spacing: 2,
        runSpacing: 2,
        direction: Axis.vertical,
        alignment: WrapAlignment.center,
        children: [
          WidgetIndicator(Interface.dark, size: 2),
          WidgetIndicator(Interface.dark, size: 2),
        ],
      ),
    );
  }

  Widget _buildNumber(int number) {
    return Container(
      width: 30,
      height: _height,
      alignment: Alignment.center,
      child: WidgetText(
        number.toInt().toString(),
        color: Interface.dark,
        style: Style.normal.s18.w500,
      ),
    );
  }

  Widget _buildTime() {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      alignment: WrapAlignment.start,
      children: [
        _buildNumber(_hour),
        _buildDoubleDot(),
        _buildNumber(_minute),
        _buildDoubleDot(),
        _buildNumber(_second),
      ],
    );
  }

  Widget _buildWidgets(BuildContext context) {
    return SizedBox(
      height: _height,
      child: WidgetPadding.h30(
        background: Interface.primary.withValues(alpha: 0.6),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _buildTime()),
            _buildSwitches(context),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
