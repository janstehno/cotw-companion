// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';

class WidgetTitleCustom extends StatelessWidget {
  final String text;
  final double height;
  final int? color;
  final int? background;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Alignment alignment;
  final bool visible;

  const WidgetTitleCustom(
      {Key? key,
      required this.text,
      required this.height,
      this.color,
      this.background,
      this.fontSize,
      this.fontWeight,
      this.alignment = Alignment.centerRight,
      this.visible = true})
      : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: height,
        color: Color(background ?? Values.colorPrimary),
        alignment: alignment,
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: AutoSizeText(
          text,
          maxLines: 1,
          textAlign: TextAlign.start,
          style: TextStyle(color: Color(color ?? Values.colorAccent), fontSize: Values.fontSize30, fontWeight: FontWeight.w600),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return visible ? _buildWidgets() : Container();
  }
}
