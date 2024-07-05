import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetDropDownItem extends StatelessWidget {
  final String _text;

  const WidgetDropDownItem({
    super.key,
    required String text,
  }) : _text = text;

  Color get _background => Interface.dropDown;

  double get _height => Values.dropDown;

  String get text => _text;

  Widget buildCenter() {
    return WidgetText(
      _text,
      color: Interface.dark,
      style: Style.normal.s16.w300,
    );
  }

  Widget _buildWidgets() {
    return SizedBox(
      height: _height,
      child: WidgetPadding.h30(
        background: _background,
        child: buildCenter(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
