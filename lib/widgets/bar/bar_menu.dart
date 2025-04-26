import 'package:collection/collection.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/bar/bar_menu_item.dart';
import 'package:flutter/material.dart';

class WidgetMenuBar extends StatelessWidget {
  final List<WidgetMenuBarItem> _items;

  const WidgetMenuBar({
    super.key,
    required List<WidgetMenuBarItem> items,
  }) : _items = items;

  double get _buttonSize => Values.tapSize;

  double get _height => Values.menuBar;

  double get rowMargin => (_height - _buttonSize) / 2;

  final double _spacing = 10;

  double width(BuildContext context) {
    Orientation orientation = MediaQuery.orientationOf(context);
    return orientation == Orientation.portrait ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height;
  }

  double height() {
    for (WidgetMenuBarItem item in _items) {
      if (item.menuOpened) {
        double itemLength = (_buttonSize * item.subButtons.length) + (_spacing * (item.subButtons.length - 1));
        return _height + rowMargin * 2 + itemLength;
      }
    }
    return _height;
  }

  List<Widget> _listItems() {
    return _items.mapIndexed((i, item) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: _buttonSize,
        margin: EdgeInsets.fromLTRB(
          i == 0 ? rowMargin : _spacing / 2,
          0,
          i == _items.length - 1 ? rowMargin : _spacing / 2,
          rowMargin,
        ),
        child: item,
      );
    }).toList();
  }

  Widget _buildWidgets(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width(context),
      height: height(),
      child: SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: _listItems(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
