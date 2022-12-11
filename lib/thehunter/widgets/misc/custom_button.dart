// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetButton extends StatelessWidget {
  final double size;
  final String text;
  final String icon;
  final int? color;
  final int? background;
  final Function onTap;

  const WidgetButton({Key? key, this.size = 50, this.text = "", this.icon = "", this.color, required this.background, required this.onTap}) : super(key: key);

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          height: size,
          width: (icon.isNotEmpty && text.isEmpty) || (icon.isEmpty && text.isEmpty) ? size : null,
          alignment: Alignment.center,
          padding: icon.isNotEmpty && text.isEmpty ? const EdgeInsets.all(0) : const EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(size / 4)), color: Color(background ?? Values.colorPrimary)),
          child: icon.isNotEmpty && text.isEmpty
              ? SvgPicture.asset(
                  icon,
                  width: size / 2.5,
                  height: size / 2.5,
                  color: Color(color ?? Values.colorAccent),
                )
              : icon.isEmpty && text.isNotEmpty
                  ? AutoSizeText(text, maxLines: 1, style: TextStyle(color: Color(color ?? Values.colorAccent), fontSize: Values.fontSize18, fontWeight: FontWeight.w600))
                  : Container(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return (icon.isNotEmpty && text.isEmpty) || (icon.isEmpty && text.isNotEmpty) || (icon.isEmpty && text.isEmpty) ? _buildWidgets() : Container();
  }
}
