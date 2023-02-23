// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:flutter/material.dart';

class HelperMap {
  static final List<Animal> _animals = [];
  static final List<String> _names = [];

  static final List<bool> _activeE = [
    true, //OUTPOSTS
    true, //LOOKOUTS
    false //HIDES
  ];
  static final List<int> _colorsE = [
    Values.colorDark, //OUTPOSTS
    Values.colorDark, //LOOKOUTS
    Values.colorDark //HIDES
  ];
  static final List<bool> _active = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
  static const List<int> _colors = [
    0xFF7C4DFF,
    0xFFAB47BC,
    0xFFE91E63,
    0xFFF44336,
    0xFFFF5722,
    0xFFFF9800,
    0xFFFFC107,
    0xFFFFEB3B,
    0xFFCDDC39,
    0xFF8BC34A,
    0xFF4CAF50,
    0xFF009688,
    0xFF00BCD4,
    0xFF03A9F4,
    0xFF2196F3,
    0xFF3D5AFE,
    0xFF607D8B,
    0xFF9E9E9E,
    0xFF8D6E63
  ];

  static List<Animal> get getAnimals => _animals;

  static List<String> get getNames => _names;

  static Animal getAnimal(int i) => _animals[i];

  static String getName(int i) => _names[i];

  static bool isActive(int i) => _active[i];

  static bool isActiveE(int i) => _activeE[i];

  static int getColor(int i) => _colors[i];

  static int getColorE(int i) => _colorsE[i];

  static double getOpacity(int i) => isActive(i) ? 1 : 0;

  static double getOpacityE(int i) => isActiveE(i) ? 1 : 0;

  static activate(int i) {
    _active[i] = (!_active[i]);
  }

  static activateE(int i) {
    _activeE[i] = (!_activeE[i]);
  }

  static isAnimalLayerActive() => _active.contains(true);

  static clearMap() {
    _animals.clear();
    _names.clear();
    for (int i = 0; i < _activeE.length; i++) {
      _activeE[i] = (i == 0 || i == 1) ? true : false;
    }
    for (int i = 0; i < _active.length; i++) {
      _active[i] = false;
    }
  }

  static addAnimal(Animal a) {
    _animals.add(a);
  }

  static addNames(Locale locale, int reserveID) {
    _animals.sort((a, b) => a.getNameBasedOnReserve(locale, reserveID).compareTo(b.getNameBasedOnReserve(locale, reserveID)));
    for (Animal a in _animals) {
      _names.add(a.getNameBasedOnReserve(locale, reserveID));
    }
  }
}
