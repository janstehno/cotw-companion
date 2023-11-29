// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/widgets/entries/menubar_item.dart';
import 'package:flutter/material.dart';

class WidgetMenuBar extends StatefulWidget {
  final double width, height;
  final List<EntryMenuBarItem> items;

  const WidgetMenuBar({
    Key? key,
    required this.width,
    required this.height,
    required this.items,
  }) : super(key: key);

  @override
  WidgetMenuBarState createState() => WidgetMenuBarState();
}

class WidgetMenuBarState extends State<WidgetMenuBar> {
  final double _itemWidth = 35;
  final double _rowSpace = 10;
  final double _rowMargin = 20;

  double _newWidth = 0;
  double _newHeight = 0;

  void _getWidth() {
    double itemLength = (_itemWidth * widget.items.length) + (_rowSpace * (widget.items.length - 1));
    _newWidth = widget.width > (_rowMargin * 2 + itemLength) ? (_rowMargin * 2 + itemLength) : widget.width;
  }

  void _getHeight() {
    _newHeight = widget.height;
    for (EntryMenuBarItem item in widget.items) {
      if (item.menuOpened) {
        double itemLength = (_itemWidth * item.menuButtons.length) + (_rowSpace * (item.menuButtons.length - 1));
        _newHeight = widget.height + (_rowMargin + itemLength);
      }
    }
  }

  List<Widget> _buildItems() {
    List<Widget> widgets = [];
    for (int index = 0; index < widget.items.length; index++) {
      widgets.add(
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _itemWidth,
          margin: EdgeInsets.fromLTRB(index == 0 ? _rowMargin : _rowSpace / 2, 0, index == widget.items.length - 1 ? _rowMargin : _rowSpace / 2, _rowMargin),
          child: widget.items.elementAt(index),
        ),
      );
    }
    return widgets;
  }

  Widget _buildWidgets() {
    _getWidth();
    _getHeight();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: _newWidth,
      height: _newHeight,
      child: SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: _buildItems(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
