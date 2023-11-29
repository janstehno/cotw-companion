// Copyright (c) 2023 Jan Stehno

import 'package:flutter/material.dart';

class EntryMenuBarItem extends StatefulWidget {
  final Widget barButton;
  final List<Widget> menuButtons;
  final double menuHeight;
  final bool menuOpened;

  const EntryMenuBarItem({
    Key? key,
    required this.barButton,
    this.menuButtons = const [],
    this.menuHeight = 0,
    this.menuOpened = false,
  }) : super(key: key);

  @override
  EntryMenuBarItemState createState() => EntryMenuBarItemState();
}

class EntryMenuBarItemState extends State<EntryMenuBarItem> {
  double _getPosition(int index, bool position) {
    return position ? widget.menuHeight + (45 * index) : 0;
  }

  List<Widget> _buildButtons() {
    List<Widget> widgets = [];
    for (int index = 0; index < widget.menuButtons.length; index++) {
      widgets.add(
        AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            right: 0,
            bottom: _getPosition(index, widget.menuOpened),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: widget.menuOpened ? 1 : 0,
              child: widget.menuButtons.elementAt(index),
            )),
      );
    }
    widgets.add(
      Positioned(
        right: 0,
        bottom: 0,
        child: widget.barButton,
      ),
    );
    return widgets;
  }

  Widget _buildWidgets() {
    return widget.menuButtons.isEmpty ? widget.barButton : Stack(children: _buildButtons());
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
