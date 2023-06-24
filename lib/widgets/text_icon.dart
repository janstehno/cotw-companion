// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetTextIcon extends StatelessWidget {
  final String icon, text;
  final Color? color, background;
  final double height;
  final double? iconSize;
  final Function? onTap;

  const WidgetTextIcon({
    Key? key,
    required this.text,
    required this.icon,
    this.color,
    this.background = Colors.transparent,
    this.height = 50,
    this.iconSize,
    this.onTap,
  }) : super(key: key);

  const WidgetTextIcon.withTap({
    Key? key,
    required this.text,
    required this.icon,
    this.color,
    this.background = Colors.transparent,
    this.height = 50,
    this.iconSize,
    required this.onTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          onTap!();
        },
        child: Container(
            height: height,
            color: background,
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(children: [
              Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: SvgPicture.asset(
                    icon,
                    width: iconSize ?? height / 2.5,
                    height: iconSize ?? height / 2.5,
                    color: color ?? Interface.dark,
                  )),
              Expanded(
                  child: AutoSizeText(text,
                      maxLines: 1,
                      style: TextStyle(
                        color: color ?? Interface.dark,
                        fontSize: Interface.s20,
                        fontWeight: FontWeight.w600,
                      )))
            ])));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
