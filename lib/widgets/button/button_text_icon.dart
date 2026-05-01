import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/button/button.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetButtonTextIcon extends WidgetButton {
  final String? _text;
  final String? _icon;
  final Color? _color;
  final TextStyle? _textStyle;
  final double? _iconSize;
  final double? _maxWidth;

  const WidgetButtonTextIcon(
    String? text, {
    super.key,
    String? icon,
    Color? color,
    TextStyle? textStyle,
    double? iconSize,
    double? maxWidth,
    super.background,
    required super.onTap,
  })  : _text = text,
        _icon = icon,
        _color = color,
        _textStyle = textStyle,
        _iconSize = iconSize,
        _maxWidth = maxWidth,
        super(width: 0);

  String get text => _text ?? "";

  String get icon => _icon ?? Assets.graphics.icons.link;

  Color get color => _color ?? Interface.alwaysDark;

  TextStyle get textStyle => _textStyle ?? Style.normal.s12.w500;

  double get iconSize => _iconSize ?? 15;

  Widget _buildText() {
    return WidgetText(
      text.toUpperCase(),
      color: color,
      style: textStyle,
      textAlign: TextAlign.end,
      autoSize: true,
      maxLines: 1,
    );
  }

  Widget _buildIcon() {
    return WidgetIcon.withSize(
      icon,
      color: color,
      size: iconSize,
    );
  }

  @override
  Widget? buildCenter() {
    return WidgetPadding.fromLTRB(
      10,
      0,
      10,
      0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_text != null) _maxWidth == null ? _buildText() : Expanded(child: _buildText()),
          if (_icon != null) const SizedBox(width: 5),
          if (_icon != null) _buildIcon(),
        ],
      ),
    );
  }
}
