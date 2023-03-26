// Copyright (c) 2022 Jan Stehno

import 'dart:ui';

class Reserve {
  final int _id;
  final String _en, _ru, _cs, _pl, _de, _fr, _es, _pt, _ja;
  final int _count;
  final int _summer, _winter, _plains, _fields, _lowlands, _hills, _mountains, _forest;
  final int _dlc;

  Reserve({
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
    required count,
    required dlc,
    required summer,
    required winter,
    required plains,
    required fields,
    required lowlands,
    required hills,
    required mountains,
    required forest,
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
        _count = count,
        _summer = summer,
        _winter = winter,
        _plains = plains,
        _fields = fields,
        _lowlands = lowlands,
        _hills = hills,
        _mountains = mountains,
        _forest = forest,
        _dlc = dlc;

  int get id => _id;

  int get count => _count;

  bool get isFromDlc => _dlc == 1;

  bool get hasSummer => _summer == 1;

  bool get hasWinter => _winter == 1;

  bool get hasPlains => _plains == 1;

  bool get hasFields => _fields == 1;

  bool get hasLowlands => _lowlands == 1;

  bool get hasHills => _hills == 1;

  bool get hasMountains => _mountains == 1;

  bool get hasForest => _forest == 1;

  String get en => _en;

  String getName(Locale locale) {
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
        return en;
    }
  }

  factory Reserve.fromJson(Map<String, dynamic> json) {
    return Reserve(
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
      summer: json["ENVIRONMENT"]["SUMMER"],
      winter: json["ENVIRONMENT"]["WINTER"],
      plains: json["ENVIRONMENT"]["PLAINS"],
      fields: json["ENVIRONMENT"]["FIELDS"],
      lowlands: json["ENVIRONMENT"]["LOWLANDS"],
      hills: json["ENVIRONMENT"]["HILLS"],
      mountains: json["ENVIRONMENT"]["MOUNTAINS"],
      forest: json["ENVIRONMENT"]["FOREST"],
      dlc: json["DLC"],
    );
  }
}
