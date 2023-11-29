// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:flutter/material.dart';

class WidgetTitleSmall extends WidgetTitleBig {
  final Alignment alignment;
  final bool dot;
  final Color? dotColor;

  final double smallHeight = 60;

  final double _dotSize = 10;

  const WidgetTitleSmall({
    super.key,
    required super.primaryText,
    super.secondaryText,
    super.maxLines,
    this.alignment = Alignment.centerLeft,
    this.dot = false,
    this.dotColor,
  });

  Widget _buildDot() {
    return dot
        ? Container(
            width: _dotSize,
            height: _dotSize,
            decoration: ShapeDecoration(
              color: dotColor ?? Interface.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.3)),
            ))
        : const SizedBox.shrink();
  }

  @override
  Widget buildWidgets() {
    return Container(
        height: smallHeight,
        color: Interface.sectionTitle,
        alignment: alignment,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: buildText(
                Interface.s18w600c(Interface.dark),
                Interface.s12w300n(Interface.disabled),
              ),
            ),
            _buildDot(),
          ],
        ));
  }
}
