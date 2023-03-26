// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/button.dart';
import 'package:cotwcompanion/widgets/switch.dart';
import 'package:flutter/material.dart';

class WidgetTitleFunctional extends StatelessWidget {
  final String text, subText;
  final String icon, inactiveIcon;
  final Color background, textColor, subTextColor, iconColor, buttonBackground, iconInactiveColor, buttonInactiveBackground;
  final double buttonSize;
  final bool oneLine, withSwitch, isTitle, isActive;
  final Function onTap;

  const WidgetTitleFunctional({
    Key? key,
    required this.text,
    this.subText = "",
    required this.textColor,
    this.subTextColor = Colors.transparent,
    this.icon = "",
    this.inactiveIcon = "",
    this.iconColor = Colors.transparent,
    this.iconInactiveColor = Colors.transparent,
    this.buttonBackground = Colors.transparent,
    this.buttonInactiveBackground = Colors.transparent,
    this.background = Colors.transparent,
    this.buttonSize = 40,
    this.oneLine = false,
    this.withSwitch = true,
    this.isTitle = false,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  const WidgetTitleFunctional.withSwitch({
    Key? key,
    required this.text,
    this.subText = "",
    required this.textColor,
    this.subTextColor = Colors.transparent,
    required this.icon,
    required this.inactiveIcon,
    required this.iconColor,
    required this.iconInactiveColor,
    required this.buttonBackground,
    required this.buttonInactiveBackground,
    required this.background,
    this.buttonSize = 40,
    this.oneLine = false,
    this.withSwitch = true,
    this.isTitle = false,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  const WidgetTitleFunctional.withButton({
    Key? key,
    required this.text,
    this.subText = "",
    required this.textColor,
    this.subTextColor = Colors.transparent,
    required this.icon,
    this.inactiveIcon = "",
    required this.iconColor,
    this.iconInactiveColor = Colors.transparent,
    required this.buttonBackground,
    this.buttonInactiveBackground = Colors.transparent,
    required this.background,
    this.buttonSize = 40,
    this.oneLine = false,
    this.withSwitch = false,
    this.isTitle = false,
    this.isActive = true,
    required this.onTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: 75,
        color: background,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              child: Container(
                  padding: const EdgeInsets.only(right: 30),
                  child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                    AutoSizeText(isTitle ? text.toUpperCase() : text,
                        maxLines: oneLine ? 1 : 2,
                        textAlign: TextAlign.start,
                        style: isTitle
                            ? TextStyle(
                                color: textColor,
                                fontSize: Interface.s24,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Title',
                              )
                            : TextStyle(
                                color: textColor,
                                fontSize: Interface.s24,
                                fontWeight: FontWeight.w600,
                              )),
                    subText.isNotEmpty
                        ? Container(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(subText,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: subTextColor,
                                  fontSize: Interface.s16,
                                  fontWeight: FontWeight.w400,
                                )))
                        : Container()
                  ]))),
          withSwitch
              ? WidgetSwitch.withIcon(
                  activeIcon: icon,
                  inactiveIcon: inactiveIcon,
                  activeColor: iconColor,
                  inactiveColor: iconInactiveColor,
                  activeBackground: buttonBackground,
                  inactiveBackground: buttonInactiveBackground,
                  buttonSize: buttonSize,
                  isActive: isActive,
                  onTap: () {
                    onTap();
                  },
                )
              : WidgetButton.withIcon(
                  icon: icon,
                  color: iconColor,
                  background: buttonBackground,
                  buttonSize: buttonSize,
                  onTap: () {
                    onTap();
                  },
                )
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
