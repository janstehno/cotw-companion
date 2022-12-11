// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';

class WidgetRichText extends StatelessWidget {
  final String? text;
  final int? color;
  final int? hightlightColor;
  final TextAlign? textAlign;
  final bool visible;

  const WidgetRichText({Key? key, required this.text, this.color, this.hightlightColor, this.textAlign, this.visible = true}) : super(key: key);

  Widget _buildWidgets() {
    return EasyRichText(text ?? "",
        textAlign: textAlign ?? TextAlign.start,
        patternList: [
          EasyRichTextPattern(
              targetString: '(\\*)(.*?)(\\*)',
              matchBuilder: (BuildContext context, RegExpMatch? match) {
                return TextSpan(
                    text: match![0]?.replaceAll('*', ''),
                    style: TextStyle(color: Color(hightlightColor ?? Values.colorPrimary), fontSize: Values.fontSize18, fontWeight: FontWeight.w600));
              })
        ],
        defaultStyle: TextStyle(color: Color(color ?? Values.colorDark), fontSize: Values.fontSize18, fontWeight: FontWeight.w400));
  }

  @override
  Widget build(BuildContext context) {
    return visible ? _buildWidgets() : Container();
  }
}
