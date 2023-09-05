// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/icon.dart';
import 'package:flutter/material.dart';

class WidgetTrophyScore extends StatelessWidget {
  final String text, icon;
  final Color color, background;
  final EdgeInsets margin;
  final bool valueKnown, alignRight;

  const WidgetTrophyScore({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
    required this.background,
    this.valueKnown = true,
    this.alignRight = false,
    this.margin = const EdgeInsets.all(0),
  }) : super(key: key);

  Widget _buildTrophyScore() {
    if (alignRight) {
      return Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
        _buildText(5, 15),
        _buildIcon(),
      ]);
    } else {
      return Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
        _buildIcon(),
        _buildText(15, 5),
      ]);
    }
  }

  Widget _buildText(double left, double right) {
    return Padding(
        padding: EdgeInsets.only(left: left, right: right),
        child: AutoSizeText(
          valueKnown ? text : "?",
          style: Interface.s18w500n(Interface.dark),
        ));
  }

  Widget _buildIcon() {
    return WidgetIcon(
      icon: icon,
      color: color,
      background: background,
      iconSize: 15,
      size: 30,
    );
  }

  Widget _buildWidgets() {
    return Container(margin: margin, child: _buildTrophyScore());
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
