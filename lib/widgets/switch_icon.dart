// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetSwitchIcon extends StatelessWidget {
  final String icon, activeIcon;
  final Color? color, background, activeColor, activeBackground;
  final double buttonSize;
  final Function onTap;
  final bool isActive;
  final bool disabled;

  const WidgetSwitchIcon({
    Key? key,
    this.icon = "",
    this.activeIcon = "",
    this.buttonSize = 35,
    this.color,
    this.background,
    this.activeColor,
    this.activeBackground,
    required this.onTap,
    required this.isActive,
    this.disabled = false,
  }) : super(key: key);

  Widget _buildWidgets() {
    String actualIcon = !disabled && isActive
        ? activeIcon.isEmpty
            ? icon
            : activeIcon
        : icon;
    Color actualColor = !disabled && isActive
        ? activeColor ?? Interface.accent
        : !disabled
            ? color ?? Interface.dark.withOpacity(0.3)
            : (color ?? Interface.dark).withOpacity(0.3);
    Color actualBackground = !disabled && isActive
        ? activeBackground ?? Interface.primary
        : !disabled
            ? background ?? Interface.disabled.withOpacity(0.3)
            : (background ?? Interface.disabled).withOpacity(0.3);
    return GestureDetector(
        onTap: disabled
            ? () {}
            : () {
                onTap();
              },
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: buttonSize,
            width: buttonSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(35 / 4)),
              color: actualBackground,
            ),
            child: icon.isEmpty && activeIcon.isEmpty
                ? const SizedBox.shrink()
                : SvgPicture.asset(
                    actualIcon,
                    width: buttonSize / 2,
                    height: buttonSize / 2,
                    colorFilter: ColorFilter.mode(
                      actualColor,
                      BlendMode.srcIn,
                    ),
                  )));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
