// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetTitleBig extends StatelessWidget {
  final String primaryText;
  final String secondaryText;
  final int maxLines;
  final bool upperCase;

  final double height = 70;

  const WidgetTitleBig({
    Key? key,
    required this.primaryText,
    this.secondaryText = "",
    this.maxLines = 1,
    this.upperCase = true,
  }) : super(key: key);

  Widget buildText(TextStyle primaryStyle, TextStyle secondaryStyle) {
    return secondaryText.isEmpty
        ? AutoSizeText(
            upperCase ? primaryText.toUpperCase() : primaryText,
            maxLines: maxLines,
            textAlign: TextAlign.start,
            style: primaryStyle,
          )
        : Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                upperCase ? primaryText.toUpperCase() : primaryText,
                maxLines: 1,
                textAlign: TextAlign.start,
                style: primaryStyle,
              ),
              AutoSizeText(
                secondaryText,
                maxLines: 1,
                textAlign: TextAlign.start,
                style: secondaryStyle,
              )
            ],
          );
  }

  Widget buildTitle(Widget? additional) {
    return Container(
        height: height,
        color: Interface.title,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(
          children: [
            Expanded(
                child: Container(
              margin: EdgeInsets.only(right: additional == null ? 0 : 30),
              child: buildText(
                Interface.s20w600c(Interface.dark),
                Interface.s12w300n(Interface.disabled),
              ),
            )),
            additional ?? const SizedBox.shrink(),
          ],
        ));
  }

  Widget buildWidgets() {
    return buildTitle(null);
  }

  @override
  Widget build(BuildContext context) => buildWidgets();
}
