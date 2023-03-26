// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetTag extends StatelessWidget {
  final String text, icon;
  final double height, iconSize, fontSize;
  final Color color, background;
  final FontWeight fontWeight;
  final EdgeInsets margin;
  final bool isVisible;

  const WidgetTag.big({
    Key? key,
    this.text = "",
    this.icon = "",
    this.height = 40,
    this.iconSize = 16,
    this.fontSize = 24,
    this.fontWeight = FontWeight.w600,
    this.margin = const EdgeInsets.all(0),
    required this.color,
    required this.background,
    this.isVisible = true,
  }) : super(key: key);

  const WidgetTag.medium({
    Key? key,
    this.text = "",
    this.icon = "",
    this.height = 30,
    this.iconSize = 16,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w500,
    this.margin = const EdgeInsets.all(0),
    required this.color,
    required this.background,
    this.isVisible = true,
  }) : super(key: key);

  const WidgetTag.small({
    Key? key,
    this.text = "",
    this.icon = "",
    this.height = 25,
    this.iconSize = 16,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w400,
    this.margin = const EdgeInsets.all(0),
    required this.color,
    required this.background,
    this.isVisible = true,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: height,
        margin: margin,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(height / 4)),
          color: background,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          icon.isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(right: text.isNotEmpty ? 7 : 0),
                  child: SvgPicture.asset(
                    icon,
                    width: iconSize,
                    height: iconSize,
                    color: color,
                  ))
              : Container(),
          text.isNotEmpty
              ? AutoSizeText(text,
                  maxLines: 1,
                  style: TextStyle(
                    color: color,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ))
              : Container()
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return isVisible && (icon.isNotEmpty || text.isNotEmpty) ? _buildWidgets() : Container();
  }
}
