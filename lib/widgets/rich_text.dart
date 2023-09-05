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
      selectable: false,
      textAlign: TextAlign.start,
      defaultStyle: Interface.s16w300n(Interface.dark),
      patternList: [
        EasyRichTextPattern(
            targetString: '(\\*)(.*?)(\\*)',
            style: Interface.s16w500n(Interface.primary),
            matchBuilder: (BuildContext context, RegExpMatch? match) {
              return TextSpan(
                text: match![0]?.replaceAll('*', ''),
                style: Interface.s16w500n(Interface.primary),
              );
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
