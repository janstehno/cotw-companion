// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetButtonText extends StatelessWidget {
  final String text;
  final Color? color, background;
  final double buttonHeight;
  final double? buttonWidth;
  final Function onTap;

  const WidgetButtonText({
    Key? key,
    required this.text,
    required this.buttonHeight,
    this.buttonWidth,
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
            width: buttonWidth,
            height: buttonHeight,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              color: background ?? Interface.primary,
            ),
            child: AutoSizeText(
              text,
              style: buttonHeight <= 25
                  ? Interface.s14w500n(color ?? Interface.accent)
                  : buttonHeight <= 35
                      ? Interface.s16w500n(color ?? Interface.accent)
                      : Interface.s18w500n(color ?? Interface.accent),
            )));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
