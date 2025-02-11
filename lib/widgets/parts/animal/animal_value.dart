import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/widgets/tag/tag.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetAnimalValue extends StatelessWidget {
  final String _icon, _value;
  final Color _color, _background;

  const WidgetAnimalValue({
    super.key,
    required String icon,
    required String value,
    required Color color,
    required Color background,
  })  : _icon = icon,
        _value = value,
        _color = color,
        _background = background;

  Widget _buildIcon() {
    return WidgetTag.small(
      icon: _icon,
      color: _color,
      background: _background,
    );
  }

  Widget buildRight() {
    return WidgetText(
      _value,
      color: Interface.dark,
      style: Style.normal.s16.w300,
    );
  }

  Widget _buildWidgets() {
    return Row(
      spacing: 15,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildIcon(),
        Expanded(child: buildRight()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
