import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/widgets/button/switch.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetSwitchFilterOperation extends WidgetSwitch {
  final Color? _color;
  final FilterOperation _operation;

  const WidgetSwitchFilterOperation({
    super.key,
    required FilterOperation operation,
    Color? color,
    super.background,
    required super.onTap,
  })  : _operation = operation,
        _color = color,
        super(width: 0, isActive: true);

  Color get color => _color ?? Interface.alwaysDark;

  @override
  Color get buttonBackground => background ?? Interface.blue;

  @override
  Widget? buildCenter() {
    return AnimatedContainer(
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: WidgetText(
        _operation.name.toUpperCase(),
        color: color,
        style: Style.normal.s12.w500,
        textAlign: TextAlign.center,
      ),
    );
  }
}
