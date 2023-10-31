// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/animal_fur.dart';
import 'package:flutter/material.dart';

class WidgetFurPerCent extends StatelessWidget {
  final AnimalFur animalFur;

  final double width = 60;

  const WidgetFurPerCent({
    Key? key,
    required this.animalFur,
  }) : super(key: key);

  Widget _buildPerCentText(String text) {
    return AutoSizeText(
      text,
      maxLines: 1,
      style: Interface.s12w300n(Interface.dark),
    );
  }

  Widget _buildWidgets() {
    String left, right, point, percent;
    left = right = point = percent = "";
    if (animalFur.furId != Interface.greatOneId) {
      left = animalFur.perCent.toString().split(".")[0];
      right = animalFur.perCent.toString().split(".")[1];
      point = ".";
      percent = "%";
    }
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: width,
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
            _buildPerCentText(left),
            _buildPerCentText(point),
            _buildPerCentText(right),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: _buildPerCentText(percent),
            ),
          ]))
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
