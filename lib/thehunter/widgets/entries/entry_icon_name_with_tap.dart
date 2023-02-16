// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryIconNameWithTap extends StatelessWidget {
  final String text;
  final String icon;
  final double height;
  final int? color;
  final int? background;
  final Function onTap;

  const EntryIconNameWithTap({Key? key, required this.text, this.icon = "", this.height = 90, this.background, this.color, required this.onTap}) : super(key: key);

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
            height: height,
            color: Color(background ?? Values.colorTransparent),
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(children: [
              icon.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: SvgPicture.asset(
                        icon,
                        width: 25,
                        height: 25,
                        color: Color(color ?? Values.colorDark),
                      ))
                  : Container(),
              Expanded(
                  child: AutoSizeText(text,
                      maxLines: 1, style: TextStyle(color: Color(color ?? Values.colorDark), fontSize: Values.fontSize24, fontWeight: FontWeight.w600)))
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
