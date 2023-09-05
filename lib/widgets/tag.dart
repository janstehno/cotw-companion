// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetTag extends StatelessWidget {
  final String text, icon;
  final double height, iconSize;
  final Color color, background;
  final EdgeInsets margin;
  final bool isVisible;

  const WidgetTag.big({
    Key? key,
    this.text = "",
    this.icon = "",
    this.height = 40,
    this.iconSize = 16,
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
    this.margin = const EdgeInsets.all(0),
    required this.color,
    required this.background,
    this.isVisible = true,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: height,
        width: text.isEmpty ? height : null,
        margin: margin,
        alignment: Alignment.center,
        padding: text.isEmpty ? const EdgeInsets.all(0) : const EdgeInsets.only(left: 10, right: 10),
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
                    colorFilter: ColorFilter.mode(
                      color,
                      BlendMode.srcIn,
                    ),
                  ))
              : Container(),
          text.isNotEmpty
              ? AutoSizeText(
                  text,
                  maxLines: 1,
                  style: height <= 25
                      ? Interface.s12w500n(color)
                      : height <= 30
                          ? Interface.s14w500n(color)
                          : Interface.s16w500n(color),
                )
              : Container()
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return isVisible && (icon.isNotEmpty || text.isNotEmpty) ? _buildWidgets() : Container();
  }
}
