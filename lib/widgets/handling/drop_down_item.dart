import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetDropDownItem extends StatelessWidget {
  final String _text;
  final String? _icon;
  final Color? _color;
  final double? _size;

  const WidgetDropDownItem({
    super.key,
    required String text,
    String? icon,
    Color? color,
    double? size,
  })  : _text = text,
        _icon = icon,
        _color = color,
        _size = size;

  double get _height => Values.dropDown;

  String get text => _text;

  Color get color => _color ?? Interface.dark;

  double get size => _size ?? Values.iconSize;

  Widget _buildIcon() {
    return Container(
      width: Values.iconSize,
      alignment: Alignment.center,
      child: WidgetIcon.withSize(
        _icon!,
        size: size,
        color: color,
      ),
    );
  }

  Widget _buildText() {
    return WidgetText(
      _text,
      color: Interface.dark,
      style: Style.normal.s16.w300,
    );
  }

  Widget buildCenter() {
    return Row(
      children: [
        Expanded(child: _buildText()),
        if (_icon != null) ...[
          SizedBox(width: 15),
          _buildIcon(),
        ],
      ],
    );
  }

  Widget _buildWidgets() {
    return SizedBox(
      height: _height,
      child: WidgetPadding.h30(
        background: Interface.transparent,
        child: buildCenter(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
