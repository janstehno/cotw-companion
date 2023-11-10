// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/switch_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetSwitchSort extends StatelessWidget {
  final String icon;
  final double size;
  final Color? color, background, activeColor, activeBackground;
  final bool isAscended, isActive;
  final int orderNumber;
  final Function onTap;

  const WidgetSwitchSort({
    Key? key,
    required this.icon,
    this.size = 35,
    this.color,
    this.background,
    this.activeColor,
    this.activeBackground,
    required this.orderNumber,
    required this.isAscended,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    Color widgetColor = isActive ? activeColor ?? Interface.accent : color ?? Interface.dark.withOpacity(0.3);
    Color widgetBackground = isActive ? activeBackground ?? Interface.primary : background ?? Interface.disabled.withOpacity(0.3);
    String orderArrow = isAscended ? "assets/graphics/icons/sort_ascended.svg" : "assets/graphics/icons/sort_descended.svg";
    return Stack(children: [
      AnimatedOpacity(
          opacity: isActive ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
              height: size,
              width: size,
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(size / 4)),
                color: widgetBackground,
              ),
              child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                SvgPicture.asset(
                  icon,
                  width: (size / 5) * 2 - 2,
                  height: (size / 5) * 2 - 2,
                  colorFilter: ColorFilter.mode(
                    widgetColor,
                    BlendMode.srcIn,
                  ),
                ),
                Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  SvgPicture.asset(
                    orderArrow,
                    width: (size / 5) * 2 - 2,
                    height: (size / 5) * 2 - 2,
                    colorFilter: ColorFilter.mode(
                      widgetColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  AutoSizeText(
                    orderNumber.toString(),
                    maxLines: 1,
                    minFontSize: 8,
                    textAlign: TextAlign.center,
                    style: Interface.s14w500n(Interface.accent),
                  ),
                ])
              ]))),
      AnimatedOpacity(
          opacity: isActive ? 0 : 1,
          duration: const Duration(milliseconds: 200),
          child: WidgetSwitchIcon(
              buttonSize: size,
              icon: icon,
              color: color,
              background: background,
              activeColor: activeColor,
              activeBackground: activeBackground,
              isActive: isActive,
              onTap: () {
                onTap();
              })),
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
