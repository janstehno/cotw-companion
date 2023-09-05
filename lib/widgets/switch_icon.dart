// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetSwitchIcon extends StatelessWidget {
  final String icon, activeIcon;
  final Color? color, background;
  final Color? activeColor, activeBackground;
  final double buttonSize;
  final Function onTap;
  final bool isActive;

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
  }) : super(key: key);

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: buttonSize,
            width: buttonSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(35 / 4)),
              color: isActive ? activeBackground ?? Interface.primary : background ?? Interface.disabled.withOpacity(0.3),
            ),
            child: icon.isEmpty && activeIcon.isEmpty
                ? Container()
                : SvgPicture.asset(
                    isActive
                        ? activeIcon
                        : icon.isEmpty
                            ? activeIcon
                            : icon,
                    width: buttonSize / 2.5,
                    height: buttonSize / 2.5,
                    colorFilter: ColorFilter.mode(
                      isActive ? activeColor ?? Interface.accent : color ?? Interface.disabled,
                      BlendMode.srcIn,
                    ),
                  )));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
