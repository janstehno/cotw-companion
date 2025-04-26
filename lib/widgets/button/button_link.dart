import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/button/button.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetButtonLink extends WidgetButton {
  final String _text;
  final Color? _color;
  final bool _showIcon;
  final bool _small;

  const WidgetButtonLink(
    String text, {
    super.key,
    Color? color,
    super.background,
    required super.onTap,
    bool? showIcon,
    bool? small,
  })  : _text = text,
        _color = color,
        _showIcon = showIcon ?? true,
        _small = small ?? true,
        super(width: 0);

  Color get color => _color ?? Interface.alwaysDark;

  @override
  double get buttonHeight => _small ? Values.smallTag : Values.tapSize;

  Widget _buildText() {
    return WidgetText(
      _text.toUpperCase(),
      color: color,
      style: Style.normal.s10.w500,
    );
  }

  Widget _buildIcon() {
    return WidgetIcon.withSize(
      Assets.graphics.icons.link,
      color: color,
      size: 10,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildText(),
          if (_showIcon) const SizedBox(width: 7),
          if (_showIcon) _buildIcon(),
        ],
      ),
    );
  }
}
