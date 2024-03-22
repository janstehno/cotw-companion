import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetItemSearch extends StatelessWidget {
  final int _index;
  final String _icon;
  final String _text;
  final String? _subtext;
  final Function _onTap;
  final Widget _activity;

  const WidgetItemSearch(
    int i, {
    super.key,
    required String icon,
    required String text,
    String? subtext,
    required Function onTap,
    required Widget activity,
  })  : _index = i,
        _icon = icon,
        _text = text,
        _subtext = subtext,
        _onTap = onTap,
        _activity = activity;

  final double _height = Values.searchItem;

  void onTap(BuildContext context) {
    _onTap();
    Navigator.push(context, MaterialPageRoute(builder: (e) => _activity));
  }

  Widget _buildIcon() {
    return WidgetIcon(
      _icon,
      color: Interface.disabled,
    );
  }

  Widget _buildSubtext() {
    return WidgetText(
      _subtext!,
      color: Interface.disabled,
      style: Style.normal.s12.w300,
    );
  }

  Widget _buildText() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetText(
          _text,
          color: Interface.dark,
          style: Style.normal.s16.w300,
        ),
        if (_subtext != null) _buildSubtext(),
      ],
    );
  }

  Widget _buildRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildIcon(),
        const SizedBox(width: 15),
        Expanded(child: _buildText()),
      ],
    );
  }

  Widget _buildWidgets(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: SizedBox(
        height: _height,
        child: WidgetPadding.h30(
          background: Utils.backgroundAt(_index),
          child: _buildRow(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
