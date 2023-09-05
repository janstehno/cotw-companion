// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetSlider extends StatelessWidget {
  final List<double> values;
  final String text;
  final double min, max;
  final Function onDrag;

  const WidgetSlider({
    Key? key,
    required this.values,
    this.text = "",
    required this.min,
    required this.max,
    required this.onDrag,
  }) : super(key: key);

  Widget _buildWidgets() {
    return FlutterSlider(
        min: min,
        max: max,
        values: values,
        handlerWidth: 35,
        handlerHeight: 35,
        tooltip: FlutterSliderTooltip(disabled: true),
        trackBar: FlutterSliderTrackBar(
            activeTrackBarHeight: 3,
            inactiveTrackBarHeight: 3,
            activeTrackBar: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(1)),
              color: Interface.primary,
            ),
            inactiveTrackBar: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(1)),
              color: Interface.disabled.withOpacity(0.3),
            )),
        handler: FlutterSliderHandler(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(35 / 4)),
              color: Interface.primary,
            ),
            child: Container(
                alignment: Alignment.center,
                child: AutoSizeText(
                  text,
                  style: Interface.s18w500n(Interface.accent),
                ))),
        onDragging: (id, lower, upper) {
          onDrag(id, lower, upper);
        });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
