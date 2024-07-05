import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/connect/animal_fur.dart';
import 'package:cotwcompanion/model/translatable/fur.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/parts/fur/fur.dart';
import 'package:cotwcompanion/widgets/subtitle/subtitle_indicator.dart';
import 'package:flutter/material.dart';

class ListFurAnimals extends StatelessWidget {
  final Fur _fur;
  final int _rarity;
  final bool _showPerCent;

  const ListFurAnimals(
    Fur fur, {
    super.key,
    required int rarity,
    required bool showPerCent,
  })  : _fur = fur,
        _rarity = rarity,
        _showPerCent = showPerCent;

  List<AnimalFur> get _animalFurs => HelperJSON.getAnimalFursWithRarity(_fur.id, _rarity);

  Widget _buildAnimalFurs() {
    List<AnimalFur> animalFurs = _animalFurs;
    _showPerCent ? animalFurs.sort(AnimalFur.sortByPercentAnimalName) : animalFurs.sort(AnimalFur.sortByAnimalName);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: animalFurs.length,
      itemBuilder: (context, i) {
        return WidgetFur(animalFurs.elementAt(i), showPerCent: _showPerCent);
      },
    );
  }

  Widget _buildWidgets() {
    return Column(
      children: [
        if (_animalFurs.isNotEmpty) ...[
          WidgetSubtitleIndicator(
            AnimalFur.rarityName(_rarity),
            indicatorSize: Values.dotSize,
            indicatorColor: _animalFurs.first.color,
          ),
          WidgetPadding.a30(child: _buildAnimalFurs()),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
