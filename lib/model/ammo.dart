// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/model/translatable.dart';
import 'package:easy_localization/easy_localization.dart';

class Ammo extends Translatable {
  final int _min, _max;
  final int _rangeM;
  final double _rangeYD;
  final int _penetration, _expansion, _price, _score;
  final int _dlc;

  Ammo({
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
    required min,
    required max,
    required rangeM,
    required rangeYD,
    required penetration,
    required expansion,
    required price,
    required score,
    required dlc,
  })  : _min = min,
        _max = max,
        _rangeM = rangeM,
        _rangeYD = rangeYD,
        _penetration = penetration,
        _expansion = expansion,
        _price = price,
        _score = score,
        _dlc = dlc;

  int get min => _min;

  int get max => _max;

  int get penetration => _penetration;

  int get expansion => _expansion;

  int get price => _price;

  int get score => _score;

  int get dlc => _dlc;

  bool get isFromDlc => _dlc == 1;

  bool get hasRequirements => _score > 0;

  String get classRange => _min == _max ? _min.toString() : "$_min - $_max";

  String getRange(bool units) => units ? "$_rangeYD ${tr("yards")}" : "$_rangeM ${tr("meters")}";

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
      br: json['BR'],
      ja: json['JA'],
      min: json['MIN_LEVEL'],
      max: json['MAX_LEVEL'],
      rangeM: json['RANGE_M'],
      rangeYD: json['RANGE_YD'],
      penetration: json['PENETRATION'],
      expansion: json['EXPANSION'],
      price: json['PRICE'],
      score: json['SCORE'],
      dlc: json['DLC'],
    );
  }
}
