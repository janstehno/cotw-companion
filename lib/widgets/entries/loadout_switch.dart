// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/switch_icon.dart';
import 'package:flutter/material.dart';

class WidgetLoadoutSwitch extends StatelessWidget {
  final String primaryText, secondaryText;
  final String icon, activeIcon;
  final Color? color, background, activeColor, activeBackground;
  final int index, maxLines;
  final bool isActive;
  final Function onTap;

  const WidgetLoadoutSwitch({
    Key? key,
    required this.primaryText,
    this.secondaryText = "",
    this.icon = "",
    this.activeIcon = "",
    this.color,
    this.background,
    this.activeColor,
    this.activeBackground,
    required this.index,
    this.maxLines = 1,
    this.isActive = false,
    required this.onTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: 70,
        color: index % 2 == 0 ? Interface.even : Interface.odd,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Row(children: [
          Expanded(
              child: Container(
                  margin: const EdgeInsets.only(right: 30),
                  child: secondaryText.isEmpty
                      ? AutoSizeText(
                          primaryText,
                          maxLines: maxLines,
                          textAlign: TextAlign.start,
                          style: Interface.s18w300n(Interface.dark),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              AutoSizeText(
                                primaryText,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: Interface.s18w300n(Interface.dark),
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
