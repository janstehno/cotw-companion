import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/widgets/icon/icon_background.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetAnimalTrophyScore extends StatelessWidget {
  final String _icon, _value;
  final Color _color, _background;
  final bool _valueKnown, _alignRight;

  const WidgetAnimalTrophyScore({
    super.key,
    required String icon,
    required String value,
    required Color color,
    required Color background,
    bool valueKnown = true,
    bool alignRight = false,
  })  : _icon = icon,
        _value = value,
        _color = color,
        _background = background,
        _valueKnown = valueKnown,
        _alignRight = alignRight;

  Widget _buildIcon() {
    return WidgetIconBackground(
      _icon,
      color: _color,
      background: _background,
    );
  }

  Widget _buildText() {
    return Container(
      margin: EdgeInsets.only(
        left: _alignRight ? 0 : 15,
        right: _alignRight ? 15 : 0,
      ),
      child: WidgetText(
        _valueKnown ? _value : "?",
        color: Interface.dark,
        style: Style.normal.s18.w500,
      ),
    );
  }

  Widget _buildWidgets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (!_alignRight) _buildIcon(),
        _buildText(),
        if (_alignRight) _buildIcon(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
