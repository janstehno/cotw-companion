// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/planner.dart';
import 'package:cotwcompanion/model/proficiency.dart';

class Skill extends Proficiency {
  Skill({
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
  });

  bool isUnlocked(HelperPlanner helperPlanner) => tier == 0 || helperPlanner.getSkillPointsFor(ProficiencyType.values.elementAt(type), true) >= ((tier * 4) - 3);

  bool isUsable(HelperPlanner helperPlanner, int availablePoints) {
    return availablePoints - helperPlanner.getActiveSkillPoints() > 0;
  }

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
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
