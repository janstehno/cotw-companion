// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';

class AnimalFurList {
  List<AnimalFur> animalFurs;

  AnimalFurList({required this.animalFurs});

  factory AnimalFurList.fromJson(List<dynamic> json) {
    List<AnimalFur> animalFurs = <AnimalFur>[];
    animalFurs = json.map((i) => AnimalFur.fromJson(i)).toList();
    return AnimalFurList(animalFurs: animalFurs);
  }
}

class AnimalFur {
  int id;
  int animalID, furID;
  int rarity;
  double perCent;
  int male, female;
  bool chosen;

  AnimalFur({required this.id,
    required this.animalID,
    required this.furID,
    required this.rarity,
    required this.perCent,
    required this.male,
    required this.female,
    required this.chosen});

  int get getID => id;

  int get getAnimalID => animalID;

  int get getFurID => furID;

  int get getRarity => rarity;

  double get getPerCent => perCent;

  bool get getMale => male == 1;

  bool get getFemale => female == 1;

  bool get getChosen => chosen;

  String getName(Locale locale) {
    return furID == Values.greatOneID
        ? JSONHelper.getFur(JSONHelper.furs.length).getName(locale)
        : furID > 44 //BECAUSE OF AN ERROR IN THE RAW FURS JSON
            ? JSONHelper.getFur(furID - 2).getName(locale)
            : JSONHelper.getFur(furID).getName(locale);
  }

  int getColor() {
    switch (rarity) {
      case 1:
        return Values.colorRarityVeryRare;
      case 2:
        return Values.colorRarityRare;
      case 3:
        return Values.colorRarityUncommon;
      case 4:
        return Values.colorRarityCommon;
      default:
        return Values.colorRarityMission;
    }
  }

  setChosen(bool b) {
    chosen = b;
  }

  factory AnimalFur.fromJson(Map<String, dynamic> json) {
    return AnimalFur(
        id: json['ID'],
        animalID: json['ANIMAL_ID'],
        furID: json['FUR_ID'],
        rarity: json['RARITY'],
        perCent: json['PERCENT'],
        male: json['MALE'],
        female: json['FEMALE'],
        chosen: false);
  }
}
