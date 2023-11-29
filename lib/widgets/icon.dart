// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetIcon extends StatelessWidget {
  final String icon;
  final double size;
  final Color color, background;
  final bool isActive;

  const WidgetIcon({
    Key? key,
    required this.icon,
    this.size = 35,
    required this.color,
    required this.background,
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
          width: size / 2,
          height: size / 2,
          colorFilter: ColorFilter.mode(
            isActive ? color : Interface.dark.withOpacity(0.3),
            BlendMode.srcIn,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
