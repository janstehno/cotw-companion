// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetButtonIcon extends StatelessWidget {
  final String icon;
  final Color? color, background;
  final double buttonSize;
  final double? iconSize;
  final Function onTap;

  const WidgetButtonIcon({
    Key? key,
    this.icon = "",
    this.buttonSize = 35,
    this.iconSize,
    this.color,
    this.background,
    required this.onTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
            width: buttonSize,
            height: buttonSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(buttonSize / 4)),
              color: background ?? Interface.primary,
            ),
            child: icon.isNotEmpty
                ? SvgPicture.asset(
                    icon,
                    width: iconSize ?? buttonSize / 2.5,
                    height: iconSize ?? buttonSize / 2.5,
                    colorFilter: ColorFilter.mode(
                      color ?? Interface.accent,
                      BlendMode.srcIn,
                    ),
                  )
                : Container()));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
