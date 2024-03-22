import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetAppBar extends StatelessWidget {
  final String _text;
  final String? _icon;
  final int _maxLines;
  final Function? _onTap;
  final BuildContext _context;

  const WidgetAppBar(
    String text, {
    super.key,
    String? icon,
    int maxLines = 2,
    Function? onTap,
    required BuildContext context,
  })  : _text = text,
        _icon = icon,
        _maxLines = maxLines,
        _onTap = onTap,
        _context = context;

  double get _height => Values.appBar;

  Widget _buildBack() {
    return WidgetIcon(
      _icon ?? Assets.graphics.icons.back,
      color: Interface.alwaysDark,
    );
  }

  Widget _buildLeft() {
    return GestureDetector(
      onTap: () {
        if (_onTap != null) {
          _onTap!();
        } else {
          Navigator.pop(_context);
        }
      },
      child: Container(
        width: 80,
        height: _height,
        color: Interface.transparent,
        alignment: Alignment.center,
        child: _buildBack(),
      ),
    );
  }

  Widget _buildText() {
    return WidgetText(
      _text.toUpperCase(),
      color: Interface.alwaysDark,
      style: _maxLines == 1 ? Style.condensed.s28.w600 : Style.condensed.s26.w600,
      maxLines: _maxLines,
      textAlign: TextAlign.right,
    );
  }

  Widget _buildRight() {
    return Container(
      height: _height,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 30),
      child: _buildText(),
    );
  }

  Widget _buildWidgets() {
    return Container(
      color: Interface.primary,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildLeft(),
          Expanded(child: _buildRight()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
