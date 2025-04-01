import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/connect/animal_fur.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/parts/animal/fur/fur.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListAnimalFurs extends StatelessWidget {
  final Animal _animal;
  final FurRarity? _chosenRarity;

  const ListAnimalFurs(
    Animal animal, {
    super.key,
    required FurRarity? chosenRarity,
  })  : _animal = animal,
        _chosenRarity = chosenRarity;

  List<AnimalFur> get _furs => HelperJSON.getAnimalFurs(_animal.id).sorted(AnimalFur.sortByGenderRarityPercentFurName);

  Widget _buildAnimalFur(AnimalFur animalFur, bool showPerCent) {
    return WidgetAnimalFur(
      animalFur,
      isChosen: animalFur.rarity == _chosenRarity,
      showPerCent: showPerCent,
    );
  }

  List<Widget> _listFurs(BuildContext context) {
    bool showPerCent = Provider.of<Settings>(context, listen: false).furRarityPerCent;
    return _furs.map((e) => _buildAnimalFur(e, showPerCent)).toList();
  }

  Widget _buildWidgets(BuildContext context) {
    return Column(children: _listFurs(context));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
