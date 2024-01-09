// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/values.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  ProgressBarState createState() => ProgressBarState();
}

class ProgressBarState extends State<ProgressBar> {
  final double _indicatorWidth = 150;
  final double _indicatorHeight = 3;

  int _currentLoadedCount = 0;

  rebuild(int id) {
    setState(() {
      _currentLoadedCount = id + 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _indicatorWidth,
      height: _indicatorHeight,
      alignment: Alignment.centerLeft,
      color: Interface.primary.withOpacity(0.2),
      child: AnimatedContainer(
        width: (_currentLoadedCount * _indicatorWidth) / Values.data,
        height: _indicatorHeight,
        color: Interface.primary,
        duration: const Duration(milliseconds: 200),
      ),
    );
  }
}
