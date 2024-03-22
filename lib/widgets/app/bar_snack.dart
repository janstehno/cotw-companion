import 'package:cotwcompanion/interface/graphics.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetSnackBar extends StatelessWidget {
  final String _text;
  final String? _buttonIcon;
  final Process _process;
  final Function? _onButtonTap;

  const WidgetSnackBar({
    super.key,
    required String text,
    String? buttonIcon,
    required Process process,
    Function? onButtonTap,
  })  : _text = text,
        _buttonIcon = buttonIcon,
        _process = process,
        _onButtonTap = onButtonTap;

  double get _height => Values.snackBar;

  Color get _color {
    switch (_process) {
      case Process.success:
        return Interface.lightGreen;
      case Process.error:
        return Interface.red;
      case Process.info:
        return Interface.dark;
    }
  }

  Widget _buildIcon() {
    return WidgetIcon(
      Graphics.getProcessIcon(_process),
      color: _color,
    );
  }

  Widget _buildText() {
    return Container(
      alignment: Alignment.centerLeft,
      child: WidgetText(
        _text,
        color: Interface.dark,
        style: Style.normal.s14.w300,
        maxLines: 2,
      ),
    );
  }

  Widget _buildButton() {
    return WidgetButtonIcon(
      _buttonIcon!,
      color: Interface.alwaysDark,
      background: Interface.primary,
      onTap: () => _onButtonTap!(),
    );
  }

  Widget _buildWidgets() {
    return SizedBox(
      height: _height,
      child: WidgetPadding.h30(
        background: Interface.search,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildIcon(),
            const SizedBox(width: 15),
            Expanded(child: _buildText()),
            if (_buttonIcon != null) const SizedBox(width: 15),
            if (_buttonIcon != null) _buildButton(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
