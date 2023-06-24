// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetText extends StatelessWidget {
  final String text;
  final Color color, background;
  final double height;
  final Function? onTap;

  const WidgetText({
    Key? key,
    required this.text,
    required this.color,
    this.background = Colors.transparent,
    this.height = 50,
    this.onTap,
  }) : super(key: key);

  const WidgetText.withTap({
    Key? key,
    required this.text,
    required this.color,
    this.background = Colors.transparent,
    this.height = 50,
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
            alignment: Alignment.centerLeft,
            child: AutoSizeText(text,
                maxLines: 1,
                style: TextStyle(
                  color: color,
                  fontSize: Interface.s20,
                  fontWeight: FontWeight.w400,
                ))));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
