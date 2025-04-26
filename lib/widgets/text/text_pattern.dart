import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WidgetTextPattern extends StatelessWidget {
  final String _text;
  final Color? _color;
  final TextAlign? _textAlign;
  final TextStyle? _normalStyle;
  final TextStyle? _patternStyle;

  const WidgetTextPattern(
    String text, {
    super.key,
    Color? color,
    TextAlign? textAlign,
    TextStyle? normalStyle,
    TextStyle? patternStyle,
  })  : _text = text,
        _color = color,
        _textAlign = textAlign,
        _normalStyle = normalStyle,
        _patternStyle = patternStyle;

  EasyRichTextPattern _patternImportant() {
    return EasyRichTextPattern(
      targetString: "(\\*)(.*?)(\\*)",
      matchBuilder: (BuildContext context, RegExpMatch? match) {
        return TextSpan(
          text: match?[0]?.replaceAll("*", ""),
          style: (_patternStyle ?? Style.normal.s16.w500).copyWith(color: Interface.primary),
        );
      },
    );
  }

  EasyRichTextPattern _patternLink() {
    return EasyRichTextPattern(
      targetString: "(\\|)(.*?)(\\|)",
      matchBuilder: (BuildContext context, RegExpMatch? match) {
        String? text = match?[0]?.replaceAll("|", "") ?? "";
        return TextSpan(
          text: text,
          style: (_patternStyle ?? Style.normal.s16.w500).copyWith(
            color: _color ?? Interface.dark,
            decoration: TextDecoration.underline,
            decorationColor: _color ?? Interface.dark,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Utils.redirectTo(text);
            },
        );
      },
    );
  }

  Widget _buildWidgets() {
    return EasyRichText(
      _text,
      selectable: false,
      textAlign: _textAlign ?? TextAlign.start,
      defaultStyle: (_normalStyle ?? Style.normal.s16.w300).copyWith(color: _color ?? Interface.dark),
      patternList: [
        _patternImportant(),
        _patternLink(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
