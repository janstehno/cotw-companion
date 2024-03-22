import 'package:cotwcompanion/widgets/tag/tag.dart';
import 'package:flutter/material.dart';

class WidgetTagTap extends WidgetTag {
  final Function _onTap;

  WidgetTagTap.big({
    super.key,
    super.icon,
    super.value,
    required super.color,
    required super.background,
    required Function onTap,
  })  : _onTap = onTap,
        super.big();

  WidgetTagTap.small({
    super.key,
    super.icon,
    super.value,
    required super.color,
    required super.background,
    required Function onTap,
  })  : _onTap = onTap,
        super.small();

  @override
  Widget buildContainer() {
    return GestureDetector(
      onTap: () => _onTap(),
      child: super.buildContainer(),
    );
  }
}
