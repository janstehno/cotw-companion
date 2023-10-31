// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:flutter/material.dart';

class WidgetTitleBigButton extends WidgetTitleBig {
  final String icon;
  final Color? color, background;
  final Function onTap;

  const WidgetTitleBigButton({
    super.key,
    required super.primaryText,
    super.secondaryText,
    required this.icon,
    this.color,
    this.background,
    required this.onTap,
  });

  Widget _buildWidgets() {
    return Container(
        height: super.height,
        color: Interface.title,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(children: [
          Expanded(
              child: Container(
                  margin: const EdgeInsets.only(right: 30),
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
                        ]))),
          WidgetButtonIcon(
            icon: icon,
            color: color,
            background: background,
            onTap: () {
              onTap();
            },
          )
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
