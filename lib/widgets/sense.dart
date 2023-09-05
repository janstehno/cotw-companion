// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetSense extends StatelessWidget {
  final String icon;
  final int sense;
  final bool isVisible;

  const WidgetSense({
    Key? key,
    required this.icon,
    required this.sense,
    required this.isVisible,
  }) : super(key: key);

  Color _getColor() {
    switch (sense) {
      case 0:
        return Colors.transparent;
      case 1:
        return Interface.red;
      case 2:
        return Interface.orange;
      case 3:
        return Interface.yellow;
      default:
        return Interface.green;
    }
  }

  List<Widget> _getSenseLevel() {
    List<Widget> result = [];
    for (int count = 0; count < sense; count++) {
      result.add(Container(
          width: 7,
          height: 7,
          margin: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            color: _getColor(),
          )));
    }
    return result;
  }

  Widget _buildWidgets() {
    return SizedBox(
        height: 25,
        child: Row(children: [
          SvgPicture.asset(
            icon,
            width: 15,
            colorFilter: ColorFilter.mode(
              Interface.dark,
              BlendMode.srcIn,
            ),
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: _getSenseLevel(),
                  )))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return isVisible ? _buildWidgets() : Container();
  }
}
