import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/tag/tag.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetTagSpecial extends WidgetTag {
  final bool _withIcon;

  WidgetTagSpecial({
    super.key,
    String? identifier,
    super.value,
    required super.color,
    required super.background,
    bool withIcon = false,
  })  : _withIcon = withIcon,
        super.big(icon: identifier);

  @override
  EdgeInsets get rightMargin => const EdgeInsets.symmetric(horizontal: 10);

  @override
  Widget? buildLeft(String? value) {
    if (value != null) {
      if (_withIcon) return super.buildLeft(l);
      return super.buildRight(l);
    }
    return null;
  }

  Widget _buildText(String value) {
    if (height == Values.bigTag) {
      return WidgetText(
        value,
        color: background,
        style: Style.normal.s16.w500,
      );
    }
    return WidgetText(
      value,
      color: background,
      style: Style.normal.s14.w500,
    );
  }

  @override
  Widget? buildRight(String? value) {
    if (value != null) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(height / 4),
            bottomRight: Radius.circular(height / 4),
          ),
          color: color,
        ),
        child: _buildText(value),
      );
    }
    return null;
  }
}
