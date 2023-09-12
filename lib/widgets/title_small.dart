// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetTitleSmall extends StatelessWidget {
  final String primaryText;
  final String secondaryText;
  final int maxLines;
  final Alignment alignment;

  const WidgetTitleSmall({
    Key? key,
    required this.primaryText,
    this.secondaryText = "",
    this.maxLines = 1,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: 50,
        color: Interface.sectionTitle,
        alignment: alignment,
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: secondaryText.isEmpty
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
              ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}