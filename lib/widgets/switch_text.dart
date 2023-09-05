// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetSwitchText extends StatelessWidget {
  final String text;
  final Color? color, background, activeColor, activeBackground;
  final double? buttonHeight, buttonWidth;
  final Function onTap;
  final bool isActive, disabled;

  const WidgetSwitchText({
    Key? key,
    required this.text,
    this.buttonHeight,
    this.buttonWidth,
    this.color,
    this.background,
    this.activeColor,
    this.activeBackground,
    required this.onTap,
    required this.isActive,
    this.disabled = false,
  }) : super(key: key);

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: disabled
            ? () {}
            : () {
                onTap();
              },
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: buttonHeight,
            width: buttonWidth,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: buttonHeight == buttonWidth ? 0 : 10, right: buttonHeight == buttonWidth ? 0 : 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              color: isActive ? activeBackground ?? Interface.primary : background ?? Interface.disabled.withOpacity(0.3),
            ),
            child: AutoSizeText(
              text,
              style: Interface.s18w500n(isActive ? activeColor ?? Interface.accent : color ?? Interface.disabled),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
