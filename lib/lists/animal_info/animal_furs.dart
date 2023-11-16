// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/animal_fur.dart';
import 'package:cotwcompanion/widgets/entries/animal_fur.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListAnimalFurs extends StatefulWidget {
  final int animalId;
  final int chosenRarity;

  const ListAnimalFurs({Key? key, required this.animalId, required this.chosenRarity}) : super(key: key);

  @override
  ListAnimalFursState createState() => ListAnimalFursState();
}

class ListAnimalFursState extends State<ListAnimalFurs> {
  late final List<AnimalFur> _furs = [];

  @override
  void initState() {
    super.initState();
  }

  void _getFurs() {
    _furs.clear();
    for (AnimalFur animalFur in HelperJSON.animalsFurs) {
      if (animalFur.animalId == widget.animalId) {
        _furs.add(animalFur);
      }
    }
  }

  Widget _buildWidgets() {
    _getFurs();
    return _furs.isEmpty
        ? Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
                child: AutoSizeText(
              tr("none"),
              maxLines: 1,
              style: Interface.s16w300n(Interface.dark),
            ))
          ])
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _furs.length,
            itemBuilder: (context, index) {
              AnimalFur animalFur = _furs[index];
              return EntryAnimalFur(
                animalFur: animalFur,
                isChosen: animalFur.rarity == widget.chosenRarity,
              );
            });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
