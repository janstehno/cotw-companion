// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_switch.dart';
import 'package:flutter/material.dart';

class WidgetTitleWithDualSwitch extends StatelessWidget {
  final String text;
  final String leftButtonText;
  final String rightButtonText;
  final double size;
  final int? color;
  final int? background;
  final int? activeButtonColor;
  final int? activeButtonBackground;
  final bool isActive;
  final bool noInactiveOpacity;
  final bool oneLine;
  final Function onTap;

  const WidgetTitleWithDualSwitch(
      {Key? key,
      required this.text,
      required this.leftButtonText,
      required this.rightButtonText,
      this.size = 50,
      this.color,
      this.background,
      this.activeButtonColor,
      this.activeButtonBackground,
      required this.isActive,
      this.noInactiveOpacity = false,
      this.oneLine = false,
      required this.onTap})
      : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: 75,
        color: Color(background ?? Values.colorTransparent),
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              child: Container(
                  padding: const EdgeInsets.only(right: 30),
                  child: AutoSizeText(
                    text.toUpperCase(),
                    maxLines: oneLine ? 1 : 2,
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Color(color ?? Values.colorDark), fontSize: Values.fontSize24, fontWeight: FontWeight.w800, fontFamily: 'Title'),
                  ))),
          WidgetSwitch(
              text: leftButtonText,
              size: size,
              activeColor: activeButtonColor,
              activeBackground: activeButtonBackground,
              noInactiveOpacity: noInactiveOpacity,
              isActive: !isActive,
              onTap: () {
                if (isActive) onTap();
              }),
          const SizedBox(width: 15),
          WidgetSwitch(
              text: rightButtonText,
              size: size,
              activeColor: activeButtonColor,
              activeBackground: activeButtonBackground,
              noInactiveOpacity: noInactiveOpacity,
              isActive: isActive,
              onTap: () {
                if (!isActive) onTap();
              })
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
