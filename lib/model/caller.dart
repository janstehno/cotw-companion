// Copyright (c) 2022 - 2023 Jan Stehno

import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';

class Caller {
  final int _id;
  final String _en, _ru, _cs, _pl, _de, _fr, _es, _pt, _ja;
  final int _rangeM;
  final double _rangeYD;
  final int _duration, _strength, _price;
  final int _dlc;

  Caller(
      {required id,
      required en,
      required ru,
      required cs,
      required pl,
      required de,
      required fr,
      required es,
      required pt,
      required ja,
      required rangeM,
      required rangeYD,
      required duration,
      required strength,
      required price,
      required dlc})
      : _id = id,
        _en = en,
        _ru = ru,
        _cs = cs,
        _pl = pl,
        _de = de,
        _fr = fr,
        _es = es,
        _pt = pt,
        _ja = ja,
        _rangeM = rangeM,
        _rangeYD = rangeYD,
        _duration = duration,
        _strength = strength,
        _price = price,
        _dlc = dlc;

  int get id => _id;

  int get strength => _strength;

  int get duration => _duration;

  int get price => _price;

  bool get isFromDlc => _dlc == 1;

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
        price: json['PRICE'],
        dlc: json['DLC']);
  }
}
