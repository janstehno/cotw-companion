import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/subtitle/subtitle.dart';
import 'package:cotwcompanion/widgets/text/text_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListWeaponAnimals extends StatefulWidget {
  final int _level;

  const ListWeaponAnimals({
    super.key,
    required int level,
  }) : _level = level;

  int get level => _level;

  @override
  ListWeaponAnimalsState createState() => ListWeaponAnimalsState();
}

class ListWeaponAnimalsState extends State<ListWeaponAnimals> {
  final Set<Animal> _animals = {};

  @override
  void initState() {
    _initializeAnimals();
    super.initState();
  }

  void _initializeAnimals() {
    for (Animal animal in HelperJSON.animals) {
      if (animal.level == widget.level) {
        _animals.add(animal);
      }
    }
  }

  Widget _buildAnimal(Animal animal) {
    return WidgetTextIndicator(
      animal.getNameByLocale(context.locale),
      indicatorColor: Interface.primary,
      isShown: animal.isFromDlc,
    );
  }

  Widget _buildAnimals() {
    List<Animal> sortedAnimals = _animals.sorted(Animal.sortByNameByLocale(context));

    return WidgetPadding.a30(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: sortedAnimals.length,
        itemBuilder: (context, i) {
          return _buildAnimal(sortedAnimals.elementAt(i));
        },
      ),
    );
  }

  Widget _buildWidgets() {
    return Column(
      children: [
        WidgetSubtitle("${tr("ANIMAL_CLASS")} ${widget.level}"),
        _buildAnimals(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
