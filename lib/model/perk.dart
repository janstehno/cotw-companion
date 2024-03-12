// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/planner.dart';
import 'package:cotwcompanion/model/proficiency.dart';

class Perk extends Proficiency {
  List<dynamic> _parent;

  Perk({
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
    required super.level,
    required super.tier,
    required super.type,
    required super.ability,
    required parent,
  }) : _parent = parent;

  List<dynamic> get parents => _parent;

  bool isParentLeveled(HelperPlanner helperPlanner) {
    if (tier == 0) return true;
    for (int parentId in parents) {
      if (parentId != 0 && helperPlanner.getPerk(parentId).isLeveled) return true;
    }
    return false;
  }

  bool isUsable(HelperPlanner helperPlanner, int availablePoints) {
    return availablePoints - helperPlanner.getActivePerkPoints() > 0;
  }

  factory Perk.fromJson(Map<String, dynamic> json) {
    return Perk(
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
      level: json['LEVEL'],
      tier: json['TIER'],
      parent: json['PARENT'],
      type: json['TYPE'],
      ability: json['ABILITY'],
      dEn: json['DESCRIPTION']['EN'],
      dRu: json['DESCRIPTION']['RU'],
      dCs: json['DESCRIPTION']['CS'],
      dPl: json['DESCRIPTION']['PL'],
      dDe: json['DESCRIPTION']['DE'],
      dFr: json['DESCRIPTION']['FR'],
      dEs: json['DESCRIPTION']['ES'],
      dBr: json['DESCRIPTION']['BR'],
      dJa: json['DESCRIPTION']['JA'],
    );
  }
}
