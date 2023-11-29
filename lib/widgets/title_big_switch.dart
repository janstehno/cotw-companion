// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/widgets/switch_icon.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:flutter/material.dart';

class WidgetTitleBigSwitch extends WidgetTitleBig {
  final String icon, activeIcon;
  final Color? color, background, activeColor, activeBackground;
  final bool isActive;
  final Function onTap;

  static const double height = WidgetTitleBig.height;

  const WidgetTitleBigSwitch({
    super.key,
    required super.primaryText,
    super.secondaryText = "",
    super.maxLines = 1,
    super.upperCase = true,
    this.icon = "",
    this.activeIcon = "",
    this.color,
    this.background,
    this.activeColor,
    this.activeBackground,
    this.isActive = false,
    required this.onTap,
  });

  WidgetSwitchIcon buildSwitch() {
    return WidgetSwitchIcon(
      icon: icon,
      activeIcon: activeIcon,
      color: color,
      background: background,
      activeColor: activeColor,
      activeBackground: activeBackground,
      isActive: isActive,
      onTap: () {
        onTap();
      },
    );
  }

  @override
  Widget buildWidgets() {
    return buildTitle(buildSwitch());
  }
}
