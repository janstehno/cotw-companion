// Copyright (c) 2022 - 2023 Jan Stehno

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
  double _newWidth = 0;
  double _newHeight = 0;

  void _getWidth() {
    double itemLength = (35 * widget.items.length) + (10 * (widget.items.length - 1));
    _newWidth = widget.width > (40 + itemLength) ? (40 + itemLength) : widget.width;
  }

  void _getHeight() {
    _newHeight = widget.height;
    for (EntryMenuBarItem item in widget.items) {
      if (item.menuOpened) {
        double itemLength = (35 * item.menuButtons.length) + (10 * (item.menuButtons.length - 1));
        _newHeight = widget.height + (20 + itemLength);
      }
    }
  }

  List<Widget> _buildItems() {
    List<Widget> widgets = [];
    for (int index = 0; index < widget.items.length; index++) {
      widgets.add(
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 35,
          margin: EdgeInsets.fromLTRB(index == 0 ? 20 : 5, 0, index == widget.items.length - 1 ? 20 : 5, 20),
          child: widget.items[index],
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
            )));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
