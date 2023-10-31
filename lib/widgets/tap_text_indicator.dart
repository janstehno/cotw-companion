// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/tap_text.dart';
import 'package:flutter/material.dart';

class WidgetTapTextIndicator extends WidgetTapText {
  final int maxLines;
  final bool isActive;

  final double _indicatorSize = 20;

  const WidgetTapTextIndicator({
    super.key,
    required super.text,
    super.color,
    super.background,
    this.maxLines = 1,
    this.isActive = false,
    required super.onTap,
  });

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
            height: super.height,
            color: background ?? Colors.transparent,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: AutoSizeText(
                        text,
                        maxLines: maxLines,
                        textAlign: TextAlign.start,
                        style: Interface.s16w300n(Interface.dark),
                      ))),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _indicatorSize,
                height: _indicatorSize,
                decoration: BoxDecoration(
                  color: isActive ? color ?? Interface.primary : Interface.disabled,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ])));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
