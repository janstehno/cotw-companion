// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:flutter/material.dart';

class WidgetTitleBigButton extends WidgetTitleBig {
  final String icon;
  final Color? color, background;
  final Function onTap;

  const WidgetTitleBigButton({
    super.key,
    required super.primaryText,
    super.secondaryText,
    required this.icon,
    this.color,
    this.background,
    required this.onTap,
  });

  Widget _buildButton() {
    return WidgetButtonIcon(
      icon: icon,
      color: color,
      background: background,
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
