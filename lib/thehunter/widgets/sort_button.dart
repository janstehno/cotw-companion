// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetSortButton extends StatelessWidget {
  final String icon;
  final double size;
  final int? activeColor;
  final int? activeBackground;
  final int? inactiveColor;
  final int? inactiveBackground;
  final int number;
  final bool ascended;
  final bool noInactiveOpacity;
  final bool isActive;
  final Function onTap;

  const WidgetSortButton(
      {Key? key,
      required this.icon,
      this.size = 50,
      this.activeColor,
      this.activeBackground,
      this.inactiveColor,
      this.inactiveBackground,
      required this.number,
      required this.ascended,
      this.noInactiveOpacity = false,
      required this.isActive,
      required this.onTap})
      : super(key: key);

  Widget _buildWidgets() {
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
                  color: isActive
                      ? Color(activeBackground ?? Values.colorPrimary)
                      : Color(inactiveBackground ?? Values.colorDisabled).withOpacity(noInactiveOpacity ? 1 : 0.3)),
              child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                SvgPicture.asset(icon,
                    width: 10,
                    height: 10,
                    color: isActive ? Color(activeColor ?? Values.colorAccent) : Color(inactiveColor ?? Values.colorDisabled).withOpacity(noInactiveOpacity ? 1 : 0.3)),
                Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  SvgPicture.asset(ascended ? "assets/graphics/icons/sort_ascended.svg" : "assets/graphics/icons/sort_descended.svg",
                      width: 12,
                      height: 12,
                      color: isActive ? Color(activeColor ?? Values.colorAccent) : Color(inactiveColor ?? Values.colorDisabled).withOpacity(noInactiveOpacity ? 1 : 0.3)),
                  AutoSizeText(number.toString(),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(activeColor ?? Values.colorAccent), fontSize: 16, fontWeight: FontWeight.w600)),
                ])
              ]))),
      AnimatedOpacity(
          opacity: isActive ? 0 : 1,
          duration: const Duration(milliseconds: 200),
          child: WidgetSwitch(
              icon: icon,
              size: size,
              activeColor: activeColor,
              activeBackground: activeBackground,
              inactiveColor: inactiveColor,
              inactiveBackground: inactiveBackground,
              noInactiveOpacity: noInactiveOpacity,
              isActive: isActive,
              onTap: () {
                onTap();
              })),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
