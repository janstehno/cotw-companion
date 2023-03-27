// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/widgets/text_dlc.dart';
import 'package:cotwcompanion/widgets/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderWeaponAnimals extends StatefulWidget {
  final int weaponId;

  const BuilderWeaponAnimals({
    Key? key,
    required this.weaponId,
  }) : super(key: key);

  @override
  BuilderWeaponAnimalsState createState() => BuilderWeaponAnimalsState();
}

class BuilderWeaponAnimalsState extends State<BuilderWeaponAnimals> {
  final List<List<Animal>> _splitAnimals = [[], [], [], [], [], [], [], [], []];

  late final List<Animal> _animals = [];
  late final int _min, _max;

  @override
  void initState() {
    _min = HelperJSON.getWeapon(widget.weaponId).min;
    _max = HelperJSON.getWeapon(widget.weaponId).max;
    _getAnimals();
    super.initState();
  }

  void _getAnimals() {
    _animals.clear();
    for (Animal animal in HelperJSON.animals) {
      if (animal.level >= _min && animal.level <= _max) {
        _animals.add(animal);
      }
    }
    _splitByLevel();
  }

  void _splitByLevel() {
    for (Animal animal in _animals) {
      _splitAnimals[animal.level - 1].clear();
    }
    for (Animal animal in _animals) {
      _splitAnimals[animal.level - 1].add(animal);
    }
  }

  Widget _buildAnimals(List<Animal> animals) {
    animals.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      WidgetTitle.sub(
        text: "${tr('animal_class')} ${animals[0].level}",
        background: Interface.subSubTitleBackground,
      ),
      Container(
          padding: const EdgeInsets.all(30),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: animals.length,
              itemBuilder: (context, index) {
                Animal animal = animals[index];
                return WidgetTextDlc(
                  text: animal.getName(context.locale),
                  dlc: animal.isFromDlc,
                );
              }))
    ]);
  }

  Widget _buildWidgets() {
    List<List<Animal>> animals = [];
    for (List<Animal> animalList in _splitAnimals) {
      if (animalList.isNotEmpty) animals.add(animalList);
    }
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: animals.length,
        itemBuilder: (context, index) {
          return _buildAnimals(animals[index]);
        });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
