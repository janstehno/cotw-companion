// Copyright (c) 2022 Jan Stehno

import 'package:another_xlider/another_xlider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetSlider extends StatelessWidget {
  final List<double> values;
  final String leftText, rightText;
  final double min, max, handleSize;
  final bool smallerSlider, rangeSlider;
  final Function onDrag;

  const WidgetSlider({
    Key? key,
    required this.values,
    this.leftText = "",
    this.rightText = "",
    required this.min,
    required this.max,
    this.handleSize = 40,
    this.smallerSlider = false,
    this.rangeSlider = false,
    required this.onDrag,
  }) : super(key: key);

  Widget _buildWidgets() {
    return FlutterSlider(
        min: min,
        max: max,
        rangeSlider: rangeSlider,
        values: values,
        handlerWidth: handleSize,
        handlerHeight: handleSize,
        tooltip: FlutterSliderTooltip(disabled: true),
        trackBar: FlutterSliderTrackBar(
            activeTrackBarHeight: smallerSlider ? 3 : 4,
            inactiveTrackBarHeight: smallerSlider ? 3 : 4,
            activeTrackBar: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(smallerSlider ? (3 / 4) : (4 / 4))),
              color: Interface.primary,
            ),
            inactiveTrackBar: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(smallerSlider ? (3 / 4) : (4 / 4))),
              color: Interface.disabled.withOpacity(0.3),
            )),
        handler: FlutterSliderHandler(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(handleSize / 4)),
              color: Interface.primary,
            ),
            child: Container(
                alignment: Alignment.center,
                child: AutoSizeText(leftText,
                    style: TextStyle(
                      color: Interface.accent,
                      fontSize: smallerSlider ? Interface.s18 : Interface.s24,
                      fontWeight: FontWeight.w400,
                    )))),
        rightHandler: FlutterSliderHandler(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(handleSize / 4)),
              color: Interface.primary,
            ),
            child: Container(
                alignment: Alignment.center,
                child: AutoSizeText(rightText,
                    style: TextStyle(
                      color: Interface.accent,
                      fontSize: smallerSlider ? Interface.s18 : Interface.s24,
                      fontWeight: FontWeight.w400,
                    )))),
        onDragging: (id, lower, upper) {
          onDrag(id, lower, upper);
        });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
