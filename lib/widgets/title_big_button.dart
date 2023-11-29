// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:flutter/material.dart';

class WidgetTitleBigButton extends WidgetTitleBig {
  final String icon;
  final Color? buttonColor, buttonBackground;
  final Function onTap;

  const WidgetTitleBigButton({
    super.key,
    required super.primaryText,
    super.secondaryText,
    required this.icon,
    this.buttonColor,
    this.buttonBackground,
    required this.onTap,
  });

  Widget _buildButton() {
    return WidgetButtonIcon(
      icon: icon,
      color: buttonColor,
      background: buttonBackground,
      onTap: () {
        onTap();
      },
    );
  }

  @override
  Widget buildWidgets() {
    return buildTitle(_buildButton());
  }
}
