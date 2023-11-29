// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/widgets/text_dlc.dart';
import 'package:cotwcompanion/widgets/title_small.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListWeaponAnimals extends StatefulWidget {
  final int min, max;

  const ListWeaponAnimals({
    Key? key,
    required this.min,
    required this.max,
  }) : super(key: key);

  @override
  ListWeaponAnimalsState createState() => ListWeaponAnimalsState();
}

class ListWeaponAnimalsState extends State<ListWeaponAnimals> {
  final List<List<Animal>> _splitAnimals = [[], [], [], [], [], [], [], [], []];

  late final List<Animal> _animals = [];

  void _getAnimals() {
    _animals.clear();
    for (Animal animal in HelperJSON.animals) {
      if (animal.level >= widget.min && animal.level <= widget.max) {
        _animals.add(animal);
      }
    }
    _splitByLevel();
  }

  List<List<Animal>> _reduceEmptyLists() {
    List<List<Animal>> animals = [];
    for (List<Animal> animalList in _splitAnimals) {
      if (animalList.isNotEmpty) animals.add(animalList);
    }
    return animals;
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
    animals.sort((a, b) => a.getNameByLocale(context.locale).compareTo(b.getNameByLocale(context.locale)));
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      WidgetTitleSmall(
        primaryText: "${tr("animal_class")} ${animals[0].level}",
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
                  text: animal.getNameByLocale(context.locale),
                  dlc: animal.isFromDlc,
                );
              }))
    ]);
  }

  Widget _buildWidgets() {
    _getAnimals();
    List<List<Animal>> animals = _reduceEmptyLists();
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
