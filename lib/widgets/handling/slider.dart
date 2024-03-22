import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/indicator/indicator.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetSlider extends StatelessWidget {
  final double _min, _max;
  final List<double> _values;
  final Function _onChange;

  const WidgetSlider({
    super.key,
    required double min,
    required double max,
    required List<double> values,
    required Function onChange,
  })  : _min = min,
        _max = max,
        _values = values,
        _onChange = onChange;

  FlutterSliderTrackBar _buildTrack() {
    return FlutterSliderTrackBar(
      activeTrackBarHeight: 2,
      inactiveTrackBarHeight: 2,
      activeTrackBar: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        color: Interface.primary,
      ),
      inactiveTrackBar: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        color: Interface.disabled,
      ),
    );
  }

  FlutterSliderHandler _buildHandler() {
    return FlutterSliderHandler(
      decoration: const BoxDecoration(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const WidgetIndicator(
            Interface.primary,
            size: Values.tapSize,
          ),
          WidgetText(
            _values[0].toInt().toString(),
            color: Interface.alwaysDark,
            style: Style.normal.s16.w500,
          ),
        ],
      ),
    );
  }

  Widget _buildWidgets() {
    return FlutterSlider(
      min: _min,
      max: _max,
      values: _values,
      handlerWidth: Values.tapSize,
      handlerHeight: Values.tapSize,
      tooltip: FlutterSliderTooltip(disabled: true),
      trackBar: _buildTrack(),
      handler: _buildHandler(),
      onDragging: (id, lower, upper) => _onChange(id, lower, upper),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
