// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class WidgetAppBar extends StatelessWidget {
  final String text;
  final double height;
  final int maxLines;
  final BuildContext context;

  final double _backWidth = 80;

  const WidgetAppBar({
    Key? key,
    required this.text,
    this.height = 90,
    this.maxLines = 1,
    required this.context,
  }) : super(key: key);

  Widget _buildBackButton() {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
            width: _backWidth,
            height: height,
            color: Interface.primary,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: SvgPicture.asset(
              "assets/graphics/icons/back.svg",
              fit: BoxFit.fitWidth,
              colorFilter: ColorFilter.mode(
                Interface.accent,
                BlendMode.srcIn,
              ),
            )));
  }

  Widget _buildText() {
    return Container(
        height: height,
        alignment: Alignment.centerRight,
        color: Interface.primary,
        padding: const EdgeInsets.only(right: 30),
        child: AutoSizeText(
          text.toUpperCase(),
          maxLines: maxLines,
          textAlign: TextAlign.right,
          style: Interface.s28w600c(Interface.accent),
        ));
  }

  Widget _buildWidgets() {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      _buildBackButton(),
      Expanded(child: _buildText()),
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
