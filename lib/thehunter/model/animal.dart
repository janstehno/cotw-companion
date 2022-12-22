// Copyright (c) 2022 Jan Stehno

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';

class AnimalList {
  List<Animal> animals;

  AnimalList({required this.animals});

  factory AnimalList.fromJson(List<dynamic> json) {
    List<Animal> animals = <Animal>[];
    animals = json.map((i) => Animal.fromJson(i)).toList();
    return AnimalList(animals: animals);
  }
}

class Animal {
  int id;
  String en, ru, cs, pl, de, fr, es, pt, ja;
  int level, difficulty;
  double silver, gold, diamond;
  double trophy, trophyGO;
  double weightKG, weightLB, weightGOKG, weightGOLB;
  int sight, hearing, smell;
  int dlc;

  Animal(
      {required this.id,
      required this.en,
      required this.ru,
      required this.cs,
      required this.pl,
      required this.de,
      required this.fr,
      required this.es,
      required this.pt,
      required this.ja,
      required this.level,
      required this.difficulty,
      required this.silver,
      required this.gold,
      required this.diamond,
      required this.trophy,
      this.trophyGO = 0.0,
      required this.weightKG,
      required this.weightLB,
      this.weightGOKG = 0.0,
      this.weightGOLB = 0.0,
      required this.sight,
      required this.hearing,
      required this.smell,
      required this.dlc});

  int get getID => id;

  int get getLevel => level;

  int get getDifficulty => difficulty;

  double get getSilver => silver;

  double get getGold => gold;

  double get getDiamond => diamond;

  double get getTrophy => trophy;

  double get getTrophyGO => trophyGO;

  double get getWeightKG => weightKG;

  double get getWeightLB => weightLB;

  double get getWeightGOKG => weightGOKG;

  double get getWeightGOLB => weightGOLB;

  int get getSight => sight;

  int get getHearing => hearing;

  int get getSmell => smell;

  bool get getDlc => dlc == 1;

  bool get getGO => trophyGO != 0;

  bool get getSenses => getSight > 0 || getHearing > 0 || getSmell > 0;

  setTrophyGO(double d) {
    trophyGO = d;
  }

  setWeightGOKG(double d) {
    weightGOKG = d;
  }

  setWeightGOLB(double d) {
    weightGOLB = d;
  }

  factory Animal.fromJson(Map<String, dynamic> json) {
    Animal animal = Animal(
        id: json['ID'],
        en: json['EN'],
        ru: json['RU'],
        cs: json['CS'],
        pl: json['PL'],
        de: json['DE'],
        fr: json['FR'],
        es: json['ES'],
        pt: json['PT'],
        ja: json['JA'],
        level: json['LEVEL'],
        difficulty: json['DIFFICULTY'],
        silver: json['SILVER'],
        gold: json['GOLD'],
        diamond: json['DIAMOND'],
        trophy: json['TROPHY'],
        weightKG: json['WEIGHT_KG'],
        weightLB: json['WEIGHT_LB'],
        sight: json['SIGHT'],
        hearing: json['HEARING'],
        smell: json['SMELL'],
        dlc: json['DLC']);
    //GREAT ONES
    if (json['ID'] == 4 || json['ID'] == 35 || json['ID'] == 51) {
      animal.setTrophyGO(json['TROPHY_GO']);
      animal.setWeightGOKG(json['WEIGHT_GO_KG']);
      animal.setWeightGOLB(json['WEIGHT_GO_LB']);
    }
    return animal;
  }

  String getWeight(bool units) => units ? "$weightLB ${tr('pounds')}" : "$weightKG ${tr('kilograms')}";

  String getWeightGO(bool units) => units ? "$weightGOLB ${tr('pounds')}" : "$weightGOKG ${tr('kilograms')}";

  double getWeightWithoutUnits(bool units) => units ? weightLB : weightKG;

  double getWeightGOWithoutUnits(bool units) => units ? weightGOLB : weightGOKG;

  String getNameEN() => en;

  String getNameENBasedOnReserve(int reserveID) {
    if ((id == 34 && reserveID == 5) || (id == 55 && reserveID == 9) || (id == 60 && reserveID == 10)) {
      return en.split("/")[0];
    } else if ((id == 34 && reserveID == 8) || (id == 55 && reserveID == 11) || (id == 60 && reserveID == 13)) {
      return en.split("/")[1];
    } else {
      return getNameEN();
    }
  }

  String getNameBasedOnReserve(Locale locale, int reserveID) {
    if (reserveID == -1) return getName(locale);
    if ((locale.languageCode.toString() == "en" && id == 34 && reserveID == 5) ||
        ((locale.languageCode.toString() == "en" || locale.languageCode.toString() == "cs") && id == 55 && reserveID == 9) ||
        (id == 60 && reserveID == 10)) {
      return getNameByLocale(locale).split("/")[0];
    } else if ((locale.languageCode.toString() == "en" && id == 34 && reserveID == 8) ||
        ((locale.languageCode.toString() == "en" || locale.languageCode.toString() == "cs") && id == 55 && reserveID == 11) ||
        (id == 60 && reserveID == 13)) {
      return getNameByLocale(locale).split("/")[1];
    } else {
      return getName(locale);
    }
  }

  String getName(Locale locale) {
    if (getNameByLocale(locale).split("/").length > 1) {
      return "${getNameByLocale(locale).split("/")[0]} & ${getNameByLocale(locale).split("/")[1]}";
    } else {
      return getNameByLocale(locale);
    }
  }

  String getNameByLocale(Locale locale) {
    switch (locale.languageCode.toString()) {
      case "ru":
        return ru.isEmpty ? en : ru;
      case "cs":
        return cs.isEmpty ? en : cs;
      case "pl":
        return pl.isEmpty ? en : pl;
      case "de":
        return de.isEmpty ? en : de;
      case "fr":
        return fr.isEmpty ? en : fr;
      case "es":
        return es.isEmpty ? en : es;
      case "pt":
        return pt.isEmpty ? en : pt;
      case "ja":
        return ja.isEmpty ? en : ja;
      case "sk":
        return cs.isEmpty ? en : cs;
      default:
        return en;
    }
  }

  String removePointZero(String s) {
    String text = s;
    List<String> tmp = text.split(".");
    List<String> split = tmp[1].split(" ");
    if (int.parse(split[0]) == 0) {
      (split.length == 2 && split[1].isNotEmpty) ? text = tmp[0] + (" ${split[1]}") : text = tmp[0];
    }
    return text;
  }

  String getAnatomyAsset(String part) {
    String asset = "assets/graphics/anatomy/";
    asset += getNameEN().split("/")[0].replaceAll(" ", "").toLowerCase();
    asset += "_$part";
    asset += ".svg";
    return asset;
  }
}
