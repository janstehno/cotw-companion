// Copyright (c) 2022 - 2023 Jan Stehno

import 'dart:ui';

import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/model/translatable.dart';
import 'package:easy_localization/easy_localization.dart';

class Animal extends Translatable {
  final int _level, _difficulty;
  final double _silver, _gold, _diamond;
  final double _trophy, _weightKG, _weightLB;
  double _trophyGO, _weightGOKG, _weightGOLB;
  final int _sight, _hearing, _smell;
  final int _diamondFemale, _grounded, _dlc;

  Animal({
    required super.id,
    required super.en,
    required super.ru,
    required super.cs,
    required super.pl,
    required super.de,
    required super.fr,
    required super.es,
    required super.br,
    required super.ja,
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
  })  : _level = level,
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

  int get level => _level;

  int get difficulty => _difficulty;

  double get silver => _silver;

  double get gold => _gold;

  double get diamond => _diamond;

  double get trophy => _trophy;

  double get trophyGO => _trophyGO;

  double get weightKG => _weightKG;

  double get weightLB => _weightLB;

  double weight(bool units) => units ? _weightLB : _weightKG;

  double get weightGOKG => _weightGOKG;

  double get weightGOLB => _weightGOLB;

  double weightGO(bool units) => units ? _weightGOLB : _weightGOKG;

  int get sight => _sight;

  int get hearing => _hearing;

  int get smell => _smell;

  bool get femaleDiamond => _diamondFemale == 1;

  bool get grounded => _grounded == 1;

  bool get isFromDlc => _dlc == 1;

  bool get hasGO => _trophyGO != -1;

  bool get hasSenses => _sight > 0 || _hearing > 0 || _smell > 0;

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
      br: json['BR'],
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

  String getNameByLocale(Locale locale) {
    if (getName(locale).split("/").length > 1) {
      return "${getName(locale).split("/")[0]} & ${getName(locale).split("/")[1]}";
    } else {
      return getName(locale);
    }
  }

  String getNameBasedOnReserve(Locale locale, int reserveId) {
    if (reserveId == -1) return getNameByLocale(locale);
    if ((locale.languageCode.toString() == "en" && id == 34 && reserveId == 5 /*Puma in PF*/) ||
        ((locale.languageCode.toString() == "en" || locale.languageCode.toString() == "cs") &&
            id == 55 &&
            (reserveId == 9 || reserveId == 14) /*Feral Pig in TANP & ECA*/) ||
        (locale.languageCode.toString() != "pl" && (id == 60 && reserveId == 10) /*Mexican Bobcat in RDA*/)) {
      return getName(locale).split("/")[0];
    } else if ((locale.languageCode.toString() == "en" && id == 34 && reserveId == 8 /*Mountain Lion in SRP*/) ||
        ((locale.languageCode.toString() == "en" || locale.languageCode.toString() == "cs") && id == 55 && reserveId == 11 /*Wild Hog in MAP*/) ||
        (locale.languageCode.toString() != "pl" && (id == 60 && reserveId == 13) /*Bobcat in NEM*/)) {
      return getName(locale).split("/")[1];
    } else {
      return getName(locale);
    }
  }

  String trophyAsString(double trophy) => Utils.removePointZero(trophy);

  String weightAsString(bool units) => "${Utils.removePointZero(weight(units))} ${units ? tr("pounds") : tr("kilograms")}";

  String weightGOAsString(bool units) => "${Utils.removePointZero(weightGO(units))} ${units ? tr("pounds") : tr("kilograms")}";
}
