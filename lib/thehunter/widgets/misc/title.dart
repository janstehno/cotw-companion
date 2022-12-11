// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';

class WidgetTitle extends StatelessWidget {
  final String text;
  final int fontSize;
  final Alignment alignment;
  final bool visible;

  const WidgetTitle.sub({Key? key, required this.text, this.fontSize = 24, this.alignment = Alignment.centerLeft, this.visible = true}) : super(key: key);

  const WidgetTitle.detail({Key? key, required this.text, this.fontSize = 20, this.alignment = Alignment.centerLeft, this.visible = true}) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: 75,
        color: fontSize == 24 ? Color(Values.colorContentSubTitleBackground) : Color(Values.colorContentSubSubTitleBackground),
        alignment: alignment,
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: AutoSizeText(
          text,
          maxLines: 1,
          textAlign: TextAlign.start,
          style: TextStyle(color: Color(Values.colorContentSubTitle), fontSize: fontSize == 24 ? Values.fontSize24 : Values.fontSize20, fontWeight: FontWeight.w600),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return visible ? _buildWidgets() : Container();
  }
}
