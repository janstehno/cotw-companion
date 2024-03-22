import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetTag extends StatelessWidget {
  final double _height;
  final String? _left, _right;
  final Color _color, _background;

  WidgetTag.big({
    super.key,
    String? icon,
    String? value,
    required Color color,
    required Color background,
  })  : assert((icon != null && icon.isNotEmpty) || (value != null && value.isNotEmpty)),
        _height = Values.bigTag,
        _left = icon,
        _right = value,
        _color = color,
        _background = background;

  WidgetTag.small({
    super.key,
    String? icon,
    String? value,
    required Color color,
    required Color background,
  })  : assert((icon != null && icon.isNotEmpty) || (value != null && value.isNotEmpty)),
        _height = Values.smallTag,
        _left = icon,
        _right = value,
        _color = color,
        _background = background;

  double get height => _height;

  Color get color => _color;

  Color get background => _background;

  String? get l => _left;

  String? get _r => _right;

  EdgeInsets get _leftMargin => const EdgeInsets.symmetric(horizontal: 10);

  EdgeInsets get rightMargin => EdgeInsets.only(left: _left != null ? 0 : 10, right: 10);

  Widget? buildLeft(String? value) {
    if (value != null) {
      return Container(
        margin: _leftMargin,
        child: WidgetIcon.withSize(
          value,
          color: color,
          size: Values.indicatorSize - (_right != null ? 5 : 0),
        ),
      );
    }
    return null;
  }

  Widget? buildRight(String? value) {
    if (value != null) {
      if (height == Values.bigTag) {
        return Container(
          margin: rightMargin,
          child: WidgetText(
            value,
            color: color,
            style: Style.normal.s14.w500,
          ),
        );
      } else if (height == Values.smallTag) {
        return Container(
          margin: rightMargin,
          child: WidgetText(
            value,
            color: color,
            style: Style.normal.s12.w500,
          ),
        );
      }
    }
    return null;
  }

  Widget _buildTag() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildLeft(l) ?? const SizedBox.shrink(),
        buildRight(_r) ?? const SizedBox.shrink(),
      ],
    );
  }

  Widget buildContainer() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(height / 4)),
            color: background,
          ),
          child: _buildTag(),
        ),
      ],
    );
  }

  Widget _buildWidgets() => buildContainer();

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
