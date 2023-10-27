// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetTitleBigDot extends StatelessWidget {
  final String primaryText;
  final String secondaryText;
  final Color dotColor;
  final int maxLines;

  static const double height = 50;

  const WidgetTitleBigDot({
    Key? key,
    required this.primaryText,
    this.secondaryText = "",
    this.dotColor = Colors.transparent,
    this.maxLines = 1,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: height,
        color: Interface.sectionTitle,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
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
              width: 10,
              height: 10,
              decoration: ShapeDecoration(
                color: dotColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.3)),
              ))
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
