// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';

class WidgetRichText extends StatelessWidget {
  final String text;

  const WidgetRichText({
    Key? key,
    required this.text,
  }) : super(key: key);

  Widget _buildWidgets() {
    return EasyRichText(
      text,
      textAlign: TextAlign.start,
      patternList: [
        EasyRichTextPattern(
            targetString: '(\\*)(.*?)(\\*)',
            matchBuilder: (BuildContext context, RegExpMatch? match) {
              return TextSpan(
                text: match![0]?.replaceAll('*', ''),
                style: Interface.s16w500n(Interface.primary),
              );
            })
      ],
      defaultStyle: Interface.s16w300n(Interface.dark),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
