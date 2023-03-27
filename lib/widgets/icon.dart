// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetIcon extends StatelessWidget {
  final String icon;
  final Color color, background;
  final double size, inactiveOpacity;
  final bool isActive;

  const WidgetIcon({
    Key? key,
    required this.icon,
    required this.color,
    required this.background,
    this.size = 40,
    this.isActive = true,
    this.inactiveOpacity = 0.3,
  }) : super(key: key);

  Widget _buildWidgets() {
    Color clr = isActive ? color : Interface.dark.withOpacity(inactiveOpacity);
    Color bcg = isActive ? background : Interface.disabled.withOpacity(inactiveOpacity);
    return Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bcg,
          borderRadius: BorderRadius.circular(size / 3),
        ),
        child: SvgPicture.asset(
          icon,
          width: size / 2.3,
          height: size / 2.3,
          color: clr,
        ));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
