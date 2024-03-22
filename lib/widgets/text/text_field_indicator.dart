import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/indicator/indicator.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:cotwcompanion/widgets/text/text_field.dart';
import 'package:flutter/material.dart';

class WidgetTextFieldIndicator extends StatelessWidget {
  final String _icon;
  final int? _length;
  final bool _correct, _numberOnly, _decimal, _noIndicator;
  final TextEditingController _textController;

  const WidgetTextFieldIndicator({
    super.key,
    required String icon,
    int? length,
    required TextEditingController textController,
    bool? correct,
    bool? noIndicator,
    bool numberOnly = true,
    bool decimal = true,
  })  : _icon = icon,
        _length = length,
        _correct = correct ?? false,
        _noIndicator = noIndicator ?? false,
        _numberOnly = numberOnly,
        _decimal = decimal,
        _textController = textController;

  double get _height => Values.textField;

  Color get _color => _correct ? Interface.green : Interface.disabled;

  Widget _buildIcon() {
    return WidgetMargin.right(
      15,
      child: WidgetIcon(
        _icon,
        color: Interface.disabled,
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      alignment: Alignment.centerLeft,
      child: WidgetTextField(
        decimal: _decimal,
        numberOnly: _numberOnly,
        textController: _textController,
      ),
    );
  }

  Widget _buildLength() {
    int remainingChars = _length! - _textController.text.length;
    return WidgetPadding.fromLTRB(
      15,
      0,
      15,
      0,
      child: Row(
        children: [
          WidgetText(
            "${remainingChars >= 0 ? remainingChars : 0}/",
            color: Interface.disabled,
            style: Style.normal.s14.w300,
          ),
          WidgetText(
            "${_length!}",
            color: Interface.disabled,
            style: Style.normal.s10.w300,
          ),
        ],
      ),
    );
  }

  Widget _buildWidgets() {
    return SizedBox(
      height: _height,
      child: WidgetPadding.h30(
        background: Interface.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildIcon(),
            Expanded(child: _buildTextField()),
            if (_length != null) _buildLength(),
            if (!_noIndicator)
              Expanded(
                flex: 0,
                child: WidgetIndicator(
                  _color,
                  size: Values.dotSize,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
