// Copyright (c) 2022 Jan Stehno

import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';

class CallerList {
  List<Caller> callers;

  CallerList({required this.callers});

  factory CallerList.fromJson(List<dynamic> json) {
    List<Caller> callers = <Caller>[];
    callers = json.map((i) => Caller.fromJson(i)).toList();
    return CallerList(callers: callers);
  }
}

class Caller {
  int id;
  String en, ru, cs, pl, de, fr, es, pt, ja;
  int rangeM;
  double rangeYD;
  int duration, strength;
  int dlc;

  Caller(
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
      required this.rangeM,
      required this.rangeYD,
      required this.duration,
      required this.strength,
      required this.dlc});

  int get getID => id;

  bool get getDlc => dlc == 1;

  int get getStrength => strength;

  String get getDuration => "$duration ${tr('seconds')}";

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

  factory Caller.fromJson(Map<String, dynamic> json) {
    return Caller(
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
        rangeM: json['RANGE_M'],
        rangeYD: json['RANGE_YD'],
        duration: json['DURATION'],
        strength: json['STRENGTH'],
        dlc: json['DLC']);
  }
}
