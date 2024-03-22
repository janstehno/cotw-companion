import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class ListStatistics extends StatelessWidget {
  final List<String> _labels;
  final List<dynamic> _values;

  const ListStatistics({
    super.key,
    required List<String> labels,
    required List<dynamic> values,
  })  : _labels = labels,
        _values = values,
        assert(labels.length == values.length && values.length == 4);

  double get _height => 60;

  double get _iconSize => 15;

  Widget _buildLeft(dynamic value) {
    return WidgetMargin.right(
      10,
      child: WidgetText(
        value.toString(),
        color: Interface.dark,
        style: Style.normal.s16.w300,
      ),
    );
  }

  Widget _buildIcon(String icon) {
    return SvgPicture.asset(
      icon,
      width: _iconSize,
      height: _iconSize,
      colorFilter: ColorFilter.mode(
        Interface.dark,
        BlendMode.srcIn,
      ),
    );
  }

  Widget _buildRight(dynamic value) {
    return WidgetMargin.left(
      10,
      child: WidgetText(
        value.toString(),
        color: Interface.dark,
        style: Style.normal.s16.w300,
      ),
    );
  }

  Widget _buildDetail(bool leftToRight, String icon, dynamic value) {
    return Container(
      alignment: Alignment.center,
      height: _height / 2,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (!leftToRight) _buildLeft(value),
          _buildIcon(icon),
          if (leftToRight) _buildRight(value),
        ],
      ),
    );
  }

  Widget _buildFirstRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDetail(true, _labels[0], _values[0]),
        _buildDetail(false, _labels[1], _values[1]),
      ],
    );
  }

  Widget _buildSecondRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDetail(true, _labels[2], _values[2]),
        _buildDetail(false, _labels[3], _values[3]),
      ],
    );
  }

  Widget _buildWidgets() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFirstRow(),
        _buildSecondRow(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
