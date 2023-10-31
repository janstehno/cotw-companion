// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/tag.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:flutter/material.dart';

class WidgetTitleBigIcon extends WidgetTitleBig {
  final String icon;

  const WidgetTitleBigIcon({
    super.key,
    required super.primaryText,
    super.secondaryText,
    required this.icon,
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
          Container(
              height: super.height,
              color: Interface.title,
              padding: const EdgeInsets.only(right: 25),
              alignment: Alignment.center,
              child: WidgetTag.big(
                height: super.height / 1.75,
                icon: icon,
                color: Interface.disabled,
                background: Colors.transparent,
              ))
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
