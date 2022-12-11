// Copyright (c) 2022 Jan Stehno

import 'package:another_xlider/another_xlider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';

class WidgetSlider extends StatelessWidget {
  final List<double> values;
  final String text;
  final double min;
  final double max;
  final double handlerSize;
  final int? handlerColor;
  final int? handlerBackground;
  final int? activeBarColor;
  final int? inactiveBarColor;
  final bool activeBarColorOpacity;
  final bool inactiveBarColorOpacity;
  final bool smallerSlider;
  final bool visible;
  final Function onDrag;

  const WidgetSlider(
      {Key? key,
      required this.values,
      required this.text,
      required this.min,
      required this.max,
      this.handlerSize = 40,
      this.handlerColor,
      this.handlerBackground,
      this.activeBarColor,
      this.inactiveBarColor,
      this.activeBarColorOpacity = false,
      this.inactiveBarColorOpacity = true,
      this.smallerSlider = false,
      this.visible = true,
      required this.onDrag})
      : super(key: key);

  Widget _buildWidgets() {
    return FlutterSlider(
        min: min,
        max: max,
        values: values,
        handlerWidth: handlerSize,
        handlerHeight: handlerSize,
        tooltip: FlutterSliderTooltip(disabled: true),
        trackBar: FlutterSliderTrackBar(
            activeTrackBarHeight: smallerSlider ? 3 : 4,
            inactiveTrackBarHeight: smallerSlider ? 3 : 4,
            activeTrackBar: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(smallerSlider ? (3 / 4) : (4 / 4))),
                color: Color(activeBarColor ?? Values.colorPrimary).withOpacity(activeBarColorOpacity ? 0.3 : 1)),
            inactiveTrackBar: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(smallerSlider ? (3 / 4) : (4 / 4))),
                color: Color(inactiveBarColor ?? Values.colorDisabled).withOpacity(inactiveBarColorOpacity ? 0.3 : 1))),
        handler: FlutterSliderHandler(
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(handlerSize / 4)), color: Color(handlerBackground ?? Values.colorPrimary)),
            child: Container(
                alignment: Alignment.center,
                child: AutoSizeText(text,
                    style: TextStyle(
                        color: Color(handlerColor ?? Values.colorAccent),
                        fontSize: smallerSlider ? Values.fontSize18 : Values.fontSize24,
                        fontWeight: FontWeight.w400)))),
        onDragging: (id, lower, upper) {
          onDrag(id, lower, upper);
        });
  }

  @override
  Widget build(BuildContext context) {
    return visible ? _buildWidgets() : Container();
  }
}
