// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/model/translatable.dart';

class Reserve extends Translatable {
  final int _count;
  final int _summer, _winter, _plains, _fields, _lowlands, _hills, _mountains, _forest;
  final int _dlc;

  Reserve({
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
  })  : _count = count,
        _summer = summer,
        _winter = winter,
        _plains = plains,
        _fields = fields,
        _lowlands = lowlands,
        _hills = hills,
        _mountains = mountains,
        _forest = forest,
        _dlc = dlc;

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

  List<int> get allClasses {
    List<int> classes = [];
    for (IdtoId iti in HelperJSON.animalsReserves) {
      if (iti.secondId == id) {
        int level = HelperJSON.getAnimal(iti.firstId).level;
        if (!classes.contains(level)) {
          classes.add(level);
        }
      }
    }
    return classes;
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
      br: json["BR"],
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
