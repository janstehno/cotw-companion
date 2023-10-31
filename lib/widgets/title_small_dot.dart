// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/title_small.dart';
import 'package:flutter/material.dart';

class WidgetTitleSmallDot extends WidgetTitleSmall {
  final Color dotColor;

  final double _dotSize = 10;

  const WidgetTitleSmallDot({
    super.key,
    required super.primaryText,
    required this.dotColor,
  });

  Widget _buildWidgets() {
    return Container(
        height: super.height,
        color: Interface.sectionTitle,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
          secondaryText.isEmpty
              ? AutoSizeText(
                  primaryText.toUpperCase(),
                  maxLines: maxLines,
                  textAlign: TextAlign.start,
                  style: Interface.s16w600c(Interface.dark),
                )
              : Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  AutoSizeText(
                    primaryText.toUpperCase(),
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: Interface.s16w600c(Interface.dark),
                  ),
                  AutoSizeText(
                    secondaryText,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: Interface.s12w300n(Interface.disabled),
                  )
                ]),
          Container(
              width: _dotSize,
              height: _dotSize,
              decoration: ShapeDecoration(
                color: dotColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.3)),
              ))
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
