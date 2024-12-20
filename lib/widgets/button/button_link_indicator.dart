import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/button/button.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/indicator/indicator.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetButtonLinkIndicator extends WidgetButton {
  final String _text;
  final Color _color;
  final bool _showIcon;

  const WidgetButtonLinkIndicator(
    String text, {
    super.key,
    required Color color,
    required super.onTap,
    bool? showIcon,
  })  : _text = text,
        _color = color,
        _showIcon = showIcon ?? true,
        super(width: 0, background: Interface.transparent);

  @override
  double get buttonHeight => Values.smallTag;

  Widget _buildText() {
    return WidgetText(
      _text.toUpperCase(),
      color: Interface.dark,
      style: Style.normal.s10.w300.copyWith(decoration: TextDecoration.underline),
    );
  }

  Widget _buildIcon() {
    return WidgetIcon.withSize(
      Assets.graphics.icons.link,
      color: Interface.dark,
      size: 10,
    );
  }

  @override
  Widget? buildCenter() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          WidgetIndicator(_color, size: 7),
          const SizedBox(width: 10),
          _buildText(),
          if (_showIcon) const SizedBox(width: 7),
          if (_showIcon) _buildIcon(),
        ],
      ),
    );
  }
}
