import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetParameter extends StatelessWidget {
  final String _text;
  final dynamic _value;

  const WidgetParameter({
    super.key,
    required String text,
    required dynamic value,
  })  : _text = text,
        _value = value;

  dynamic get value => _value;

  Widget _buildText() {
    return WidgetText(
      _text,
      color: Interface.dark,
      style: Style.normal.s16.w300,
    );
  }

  Widget buildValue() {
    return WidgetText(
      _value.toString(),
      color: Interface.dark,
      style: Style.normal.s18.w500,
      textAlign: TextAlign.end,
      maxLines: 1,
    );
  }

  Widget _buildWidgets() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildText(),
        const SizedBox(width: 30),
        Expanded(child: buildValue()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
