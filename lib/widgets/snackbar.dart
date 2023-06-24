// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/button.dart';
import 'package:flutter/material.dart';

class WidgetSnackBar extends StatelessWidget {
  final String text, icon;
  final Color? color, background, iconColor;
  final Function? onTap;

  final double buttonSize = 50;

  const WidgetSnackBar({
    Key? key,
    required this.text,
    this.icon = "",
    this.color,
    this.background = Colors.transparent,
    this.iconColor,
    this.onTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: 75,
        color: background,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.only(right: icon.isNotEmpty ? 30 : 0),
                  child: AutoSizeText(
                    text,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: color ?? Interface.dark,
                      fontSize: Interface.s14,
                      fontWeight: FontWeight.w400,
                    ),
                  ))),
          icon.isEmpty
              ? Container()
              : WidgetButton.withIcon(
                  icon: icon,
                  color: iconColor ?? Interface.dark,
                  background: Colors.transparent,
                  buttonSize: buttonSize,
                  onTap: () {
                    onTap!();
                  },
                )
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
