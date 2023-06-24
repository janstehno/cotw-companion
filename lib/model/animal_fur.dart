// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class AnimalFur {
  final int _id;
  final int _animalId, _furId;
  final int _rarity;
  final double _perCent;
  final int _male, _female;
  bool _chosen;

  AnimalFur({
    required id,
    required animalId,
    required furId,
    required rarity,
    required perCent,
    required male,
    required female,
    required chosen,
  })  : _id = id,
        _animalId = animalId,
        _furId = furId,
        _rarity = rarity,
        _perCent = perCent,
        _male = male,
        _female = female,
        _chosen = chosen;

  int get id => _id;

  int get animalId => _animalId;

  int get furId => _furId;

  int get rarity => _rarity;

  double get perCent => _perCent;

  bool get male => _male == 1;

  bool get female => _female == 1;

  bool get isChosen => _chosen;

  set chosen(bool chosen) => _chosen = chosen;

  Color get color {
    switch (_rarity) {
      case 1:
        return Interface.veryrare;
      case 2:
        return Interface.rare;
      case 3:
        return Interface.uncommon;
      case 4:
        return Interface.common;
      default:
        return Interface.mission;
    }
  }

  String getName(Locale locale) {
    return _furId == Interface.greatOneId
        ? HelperJSON.getFur(HelperJSON.furs.length).getName(locale)
        : HelperJSON.getFur(_furId).getName(locale);
  }

  factory AnimalFur.fromJson(Map<String, dynamic> json) {
    return AnimalFur(
      id: json['ID'],
      animalId: json['ANIMAL_ID'],
      furId: json['FUR_ID'],
      rarity: json['RARITY'],
      perCent: json['PERCENT'],
      male: json['MALE'],
      female: json['FEMALE'],
      chosen: false,
    );
  }
}
