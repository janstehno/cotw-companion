// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetSwitch extends StatelessWidget {
  final String activeText, activeIcon, inactiveText, inactiveIcon;
  final Color activeColor, inactiveColor, activeBackground, inactiveBackground;
  final double buttonSize;
  final bool squareButton, disabled, isActive;

  final Function onTap;

  const WidgetSwitch({
    Key? key,
    this.buttonSize = 40,
    this.activeText = "",
    this.inactiveText = "",
    this.activeIcon = "",
    this.inactiveIcon = "",
    this.activeColor = Colors.transparent,
    this.inactiveColor = Colors.transparent,
    required this.activeBackground,
    required this.inactiveBackground,
    this.squareButton = true,
    this.disabled = false,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  const WidgetSwitch.withText({
    Key? key,
    this.buttonSize = 40,
    required this.activeText,
    required this.inactiveText,
    this.activeIcon = "",
    this.inactiveIcon = "",
    required this.activeColor,
    required this.inactiveColor,
    required this.activeBackground,
    required this.inactiveBackground,
    this.squareButton = false,
    this.disabled = false,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  const WidgetSwitch.withIcon({
    Key? key,
    this.buttonSize = 40,
    this.activeText = "",
    this.inactiveText = "",
    required this.activeIcon,
    required this.inactiveIcon,
    required this.activeColor,
    required this.inactiveColor,
    required this.activeBackground,
    required this.inactiveBackground,
    this.squareButton = true,
    this.disabled = false,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: disabled
            ? () {}
            : () {
                onTap();
              },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: buttonSize,
          width: squareButton ? buttonSize : null,
          alignment: Alignment.center,
          padding: squareButton ? const EdgeInsets.all(0) : const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(buttonSize / 4)),
            color: isActive ? activeBackground : inactiveBackground,
          ),
          child: activeIcon.isNotEmpty && activeText.isEmpty
              ? SvgPicture.asset(
                  isActive ? activeIcon : inactiveIcon,
                  width: buttonSize / 2.5,
                  height: buttonSize / 2.5,
                  color: isActive ? activeColor : inactiveColor,
                )
              : activeIcon.isEmpty && activeText.isNotEmpty
                  ? AutoSizeText(isActive ? activeText : inactiveText,
                      maxLines: 1,
                      style: TextStyle(
                        color: isActive ? activeColor : inactiveColor,
                        fontSize: Interface.s18,
                        fontWeight: FontWeight.w600,
                      ))
                  : Container(),
        ));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
