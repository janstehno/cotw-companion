import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/model/connect/animal_fur.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/parts/animal/fur/fur.dart';
import 'package:flutter/material.dart';

class ListAnimalFurs extends StatelessWidget {
  final Animal _animal;
  final int _chosenRarity;

  const ListAnimalFurs(
    Animal animal, {
    super.key,
    required int chosenRarity,
  })  : _animal = animal,
        _chosenRarity = chosenRarity;

  List<AnimalFur> get _furs => HelperJSON.getAnimalFurs(_animal.id).sorted(AnimalFur.sortByGenderRarityPercentName);

  Widget _buildAnimalFur(AnimalFur animalFur) {
    return WidgetAnimalFur(
      animalFur,
      isChosen: animalFur.rarity == _chosenRarity,
    );
  }

  List<Widget> _listFurs() {
    return _furs.map((e) => _buildAnimalFur(e)).toList();
  }

  Widget _buildWidgets() {
    return Column(children: _listFurs());
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
