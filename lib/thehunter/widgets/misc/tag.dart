// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetTag extends StatelessWidget {
  final String text;
  final String icon;
  final double size;
  final EdgeInsets margin;
  final int fontSize;
  final FontWeight fontWeight;
  final int? color;
  final int? background;
  final bool visible;
  final double height;

  const WidgetTag.big(
      {Key? key,
      this.text = "",
      this.icon = "",
      this.size = 16,
      this.height = 40,
      this.margin = const EdgeInsets.all(0),
      this.fontSize = 24,
      this.fontWeight = FontWeight.w600,
      this.color,
      this.background,
      this.visible = true})
      : super(key: key);

  const WidgetTag.medium(
      {Key? key,
      this.text = "",
      this.icon = "",
      this.size = 16,
      this.height = 30,
      this.margin = const EdgeInsets.all(0),
      this.fontSize = 18,
      this.fontWeight = FontWeight.w500,
      this.color,
      this.background,
      this.visible = true})
      : super(key: key);

  const WidgetTag.small(
      {Key? key,
      this.text = "",
      this.icon = "",
      this.size = 16,
      this.height = 25,
      this.margin = const EdgeInsets.all(0),
      this.fontSize = 12,
      this.fontWeight = FontWeight.w400,
      this.color,
      this.background,
      this.visible = true})
      : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: height,
        margin: margin,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(height / 4)), color: Color(background ?? Values.colorTag)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          icon.isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(right: text.isNotEmpty ? 7 : 0),
                  child: SvgPicture.asset(icon, width: size, height: size, color: Color(color ?? Values.colorDark)))
              : Container(),
          text.isNotEmpty
              ? AutoSizeText(text,
                  maxLines: 1,
                  style: TextStyle(
                      color: Color(color ?? Values.colorDark),
                      fontSize: fontSize == 24
                          ? Values.fontSize24
                          : fontSize == 18
                              ? Values.fontSize18
                              : Values.fontSize14,
                      fontWeight: fontWeight))
              : Container()
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return visible & (icon.isNotEmpty || text.isNotEmpty) ? _buildWidgets() : Container();
  }
}
