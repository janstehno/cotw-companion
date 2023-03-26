// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';

class WidgetRichText extends StatelessWidget {
  final String text;
  final Color? color, highlightColor;

  const WidgetRichText({
    Key? key,
    required this.text,
    this.color,
    this.highlightColor,
  }) : super(key: key);

  Widget _buildWidgets() {
    return EasyRichText(text,
        textAlign: TextAlign.start,
        patternList: [
          EasyRichTextPattern(
              targetString: '(\\*)(.*?)(\\*)',
              matchBuilder: (BuildContext context, RegExpMatch? match) {
                return TextSpan(
                    text: match![0]?.replaceAll('*', ''),
                    style: TextStyle(
                      color: highlightColor ?? Interface.primary,
                      fontSize: Interface.s18,
                      fontWeight: FontWeight.w600,
                    ));
              })
        ],
        defaultStyle: TextStyle(
          color: color ?? Interface.dark,
          fontSize: Interface.s18,
          fontWeight: FontWeight.w400,
        ));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
