// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/model/animal_fur.dart';
import 'package:cotwcompanion/thehunter/widgets/animal_fur.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderAnimalFurs extends StatefulWidget {
  final int animalID;
  final int chosenRarity;

  const BuilderAnimalFurs({Key? key, required this.animalID, required this.chosenRarity}) : super(key: key);

  @override
  BuilderAnimalFursState createState() => BuilderAnimalFursState();
}

class BuilderAnimalFursState extends State<BuilderAnimalFurs> {
  late final List<AnimalFur> _furs = [];

  _getFurs() {
    _furs.clear();
    for (AnimalFur af in JSONHelper.animalsFurs) {
      if (af.getAnimalID == widget.animalID) {
        if (af.getRarity == widget.chosenRarity) {
          af.setChosen(true);
        } else {
          af.setChosen(false);
        }
        _furs.add(af);
      }
    }
  }

  Widget _buildWidgets() {
    return _furs.isEmpty
        ? Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
                child: AutoSizeText(tr('none'), maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)))
          ])
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _furs.length,
            itemBuilder: (context, index) {
              AnimalFur fur = _furs[index];
              return EntryAnimalFur(fur: fur);
            });
  }

  @override
  Widget build(BuildContext context) {
    _getFurs();
    return _buildWidgets();
  }
}
