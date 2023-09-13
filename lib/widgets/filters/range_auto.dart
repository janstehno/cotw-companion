// Copyright (c) 2023 Jan Stehno

import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/title_info_icon.dart';
import 'package:flutter/material.dart';

class FilterRangeAuto extends StatefulWidget {
  final String icon, text;
  final FilterKey filterKeyLower, filterKeyUpper;
  final int min, max;
  final double handleSize = 30;

  const FilterRangeAuto({
    Key? key,
    required this.icon,
    required this.text,
    required this.filterKeyLower,
    required this.filterKeyUpper,
    required this.min,
    required this.max,
  }) : super(key: key);

  @override
  FilterRangeAutoState createState() => FilterRangeAutoState();
}

class FilterRangeAutoState extends State<FilterRangeAuto> {
  Widget _buildWidgets() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: widget.icon,
        text: widget.text,
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: FlutterSlider(
            rangeSlider: true,
            min: widget.min.toDouble(),
            max: widget.max.toDouble(),
            values: [
              HelperFilter.getIntValue(widget.filterKeyLower).toDouble(),
              HelperFilter.getIntValue(widget.filterKeyUpper).toDouble(),
            ],
            handlerWidth: widget.handleSize,
            handlerHeight: widget.handleSize,
            tooltip: FlutterSliderTooltip(disabled: true),
            trackBar: FlutterSliderTrackBar(
                activeTrackBarHeight: 3,
                inactiveTrackBarHeight: 3,
                activeTrackBar: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(1)),
                  color: Interface.primary.withOpacity(0.65),
                ),
                inactiveTrackBar: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(1)),
                  color: Interface.disabled.withOpacity(0.35),
                )),
            handler: FlutterSliderHandler(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(widget.handleSize / 4)),
                  color: Interface.primary,
                ),
                child: Container(
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      HelperFilter.getIntValue(widget.filterKeyLower).toString(),
                      style: Interface.s18w500n(Interface.accent),
                    ))),
            rightHandler: FlutterSliderHandler(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(widget.handleSize / 4)),
                  color: Interface.primary,
                ),
                child: Container(
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      HelperFilter.getIntValue(widget.filterKeyUpper).toString(),
                      style: Interface.s18w500n(Interface.accent),
                    ))),
            onDragging: (id, lower, upper) {
              setState(() {
                HelperFilter.changeIntValue(widget.filterKeyLower, lower.toInt());
                HelperFilter.changeIntValue(widget.filterKeyUpper, upper.toInt());
              });
            }),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
