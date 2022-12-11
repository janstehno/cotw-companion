// Copyright (c) 2022 Jan Stehno

import 'dart:ui';

class FurList {
  List<Fur> furs;

  FurList({required this.furs});

  factory FurList.fromJson(List<dynamic> json) {
    List<Fur> furs = <Fur>[];
    furs = json.map((i) => Fur.fromJson(i)).toList();
    return FurList(furs: furs);
  }
}

class Fur {
  int id;
  String en, ru, cs, pl, de, fr, es, pt, ja;

  Fur(
      {required this.id,
      required this.en,
      required this.ru,
      required this.cs,
      required this.pl,
      required this.de,
      required this.fr,
      required this.es,
      required this.pt,
      required this.ja});

  int get getID => id;

  factory Fur.fromJson(Map<String, dynamic> json) {
    return Fur(
        id: json['ID'], en: json['EN'], ru: json['RU'], cs: json['CS'], pl: json['PL'], de: json['DE'], fr: json['FR'], es: json['ES'], pt: json['PT'], ja: json['JA']);
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
}
