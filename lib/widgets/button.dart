// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetButton extends StatelessWidget {
  final String text, icon;
  final Color color, background;
  final double buttonSize;
  final Function onTap;

  const WidgetButton({
    Key? key,
    this.text = "",
    this.icon = "",
    this.buttonSize = 40,
    this.color = Colors.transparent,
    required this.background,
    required this.onTap,
  }) : super(key: key);

  const WidgetButton.withText({
    Key? key,
    required this.text,
    this.icon = "",
    this.buttonSize = 40,
    required this.color,
    required this.background,
    required this.onTap,
  }) : super(key: key);

  const WidgetButton.withIcon({
    Key? key,
    this.text = "",
    required this.icon,
    this.buttonSize = 40,
    required this.color,
    required this.background,
    required this.onTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          height: buttonSize,
          width: (icon.isNotEmpty && text.isEmpty) || (icon.isEmpty && text.isEmpty) ? buttonSize : null,
          alignment: Alignment.center,
          padding: icon.isNotEmpty && text.isEmpty ? const EdgeInsets.all(0) : const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(buttonSize / 4)),
            color: background,
          ),
          child: icon.isNotEmpty && text.isEmpty
              ? SvgPicture.asset(
                  icon,
                  width: buttonSize / 2.5,
                  height: buttonSize / 2.5,
                  color: color,
                )
              : icon.isEmpty && text.isNotEmpty
                  ? AutoSizeText(text,
                      maxLines: 1,
                      style: TextStyle(
                        color: color,
                        fontSize: Interface.s18,
                        fontWeight: FontWeight.w600,
                      ))
                  : Container(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return (icon.isNotEmpty && text.isEmpty) || (icon.isEmpty && text.isNotEmpty) || (icon.isEmpty && text.isEmpty) ? _buildWidgets() : Container();
  }
}
