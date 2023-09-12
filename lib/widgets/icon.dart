// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetIcon extends StatelessWidget {
  final String icon;
  final Color color, background;
  final double size;
  final double? iconSize;
  final bool isActive;

  const WidgetIcon({
    Key? key,
    required this.icon,
    required this.color,
    required this.background,
    this.size = 35,
    this.iconSize,
    this.isActive = true,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? background : Interface.disabled.withOpacity(0.3),
          borderRadius: BorderRadius.circular(size / 4),
        ),
        child: SvgPicture.asset(
          icon,
          width: iconSize ?? size / 2.2,
          height: iconSize ?? size / 2.2,
          colorFilter: ColorFilter.mode(
            isActive ? color : Interface.dark.withOpacity(0.3),
            BlendMode.srcIn,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
