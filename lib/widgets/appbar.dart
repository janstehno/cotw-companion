// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/button.dart';
import 'package:flutter/material.dart';

class WidgetAppBar extends StatelessWidget {
  final String text;
  final int maxLines;
  final double? height, fontSize;
  final FontWeight? fontWeight;
  final Alignment? alignment;
  final Color? color, background;
  final Widget? child;
  final EdgeInsets padding;
  final BuildContext context;

  const WidgetAppBar({
    Key? key,
    required this.text,
    this.maxLines = 2,
    this.height = 90,
    this.fontSize = 30,
    this.fontWeight = FontWeight.w800,
    this.alignment = Alignment.centerRight,
    this.color,
    this.background,
    this.child,
    this.padding = const EdgeInsets.only(right: 30),
    required this.context,
  }) : super(key: key);

  Widget _buildBackButton() {
    return AnimatedContainer(
        height: height,
        width: 70,
        duration: const Duration(milliseconds: 200),
        color: background ?? Interface.primary,
        child: WidgetButton.withIcon(
          icon: "assets/graphics/icons/back.svg",
          color: color ?? Interface.accent,
          background: Colors.transparent,
          onTap: () {
            Navigator.pop(context);
          },
        ));
  }

  Widget _buildWidgets() {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      _buildBackButton(),
      Expanded(
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: height,
              color: background ?? Interface.primary,
              alignment: alignment,
              padding: padding,
              child: child ??
                  AutoSizeText(
                    text.toUpperCase(),
                    maxLines: maxLines,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: color ?? Interface.accent,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      fontFamily: 'Title',
                    ),
                  )))
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
