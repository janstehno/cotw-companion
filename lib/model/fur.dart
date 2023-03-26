// Copyright (c) 2022 Jan Stehno

import 'dart:ui';

class Fur {
  final int _id;
  final String _en, _ru, _cs, _pl, _de, _fr, _es, _pt, _ja;

  Fur({
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
  })  : _id = id,
        _en = en,
        _ru = ru,
        _cs = cs,
        _pl = pl,
        _de = de,
        _fr = fr,
        _es = es,
        _pt = pt,
        _ja = ja;

  int get id => _id;

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
        return _en;
    }
  }

  factory Fur.fromJson(Map<String, dynamic> json) {
    return Fur(
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
    );
  }
}
