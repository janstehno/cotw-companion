// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryIconName extends StatelessWidget {
  final String text;
  final String icon;
  final double height;
  final int? color;
  final int? background;

  const EntryIconName({Key? key, required this.text, this.icon = "", this.height = 50, this.background, this.color}) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: height,
        color: Color(background ?? Values.colorTransparent),
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(children: [
          icon.isNotEmpty
              ? Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: SvgPicture.asset(
                    icon,
                    width: 20,
                    height: 20,
                    color: Color(color ?? Values.colorDark),
                  ))
              : Container(),
          Expanded(
              child: AutoSizeText(text, maxLines: 1, style: TextStyle(color: Color(color ?? Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w600)))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
