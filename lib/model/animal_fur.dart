// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/values.dart';
import 'package:flutter/material.dart';

class AnimalFur {
  final int _id;
  final int _animalId, _furId;
  final int _rarity;
  final double _perCent;
  final int _male, _female;

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
        _female = female;

  int get id => _id;

  int get animalId => _animalId;

  int get furId => _furId;

  int get rarity => _rarity;

  double get perCent => _perCent;

  bool get male => _male == 1;

  bool get female => _female == 1;

  Color get color {
    switch (_rarity) {
      case 0:
        return Interface.rarityCommon;
      case 1:
        return Interface.rarityUncommon;
      case 2:
        return Interface.rarityRare;
      case 3:
        return Interface.rarityVeryRare;
      case 4:
        return Interface.rarityMission;
      case 5:
        return Interface.rarityGreatOne;
      default:
        return Interface.disabled.withOpacity(0.3);
    }
  }

  String getName(Locale locale) {
    return _rarity == 5 ? HelperJSON.getFur(Values.greatOneId).getName(locale) : HelperJSON.getFur(_furId).getName(locale);
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
