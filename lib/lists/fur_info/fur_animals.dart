// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/model/animal_fur.dart';
import 'package:cotwcompanion/widgets/entries/fur.dart';
import 'package:cotwcompanion/widgets/title_small.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListFurAnimals extends StatefulWidget {
  final int furId;
  final int rarity;

  const ListFurAnimals({
    Key? key,
    required this.furId,
    required this.rarity,
  }) : super(key: key);

  @override
  ListFurAnimalsState createState() => ListFurAnimalsState();
}

class ListFurAnimalsState extends State<ListFurAnimals> {
  late final List<AnimalFur> _animalFurs = [];

  String _getRarity() {
    switch (widget.rarity) {
      case 0:
        return "rarity_common";
      case 1:
        return "rarity_uncommon";
      case 2:
        return "rarity_rare";
      case 3:
        return "rarity_very_rare";
      default:
        return "rarity_mission";
    }
  }

  void _getAnimalFurs() {
    for (AnimalFur animalFur in HelperJSON.animalsFurs) {
      if (animalFur.furId == widget.furId && animalFur.rarity == widget.rarity) {
        _animalFurs.add(animalFur);
      }
    }
    _animalFurs.sort((a, b) => b.perCent.compareTo(a.perCent));
  }

  Widget _buildWidgets() {
    _getAnimalFurs();
    return _animalFurs.isNotEmpty
        ? Column(
            children: [
              WidgetTitleSmall(
                primaryText: tr(_getRarity()),
                dot: true,
                dotColor: _animalFurs[0].color,
              ),
              Container(
                  padding: const EdgeInsets.all(30),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _animalFurs.length,
                      itemBuilder: (context, index) {
                        return EntryFur(
                          animalFur: _animalFurs[index],
                        );
                      }))
            ],
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
