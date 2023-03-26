// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetSwitchSort extends StatelessWidget {
  final String icon;
  final Color activeColor, inactiveColor, activeBackground, inactiveBackground;
  final double size, inactiveOpacity;
  final bool isAscended, isActive;
  final int orderNumber;
  final Function onTap;

  const WidgetSwitchSort({
    Key? key,
    required this.icon,
    required this.activeColor,
    required this.inactiveColor,
    required this.activeBackground,
    required this.inactiveBackground,
    this.size = 40,
    this.inactiveOpacity = 0.3,
    required this.orderNumber,
    required this.isAscended,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    Color c = isActive ? activeColor : inactiveColor.withOpacity(inactiveOpacity);
    Color b = isActive ? activeBackground : inactiveBackground.withOpacity(inactiveOpacity);
    String i = isAscended ? "assets/graphics/icons/sort_ascended.svg" : "assets/graphics/icons/sort_descended.svg";
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
                color: b,
              ),
              child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                SvgPicture.asset(
                  icon,
                  width: 10,
                  height: 10,
                  color: c,
                ),
                Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  SvgPicture.asset(
                    i,
                    width: 12,
                    height: 12,
                    color: c,
                  ),
                  AutoSizeText(orderNumber.toString(),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: activeColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                ])
              ]))),
      AnimatedOpacity(
          opacity: isActive ? 0 : 1,
          duration: const Duration(milliseconds: 200),
          child: WidgetSwitch.withIcon(
              activeIcon: icon,
              inactiveIcon: icon,
              buttonSize: size,
              activeColor: activeColor,
              activeBackground: activeBackground,
              inactiveColor: inactiveColor,
              inactiveBackground: inactiveBackground,
              isActive: isActive,
              onTap: () {
                onTap();
              })),
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
