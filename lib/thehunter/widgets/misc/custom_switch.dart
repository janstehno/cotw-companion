// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetSwitch extends StatelessWidget {
  final double size;
  final int? activeColor;
  final int? activeBackground;
  final int? inactiveColor;
  final int? inactiveBackground;
  final String text;
  final String? inactiveText;
  final String icon;
  final String? inactiveIcon;
  final bool noInactiveOpacity;
  final bool isActive;
  final bool visible;
  final Function onTap;

  const WidgetSwitch(
      {Key? key,
      this.text = "",
      this.inactiveText,
      this.icon = "",
      this.inactiveIcon,
      this.size = 50,
      this.activeColor,
      this.activeBackground,
      this.inactiveColor,
      this.inactiveBackground,
      this.noInactiveOpacity = false,
      required this.isActive,
      this.visible = true,
      required this.onTap})
      : super(key: key);

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: size,
          width: (icon.isNotEmpty && text.isEmpty) || (icon.isEmpty && text.isEmpty) ? size : null,
          alignment: Alignment.center,
          padding: icon.isNotEmpty && text.isEmpty ? const EdgeInsets.all(0) : const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(size / 4)),
              color:
                  isActive ? Color(activeBackground ?? Values.colorPrimary) : Color(inactiveBackground ?? Values.colorDisabled).withOpacity(noInactiveOpacity ? 1 : 0.3)),
          child: icon.isNotEmpty && text.isEmpty
              ? SvgPicture.asset(
                  isActive ? icon : inactiveIcon ?? icon,
                  width: size / 2.5,
                  height: size / 2.5,
                  color: isActive ? Color(activeColor ?? Values.colorAccent) : Color(inactiveColor ?? Values.colorDark).withOpacity(noInactiveOpacity ? 1 : 0.3),
                )
              : icon.isEmpty && text.isNotEmpty
                  ? AutoSizeText(isActive ? text : inactiveText ?? text,
                      maxLines: 1,
                      style: TextStyle(
                          color: isActive ? Color(activeColor ?? Values.colorAccent) : Color(inactiveColor ?? Values.colorDark).withOpacity(noInactiveOpacity ? 1 : 0.3),
                          fontSize: Values.fontSize18,
                          fontWeight: FontWeight.w600))
                  : Container(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return visible
        ? (icon.isNotEmpty && text.isEmpty) || (icon.isEmpty && text.isNotEmpty) || (icon.isEmpty && text.isEmpty)
            ? _buildWidgets()
            : Container()
        : Container();
  }
}
