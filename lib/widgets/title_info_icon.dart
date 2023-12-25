// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetTitleInfoIcon extends StatelessWidget {
  final String icon, text;
  final Color? color, background;
  final bool alignRight;

  final double height = 60;

  final double _iconSize = 17.5;

  const WidgetTitleInfoIcon({
    Key? key,
    required this.icon,
    required this.text,
    this.color,
    this.background,
    this.alignRight = false,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: height,
        color: background ?? Interface.title,
        alignment: alignRight ? Alignment.centerRight : Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: alignRight ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              alignRight
                  ? const SizedBox.shrink()
                  : SvgPicture.asset(
                      icon,
                      width: _iconSize,
                      height: _iconSize,
                      colorFilter: ColorFilter.mode(
                        color ?? Interface.dark,
                        BlendMode.srcIn,
                      ),
                    ),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: alignRight ? 0 : 15, right: alignRight ? 15 : 0),
                      child: AutoSizeText(
                        text.toUpperCase(),
                        style: Interface.s16w600c(color ?? Interface.dark),
                      ))),
              alignRight
                  ? SvgPicture.asset(
                      icon,
                      width: _iconSize,
                      height: _iconSize,
                      colorFilter: ColorFilter.mode(
                        color ?? Interface.dark,
                        BlendMode.srcIn,
                      ),
                    )
                  : const SizedBox.shrink(),
            ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
