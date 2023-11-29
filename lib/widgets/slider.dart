// Copyright (c) 2023 Jan Stehno

import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetSlider extends StatelessWidget {
  final List<double> values;
  final double min, max;
  final Function onDrag;

  final double _handlerSize = 35;
  final double _trackSize = 3;

  const WidgetSlider({
    Key? key,
    required this.values,
    required this.min,
    required this.max,
    required this.onDrag,
  }) : super(key: key);

  Widget _buildWidgets() {
    return FlutterSlider(
        min: min,
        max: max,
        values: values,
        handlerWidth: _handlerSize,
        handlerHeight: _handlerSize,
        tooltip: FlutterSliderTooltip(disabled: true),
        trackBar: FlutterSliderTrackBar(
            activeTrackBarHeight: _trackSize,
            inactiveTrackBarHeight: _trackSize,
            activeTrackBar: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(1)),
              color: Interface.primary.withOpacity(0.75),
            ),
            inactiveTrackBar: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(1)),
              color: Interface.disabled.withOpacity(0.3),
            )),
        handler: FlutterSliderHandler(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(_handlerSize / 4)),
              color: Interface.primary,
            ),
            child: Container(
                alignment: Alignment.center,
                child: AutoSizeText(
                  values[0].toInt().toString(),
                  style: Interface.s18w500n(Interface.accent),
                ))),
        onDragging: (id, lower, upper) {
          onDrag(id, lower, upper);
        });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
