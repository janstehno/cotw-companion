import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetItemSearch extends StatelessWidget {
  final String _icon;
  final String _text;
  final Function _onTap;
  final Widget _activity;

  const WidgetItemSearch({
    super.key,
    required String icon,
    required String text,
    String? subtext,
    required Function onTap,
    required Widget activity,
  })  : _icon = icon,
        _text = text,
        _onTap = onTap,
        _activity = activity;

  final double _height = Values.searchItem;

  void focus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
  }

  void onTap(BuildContext context) {
    _onTap();
    focus(context);
    Navigator.push(context, MaterialPageRoute(builder: (e) => _activity));
  }

  Widget _buildIcon() {
    return WidgetIcon(
      _icon,
      color: Interface.primary,
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
          style: Style.normal.s12.w300,
        ),
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
      child: Container(
        height: _height,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        color: Interface.light.withAlpha(225),
        child: _buildRow(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
