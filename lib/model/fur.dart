// Copyright (c) 2022 - 2023 Jan Stehno

import 'dart:ui';

class Fur {
  final int _id;
  final String _en, _ru, _cs, _pl, _de, _fr, _es, _br, _ja;

  Fur({
    required id,
    required en,
    required ru,
    required cs,
    required pl,
    required de,
    required fr,
    required es,
    required br,
    required ja,
  })  : _id = id,
        _en = en,
        _ru = ru,
        _cs = cs,
        _pl = pl,
        _de = de,
        _fr = fr,
        _es = es,
        _br = br,
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
      case "br":
        return _br.isEmpty ? _en : _br;
      case "pt":
        return _br.isEmpty ? _en : _br;
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
      br: json['BR'],
      ja: json['JA'],
    );
  }
}
