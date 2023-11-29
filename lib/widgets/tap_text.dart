// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetTapText extends StatelessWidget {
  final String text;
  final Color? color, background;
  final Function onTap;

  final double height = 70;

  const WidgetTapText({
    Key? key,
    required this.text,
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
          height: height,
          color: background ?? Colors.transparent,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: AutoSizeText(
            text,
            style: Interface.s18w300n(color ?? Interface.dark),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
