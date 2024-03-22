import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class WidgetText extends StatelessWidget {
  final String _text;
  final Color _color;
  final TextStyle _style;
  final TextAlign _textAlign;
  final int? _maxLines;
  final bool _autoSize;

  const WidgetText(
    String text, {
    super.key,
    required Color color,
    required TextStyle style,
    TextAlign textAlign = TextAlign.start,
    int? maxLines = 1,
    bool autoSize = true,
  })  : _text = text,
        _color = color,
        _style = style,
        _textAlign = textAlign,
        _maxLines = maxLines,
        _autoSize = autoSize;

  Color get color => _color;

  TextStyle get style => _style.copyWith(color: _color, letterSpacing: 0.8);

  Widget buildAutoSizeText() {
    return AutoSizeText(
      _text,
      minFontSize: 4,
      maxLines: _maxLines,
      textAlign: _textAlign,
      style: style,
    );
  }

  Widget buildText() {
    return Text(
      _text,
      textAlign: _textAlign,
      style: style,
    );
  }

  Widget _buildWidgets() {
    if (_autoSize) return buildAutoSizeText();
    return buildText();
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
