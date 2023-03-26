// Copyright (c) 2022 Jan Stehno

import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';

class Ammo {
  final int _id;
  final String _en, _ru, _cs, _pl, _de, _fr, _es, _pt, _ja;
  final int _min, _max;
  final int _rangeM;
  final double _rangeYD;
  final int _penetration, _expansion;
  final int _dlc;

  Ammo({
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
    required min,
    required max,
    required rangeM,
    required rangeYD,
    required penetration,
    required expansion,
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
        _min = min,
        _max = max,
        _rangeM = rangeM,
        _rangeYD = rangeYD,
        _penetration = penetration,
        _expansion = expansion,
        _dlc = dlc;

  int get id => _id;

  int get min => _min;

  int get max => _max;

  int get penetration => _penetration;

  int get expansion => _expansion;

  int get dlc => _dlc;

  bool get isFromDlc => _dlc == 1;

  String get classRange => _min == _max ? _min.toString() : "$_min - $_max";

  String getRange(bool units) => units ? "$_rangeYD ${tr('yards')}" : "$_rangeM ${tr('meters')}";

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
      expansion: json['EXPANSION'],
      dlc: json['DLC'],
    );
  }
}
