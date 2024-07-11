import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetTitle extends StatelessWidget {
  final String _text;
  final String? _subtext;
  final Color? _color;
  final int _maxLines;
  final bool _upperCase;

  const WidgetTitle(
    String text, {
    super.key,
    String? subtext,
    Color? color,
    int maxLines = 1,
    bool upperCase = true,
  })  : _text = text,
        _subtext = subtext,
        _color = color,
        _maxLines = maxLines,
        _upperCase = upperCase;

  String get text => _text;

  Color? get color => _color;

  int get maxLines => _maxLines;

  bool get upperCase => _upperCase;

  double get height => Values.title;

  Color get titleColor => _color ?? Interface.dark;

  Color get titleBackground => Interface.title;

  Widget buildTitle() {
    if (_text.isNotEmpty) {
      if (_maxLines == 1) {
        return WidgetText(
          upperCase ? _text.toUpperCase() : _text,
          color: titleColor,
          style: Style.condensed.s20.w600,
        );
      }
      return WidgetText(
        upperCase ? _text.toUpperCase() : _text,
        color: titleColor,
        style: Style.condensed.s18.w600,
        maxLines: _maxLines,
      );
    }
    return const SizedBox.shrink();
  }

  Widget buildSubtitle() {
    return WidgetText(
      _subtext!,
      color: Interface.disabled,
      style: Style.normal.s12.w300,
      maxLines: 1,
    );
  }

  Widget _buildText() {
    if (_subtext != null) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle(),
          buildSubtitle(),
        ],
      );
    }
    return buildTitle();
  }

  Widget? buildBefore() => null;

  Widget? buildAfter() => null;

  Widget buildRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (buildBefore() != null) WidgetMargin.right(20, child: buildBefore()!),
        Expanded(child: _buildText()),
        if (buildAfter() != null) WidgetMargin.left(20, child: buildAfter()!),
      ],
    );
  }

  Widget buildCenter() {
    return WidgetPadding.h30(
      background: titleBackground,
      child: buildRow(),
    );
  }

  Widget buildContainer() {
    return SizedBox(
      height: height,
      child: buildCenter(),
    );
  }

  Widget _buildWidgets() => buildContainer();

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
