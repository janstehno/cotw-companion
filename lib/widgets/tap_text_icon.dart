// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetTapTextIcon extends StatelessWidget {
  final String text, icon;
  final Color? color, background;
  final double height, iconSize;
  final bool alignRight;
  final Function onTap;

  const WidgetTapTextIcon({
    Key? key,
    required this.text,
    required this.icon,
    this.color,
    this.background,
    this.height = 80,
    this.iconSize = 35,
    this.alignRight = false,
    required this.onTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
            height: height,
            color: background ?? Colors.transparent,
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
                          width: iconSize,
                          height: iconSize,
                          colorFilter: ColorFilter.mode(
                            color ?? Interface.dark,
                            BlendMode.srcIn,
                          ),
                        ),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(left: alignRight ? 0 : 15, right: alignRight ? 15 : 0),
                          child: AutoSizeText(
                            text,
                            textAlign: alignRight ? TextAlign.end : TextAlign.start,
                            style: Interface.s16w500n(color ?? Interface.dark),
                          ))),
                  alignRight
                      ? SvgPicture.asset(
                          icon,
                          width: iconSize,
                          height: iconSize,
                          colorFilter: ColorFilter.mode(
                            color ?? Interface.dark,
                            BlendMode.srcIn,
                          ),
                        )
                      : const SizedBox.shrink(),
                ])));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
