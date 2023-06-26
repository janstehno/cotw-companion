// Copyright (c) 2022 - 2023 Jan Stehno

import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';

class Animal {
  final int _id;
  final String _en, _ru, _cs, _pl, _de, _fr, _es, _pt, _ja;
  final int _level, _difficulty;
  final double _silver, _gold, _diamond;
  final double _trophy, _weightKG, _weightLB;
  double _trophyGO, _weightGOKG, _weightGOLB;
  final int _sight, _hearing, _smell;
  final int _diamondFemale, _grounded, _dlc;

  Animal({
    required id,
    required en,
    required ru,
    required cs,
    required pl,
    required de,
    required fr,
    required es,
    required pt,
    required ja,
    required level,
    required difficulty,
    required silver,
    required gold,
    required diamond,
    required trophy,
    required weightKG,
    required weightLB,
    required trophyGO,
    required weightGOKG,
    required weightGOLB,
    required sight,
    required hearing,
    required smell,
    required diamondFemale,
    required grounded,
    required dlc,
  })  : _id = id,
        _en = en,
        _ru = ru,
        _cs = cs,
        _pl = pl,
        _de = de,
        _fr = fr,
        _es = es,
        _pt = pt,
        _ja = ja,
        _level = level,
        _difficulty = difficulty,
        _silver = silver,
        _gold = gold,
        _diamond = diamond,
        _trophy = trophy,
        _weightKG = weightKG,
        _weightLB = weightLB,
        _trophyGO = trophyGO,
        _weightGOKG = weightGOKG,
        _weightGOLB = weightGOLB,
        _sight = sight,
        _hearing = hearing,
        _smell = smell,
        _diamondFemale = diamondFemale,
        _grounded = grounded,
        _dlc = dlc;

  int get id => _id;

  int get level => _level;

  int get difficulty => _difficulty;

  double get silver => _silver;

  double get gold => _gold;

  double get diamond => _diamond;

  double get trophy => _trophy;

  double get trophyGO => _trophyGO;

  double get weightKG => _weightKG;

  double get weightLB => _weightLB;

  double get weightGOKG => _weightGOKG;

  double get weightGOLB => _weightGOLB;

  int get sight => _sight;

  int get hearing => _hearing;

  int get smell => _smell;

  bool get femaleDiamond => _diamondFemale == 1;

  bool get grounded => _grounded == 1;

  bool get isFromDlc => _dlc == 1;

  bool get hasGO => _trophyGO != -1;

  bool get hasSenses => _sight > 0 || _hearing > 0 || _smell > 0;

  String get en => _en;

  set setTrophyGO(double value) => _trophyGO = value;

  set setWeightGOKG(double value) => _weightGOKG = value;

  set setWeightGOLB(double value) => _weightGOLB = value;

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
      trophyGO: json['TROPHY_GO'] ?? -1.0,
      weightGOKG: json['WEIGHT_GO_KG'] ?? -1.0,
      weightGOLB: json['WEIGHT_GO_LB'] ?? -1.0,
      sight: json['SIGHT'],
      hearing: json['HEARING'],
      smell: json['SMELL'],
      diamondFemale: json['DIAMOND_FEMALE'] ?? 0,
      grounded: json['GROUNDED'] ?? 0,
      dlc: json['DLC'],
    );
    return animal;
  }

  String getNameENBasedOnReserve(int reserveId) => getNameBasedOnReserve(const Locale("en"), reserveId);

  String getNameBasedOnReserve(Locale locale, int reserveId) {
    if (reserveId == -1) return getName(locale);
    if ((locale.languageCode.toString() == "en" && _id == 34 && reserveId == 5 /*Puma in PF*/) ||
        ((locale.languageCode.toString() == "en" || locale.languageCode.toString() == "cs") &&
            _id == 55 &&
            (reserveId == 9 || reserveId == 14) /*Feral Pig in TANP & ECA*/) ||
        (locale.languageCode.toString() != "pl" && (_id == 60 && reserveId == 10) /*Mexican Bobcat in RDA*/)) {
      return getNameByLocale(locale).split("/")[0];
    } else if ((locale.languageCode.toString() == "en" && _id == 34 && reserveId == 8 /*Mountain Lion in SRP*/) ||
        ((locale.languageCode.toString() == "en" || locale.languageCode.toString() == "cs") &&
            _id == 55 &&
            reserveId == 11 /*Wild Hog in MAP*/) ||
        (locale.languageCode.toString() != "pl" && (_id == 60 && reserveId == 13) /*Bobcat in NEM*/)) {
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
        return _ru.isEmpty ? _en : _ru;
      case "cs":
        return _cs.isEmpty ? _en : _cs;
      case "pl":
        return _pl.isEmpty ? _en : _pl;
      case "de":
        return _de.isEmpty ? _en : _de;
      case "fr":
        return _fr.isEmpty ? _en : _fr;
      case "es":
        return _es.isEmpty ? _en : _es;
      case "pt":
        return _pt.isEmpty ? _en : _pt;
      case "ja":
        return _ja.isEmpty ? _en : _ja;
      case "sk":
        return _cs.isEmpty ? _en : _cs;
      default:
        return _en;
    }
  }

  String removePointZero(String value) {
    String text = value;
    List<String> tmp = text.split(".");
    List<String> split = tmp[1].split(" ");
    if (int.parse(split[0]) == 0) {
      (split.length == 2 && split[1].isNotEmpty) ? text = tmp[0] + (" ${split[1]}") : text = tmp[0];
    }
    return text;
  }

  String getWeight(bool units) => units ? "$_weightLB ${tr('pounds')}" : "$_weightKG ${tr('kilograms')}";

  String getWeightGO(bool units) => units ? "$_weightGOLB ${tr('pounds')}" : "$_weightGOKG ${tr('kilograms')}";

  double getWeightWithoutUnits(bool units) => units ? _weightLB : _weightKG;

  double getWeightGOWithoutUnits(bool units) => units ? _weightGOLB : _weightGOKG;
}
