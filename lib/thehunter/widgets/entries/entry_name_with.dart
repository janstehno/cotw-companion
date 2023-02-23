// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_button.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_switch.dart';
import 'package:flutter/material.dart';

class EntryName extends StatelessWidget {
  final String text;
  final String subText;
  final String buttonText;
  final String? buttonInactiveText;
  final String buttonIcon;
  final String? buttonInactiveIcon;
  final double size;
  final int? color;
  final int? subColor;
  final int? background;
  final int? buttonActiveColor;
  final int? buttonInactiveColor;
  final int? buttonActiveBackground;
  final int? buttonInactiveBackground;
  final bool withSwitch;
  final bool oneLine;
  final bool noInactiveOpacity;
  final bool isTitle;
  final bool isActive;
  final bool visible;
  final Function onTap;

  const EntryName.withSwitch(
      {Key? key,
      required this.text,
      this.subText = "",
      this.buttonText = "",
      this.buttonInactiveText,
      this.buttonIcon = "",
      this.buttonInactiveIcon,
      this.size = 50,
      this.color,
      this.subColor,
      this.background,
      this.buttonActiveColor,
      this.buttonInactiveColor,
      this.buttonActiveBackground,
      this.buttonInactiveBackground,
      this.withSwitch = true,
      this.oneLine = false,
      this.noInactiveOpacity = false,
      this.visible = true,
      this.isTitle = false,
      required this.isActive,
      required this.onTap})
      : super(key: key);

  const EntryName.withTap(
      {Key? key,
      required this.text,
      this.subText = "",
      this.buttonText = "",
      this.buttonInactiveText,
      this.buttonIcon = "",
      this.buttonInactiveIcon,
      this.size = 50,
      this.color,
      this.subColor,
      this.background,
      this.buttonActiveColor,
      this.buttonInactiveColor,
      this.buttonActiveBackground,
      this.buttonInactiveBackground,
      this.withSwitch = false,
      this.oneLine = false,
      this.noInactiveOpacity = false,
      this.visible = true,
      this.isTitle = false,
      this.isActive = true,
      required this.onTap})
      : super(key: key);

  Widget _buildWidgets() {
    return Container(
        color: Color(background ?? Values.colorTransparent),
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              child: Container(
                  padding: const EdgeInsets.only(right: 30),
                  child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                    AutoSizeText(isTitle ? text.toUpperCase() : text,
                        maxLines: oneLine ? 1 : 2,
                        textAlign: TextAlign.start,
                        style: isTitle
                            ? TextStyle(color: Color(color ?? Values.colorDark), fontSize: Values.fontSize24, fontWeight: FontWeight.w800, fontFamily: 'Title')
                            : TextStyle(color: Color(color ?? Values.colorDark), fontSize: Values.fontSize24, fontWeight: FontWeight.w600)),
                    subText.isNotEmpty
                        ? Container(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(subText,
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Color(subColor ?? Values.colorDark), fontSize: Values.fontSize14, fontWeight: FontWeight.w600)))
                        : Container()
                  ]))),
          withSwitch
              ? WidgetSwitch(
                  size: size,
                  activeColor: buttonActiveColor,
                  activeBackground: buttonActiveBackground,
                  inactiveColor: buttonInactiveColor,
                  inactiveBackground: buttonInactiveBackground,
                  text: buttonText,
                  inactiveText: buttonInactiveText,
                  icon: buttonIcon,
                  inactiveIcon: buttonInactiveIcon,
                  noInactiveOpacity: noInactiveOpacity,
                  isActive: isActive,
                  onTap: () {
                    onTap();
                  })
              : WidgetButton(
                  size: size,
                  text: buttonText,
                  icon: buttonIcon,
                  color: isActive ? buttonActiveColor : buttonInactiveColor,
                  background: isActive ? buttonActiveBackground : buttonInactiveBackground,
                  onTap: () {
                    onTap();
                  })
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return visible ? _buildWidgets() : Container();
  }
}
