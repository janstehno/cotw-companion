// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/describable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Mission extends Describable {
  final int _type, _difficulty, _giver, _reserve;

  Mission({
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
    required super.dEn,
    required super.dRu,
    required super.dCs,
    required super.dPl,
    required super.dDe,
    required super.dFr,
    required super.dEs,
    required super.dBr,
    required super.dJa,
    required type,
    required difficulty,
    required giver,
    required reserve,
  })  : _type = type,
        _difficulty = difficulty,
        _giver = giver,
        _reserve = reserve;

  int get type => _type;

  int get difficulty => _difficulty;

  int get giverId => _giver;

  int get reserveId => _reserve;

  String getTypeAsString() {
    return _type == 0 ? tr("mission_main") : tr("mission_side");
  }

  String getDifficultyAsString() {
    switch (difficulty) {
      case 1:
        return tr("difficulty_easy");
      case 2:
        return tr("difficulty_mediocre");
      case 3:
        return tr("difficulty_hard");
      case 4:
        return tr("difficulty_very_hard");
      default:
        return tr("none");
    }
  }

  Color getDifficultyColor() {
    switch (difficulty) {
      case 1:
        return Interface.green;
      case 2:
        return Interface.yellow;
      case 3:
        return Interface.orange;
      case 4:
        return Interface.red;
      default:
        return Colors.transparent;
    }
  }

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
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
      type: json['TYPE'],
      difficulty: json['DIFFICULTY'],
      giver: json['GIVER'],
      reserve: json['RESERVE'],
      dEn: json['OBJECTIVES']['EN'],
      dRu: json['OBJECTIVES']['RU'],
      dCs: json['OBJECTIVES']['CS'],
      dPl: json['OBJECTIVES']['PL'],
      dDe: json['OBJECTIVES']['DE'],
      dFr: json['OBJECTIVES']['FR'],
      dEs: json['OBJECTIVES']['ES'],
      dBr: json['OBJECTIVES']['BR'],
      dJa: json['OBJECTIVES']['JA'],
    );
  }
}
