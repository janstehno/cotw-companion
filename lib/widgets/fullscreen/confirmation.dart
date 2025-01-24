import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetConfirmation extends StatelessWidget {
  final String _text;
  final Function _onConfirm;
  final Function _onCancel;

  const WidgetConfirmation({
    super.key,
    required String text,
    required Function onConfirm,
    required Function onCancel,
  })  : _text = text,
        _onConfirm = onConfirm,
        _onCancel = onCancel;

  Widget _buildText() {
    return WidgetPadding.a30(
      alignment: Alignment.center,
      child: WidgetText(
        _text,
        color: Interface.dark,
        style: Style.normal.s18.w500,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildConfirm() {
    return WidgetButtonIcon(
      Assets.graphics.icons.accept,
      color: Interface.alwaysDark,
      background: Interface.red,
      onTap: () => _onConfirm(),
    );
  }

  Widget _buildCancel() {
    return WidgetButtonIcon(
      Assets.graphics.icons.menuClose,
      color: Interface.light,
      background: Interface.dark,
      onTap: () => _onCancel(),
    );
  }

  Widget _buildWidgets() {
    return Center(
      child: Container(
        color: Interface.body.withValues(alpha: 0.8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildText(),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildConfirm(),
                _buildCancel(),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
