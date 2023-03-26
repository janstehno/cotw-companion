// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/switch.dart';
import 'package:flutter/material.dart';

class WidgetTitleFunctionalDoubleSwitch extends StatelessWidget {
  final String text, leftText, leftIcon, rightText, rightIcon;
  final Color color, background, activeColor, inactiveColor, activeBackground, inactiveBackground;
  final bool isActive;
  final Function onTap;

  final double size = 40;

  const WidgetTitleFunctionalDoubleSwitch.withText({
    Key? key,
    required this.text,
    required this.leftText,
    required this.rightText,
    this.leftIcon = "",
    this.rightIcon = "",
    required this.color,
    required this.background,
    required this.activeColor,
    required this.inactiveColor,
    required this.activeBackground,
    required this.inactiveBackground,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  const WidgetTitleFunctionalDoubleSwitch.withIcon({
    Key? key,
    required this.text,
    this.leftText = "",
    this.rightText = "",
    required this.leftIcon,
    required this.rightIcon,
    required this.color,
    required this.background,
    required this.activeColor,
    required this.inactiveColor,
    required this.activeBackground,
    required this.inactiveBackground,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  Widget _buildFunctionalPart() {
    return Row(
        children: leftText.isNotEmpty && rightText.isNotEmpty
            ? [
                WidgetSwitch.withText(
                  activeText: leftText,
                  inactiveText: leftText,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  activeBackground: activeBackground,
                  inactiveBackground: inactiveBackground,
                  isActive: !isActive,
                  onTap: () {
                    if (isActive) onTap();
                  },
                ),
                const SizedBox(width: 15),
                WidgetSwitch.withText(
                  activeText: rightText,
                  inactiveText: rightText,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  activeBackground: activeBackground,
                  inactiveBackground: inactiveBackground,
                  isActive: isActive,
                  onTap: () {
                    if (!isActive) onTap();
                  },
                )
              ]
            : [
                WidgetSwitch.withIcon(
                  activeIcon: leftIcon,
                  inactiveIcon: leftIcon,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  activeBackground: activeBackground,
                  inactiveBackground: inactiveBackground,
                  isActive: !isActive,
                  onTap: () {
                    if (isActive) onTap();
                  },
                ),
                const SizedBox(width: 15),
                WidgetSwitch.withIcon(
                  activeIcon: rightIcon,
                  inactiveIcon: rightIcon,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  activeBackground: activeBackground,
                  inactiveBackground: inactiveBackground,
                  isActive: isActive,
                  onTap: () {
                    if (!isActive) onTap();
                  },
                )
              ]);
  }

  Widget _buildWidgets() {
    return Container(
        height: 75,
        color: background,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              child: Container(
                  padding: const EdgeInsets.only(right: 30),
                  child: AutoSizeText(
                    text.toUpperCase(),
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: color,
                      fontSize: Interface.s24,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Title',
                    ),
                  ))),
          _buildFunctionalPart()
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
