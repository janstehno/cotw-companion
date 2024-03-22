import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/widgets/parts/stats/parameter.dart';
import 'package:cotwcompanion/widgets/tag/tag.dart';
import 'package:flutter/material.dart';

class WidgetParameterTag extends WidgetParameter {
  final Color _background;

  const WidgetParameterTag({
    super.key,
    required super.text,
    required super.value,
    required Color background,
  }) : _background = background;

  @override
  Widget buildValue() {
    return Container(
      alignment: Alignment.centerRight,
      child: WidgetTag.small(
        value: value,
        color: Interface.alwaysDark,
        background: _background,
      ),
    );
  }
}
