// Copyright (c) 2022 Jan Stehno

import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';

class AmmoList {
  List<Ammo> ammo;

  AmmoList({required this.ammo});

  factory AmmoList.fromJson(List<dynamic> json) {
    List<Ammo> ammo = <Ammo>[];
    ammo = json.map((i) => Ammo.fromJson(i)).toList();
    return AmmoList(ammo: ammo);
  }
}

class Ammo {
  int id;
  String en, ru, cs, pl, de, fr, es, pt, ja;
  int min, max;
  int rangeM;
  double rangeYD;
  int penetration, expansion;

  Ammo(
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
      required this.min,
      required this.max,
      required this.rangeM,
      required this.rangeYD,
      required this.penetration,
      required this.expansion});

  int get getID => id;

  int get getMin => min;

  int get getMax => max;

  int get getPenetration => penetration;

  int get getExpansion => expansion;

  String get getMinMax => min == max ? min.toString() : "$min - $max";

  String getRange(bool units) => units ? "$rangeYD ${tr('yards')}" : "$rangeM ${tr('meters')}";

  String getName(Locale locale) {
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

  factory Ammo.fromJson(Map<String, dynamic> json) {
    return Ammo(
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
        min: json['MIN_LEVEL'],
        max: json['MAX_LEVEL'],
        rangeM: json['RANGE_M'],
        rangeYD: json['RANGE_YD'],
        penetration: json['PENETRATION'],
        expansion: json['EXPANSION']);
  }
}
