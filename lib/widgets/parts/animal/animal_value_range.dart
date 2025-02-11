import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/parts/animal/animal_value.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetAnimalValueRange extends WidgetAnimalValue {
  final String _value, _secondValue;

  const WidgetAnimalValueRange({
    super.key,
    required super.icon,
    required super.value,
    required String secondValue,
    required super.color,
    required super.background,
  })  : _value = value,
        _secondValue = secondValue;

  Widget _buildMarker(String icon) {
    return WidgetIcon.withSize(icon, color: Interface.disabledForeground, size: Values.dotSize);
  }

  Widget _buildText(String value) {
    return WidgetText(value, color: Interface.dark, style: Style.normal.s16.w300);
  }

  Widget _buildMarkerText(bool right) {
    return Row(
      spacing: 7,
      children: [
        if (right) _buildText(_secondValue),
        _buildMarker(right ? Assets.graphics.icons.rangeMax : Assets.graphics.icons.rangeMin),
        if (!right) _buildText(_value),
      ],
    );
  }

  @override
  Widget buildRight() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildMarkerText(false),
        _buildMarkerText(true),
      ],
    );
  }
}
