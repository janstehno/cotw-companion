// Copyright (c) 2022 Jan Stehno

import 'dart:ui';

class Reserve {
  int id;
  String en, ru, cs, pl, de, fr, es, pt, ja;
  int count;
  int summer, winter, plains, fields, lowlands, hills, mountains, forest;
  int dlc;

  Reserve({
    required this.id,
    required this.en,
    required this.ru,
    required this.cs,
    required this.pl,
    required this.de,
    required this.fr,
    required this.es,
    required this.pt,
    required this.ja,
    required this.count,
    required this.dlc,
    required this.summer,
    required this.winter,
    required this.plains,
    required this.fields,
    required this.lowlands,
    required this.hills,
    required this.mountains,
    required this.forest,
  });

  int get getID => id;

  int get getCount => count;

  bool get getDlc => dlc == 1;

  bool get getSummer => summer == 1;

  bool get getWinter => winter == 1;

  bool get getPlains => plains == 1;

  bool get getFields => fields == 1;

  bool get getLowlands => lowlands == 1;

  bool get getHills => hills == 1;

  bool get getMountains => mountains == 1;

  bool get getForest => forest == 1;

  String getNameEN() {
    return en;
  }

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

  factory Reserve.fromJson(Map<String, dynamic> json) => Reserve(
        id: json["ID"],
        en: json["EN"],
        ru: json["RU"],
        cs: json["CS"],
        pl: json["PL"],
        de: json["DE"],
        fr: json["FR"],
        es: json["ES"],
        pt: json["PT"],
        ja: json['JA'],
        count: json["COUNT"],
        dlc: json["DLC"],
        summer: json["ENVIRONMENT"]["SUMMER"],
        winter: json["ENVIRONMENT"]["WINTER"],
        plains: json["ENVIRONMENT"]["PLAINS"],
        fields: json["ENVIRONMENT"]["FIELDS"],
        lowlands: json["ENVIRONMENT"]["LOWLANDS"],
        hills: json["ENVIRONMENT"]["HILLS"],
        mountains: json["ENVIRONMENT"]["MOUNTAINS"],
        forest: json["ENVIRONMENT"]["FOREST"],
      );
}
