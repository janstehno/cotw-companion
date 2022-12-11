// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/model/weapon.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_with_dlc.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderWeaponAnimals extends StatefulWidget {
  final int weaponID;

  const BuilderWeaponAnimals({Key? key, required this.weaponID}) : super(key: key);

  @override
  BuilderWeaponAnimalsState createState() => BuilderWeaponAnimalsState();
}

class BuilderWeaponAnimalsState extends State<BuilderWeaponAnimals> {
  late final List<Animal> _animals = [];

  late List<List<Animal>> _splitAnimals;

  int _min = 9;
  int _max = 0;

  _getMinMax() {
    for (Weapon w in JSONHelper.weaponsInfo) {
      if (w.getID == widget.weaponID) {
        if (w.getMin < _min) _min = w.getMin;
        if (w.getMax > _max) _max = w.getMax;
      }
    }
  }

  _getAnimals() {
    _getMinMax();
    _animals.clear();
    for (Animal a in JSONHelper.animals) {
      if (a.getLevel >= _min && a.getLevel <= _max) {
        _animals.add(a);
      }
    }
    _splitByLevel();
  }

  _splitByLevel() {
    _splitAnimals = [[], [], [], [], [], [], [], [], []];
    for (Animal a in _animals) {
      _splitAnimals[a.getLevel - 1].add(a);
    }
  }

  Widget _buildAnimals(List<Animal> animals) {
    animals.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      WidgetTitle.detail(text: "${tr('animal_class')} ${animals[0].getLevel}"),
      Container(
          padding: const EdgeInsets.all(30),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: animals.length,
              itemBuilder: (context, index) {
                Animal a = animals[index];
                return EntryWithDlc(text: a.getName(context.locale), dlc: a.getDlc);
              }))
    ]);
  }

  Widget _buildWidgets() {
    List<List<Animal>> animals = [];
    for (List<Animal> a in _splitAnimals) {
      if (a.isNotEmpty) animals.add(a);
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
  Widget build(BuildContext context) {
    _getAnimals();
    return _buildWidgets();
  }
}
