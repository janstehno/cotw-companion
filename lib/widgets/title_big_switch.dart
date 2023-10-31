// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/switch_icon.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:flutter/material.dart';

class WidgetTitleBigSwitch extends WidgetTitleBig {
  final String icon, activeIcon;
  final Color? color, background, activeColor, activeBackground;
  final bool isActive;
  final Function onTap;

  const WidgetTitleBigSwitch({
    super.key,
    required super.primaryText,
    super.maxLines,
    this.icon = "",
    this.activeIcon = "",
    this.color,
    this.background,
    this.activeColor,
    this.activeBackground,
    this.isActive = false,
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
          WidgetSwitchIcon(
            icon: icon,
            activeIcon: activeIcon,
            color: color,
            background: background,
            activeColor: activeColor,
            activeBackground: activeBackground,
            isActive: isActive,
            onTap: () {
              onTap();
            },
          )
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
