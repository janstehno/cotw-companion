// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryAnimalSense extends StatelessWidget {
  final String icon;
  final int sense;
  final bool visible;

  const EntryAnimalSense({Key? key, required this.icon, required this.sense, this.visible = true}) : super(key: key);

  Color _getColor() {
    switch (sense) {
      case 0:
        return const Color(Values.colorTransparent);
      case 1:
        return const Color(Values.colorFirst);
      case 2:
        return const Color(Values.colorThird);
      case 3:
        return const Color(Values.colorFifth);
      default:
        return const Color(Values.colorEighth);
    }
  }

  List<Widget> _getSenseLevel() {
    List<Widget> result = [];
    for (int i = 0; i < sense; i++) {
      result.add(Container(
        width: 7,
        height: 7,
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10.0)), color: _getColor()),
      ));
    }
    return result;
  }

  Widget _buildWidgets() {
    return SizedBox(
        height: 25,
        child: Row(children: [
          SvgPicture.asset(icon, width: 15, color: Color(Values.colorContentIconTintDark)),
          Expanded(child: Padding(padding: const EdgeInsets.only(left: 15), child: Row(children: _getSenseLevel())))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return visible ? _buildWidgets() : Container();
  }
}
