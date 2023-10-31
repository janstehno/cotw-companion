// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetTitleBig extends StatelessWidget {
  final String primaryText;
  final String secondaryText;
  final int maxLines;

  final double height = 70;

  const WidgetTitleBig({
    Key? key,
    required this.primaryText,
    this.secondaryText = "",
    this.maxLines = 1,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: height,
        color: Interface.title,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: secondaryText.isEmpty
            ? AutoSizeText(
                primaryText.toUpperCase(),
                maxLines: maxLines,
                textAlign: TextAlign.start,
                style: Interface.s20w600c(Interface.dark),
              )
            : Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                AutoSizeText(
                  primaryText.toUpperCase(),
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: Interface.s20w600c(Interface.dark),
                ),
                AutoSizeText(
                  secondaryText,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: Interface.s12w300n(Interface.disabled),
                )
              ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
