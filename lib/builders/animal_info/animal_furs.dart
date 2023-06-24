// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/animal_fur.dart';
import 'package:cotwcompanion/widgets/entries/animal_fur.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderAnimalFurs extends StatefulWidget {
  final int animalId;
  final int chosenRarity;

  const BuilderAnimalFurs({Key? key, required this.animalId, required this.chosenRarity}) : super(key: key);

  @override
  BuilderAnimalFursState createState() => BuilderAnimalFursState();
}

class BuilderAnimalFursState extends State<BuilderAnimalFurs> {
  late final List<AnimalFur> _furs = [];

  @override
  void initState() {
    super.initState();
  }

  void _getFurs() {
    _furs.clear();
    for (AnimalFur af in HelperJSON.animalsFurs) {
      if (af.animalId == widget.animalId) {
        if (af.rarity == widget.chosenRarity) {
          af.chosen = true;
        } else {
          af.chosen = false;
        }
        _furs.add(af);
      }
    }
  }

  Widget _buildWidgets() {
    _getFurs();
    return _furs.isEmpty
        ? Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
                child: AutoSizeText(tr('none'),
                    maxLines: 1,
                    style: TextStyle(
                      color: Interface.dark,
                      fontSize: Interface.s20,
                      fontWeight: FontWeight.w400,
                    )))
          ])
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _furs.length,
            itemBuilder: (context, index) {
              AnimalFur fur = _furs[index];
              return Container(
                  margin: EdgeInsets.only(bottom: index != _furs.length - 1 ? 5 : 0),
                  child: EntryAnimalFur(
                    fur: fur,
                  ));
            });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
