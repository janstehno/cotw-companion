import 'package:cotwcompanion/helpers/planner.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/describable/proficiency.dart';

class Skill extends Proficiency {
  Skill({
    required super.id,
    required super.name,
    required super.description,
    required super.level,
    required super.tier,
    required super.type,
    required super.ability,
  });

  @override
  bool isUnlocked(HelperPlanner helperPlanner) =>
      tier == 0 || helperPlanner.getSkillPointsFor(type, true) >= ((tier * 4) - 3);

  @override
  bool isUsable(HelperPlanner helperPlanner, int availablePoints) {
    return availablePoints - helperPlanner.getActiveSkillPoints() > 0;
  }

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['ID'],
      name: json['NAME'],
      level: json['LEVEL'],
      tier: json['TIER'],
      type: ProficiencyType.values.elementAt(json['TYPE']),
      ability: json['ABILITY'],
      description: json['DESCRIPTION'],
    );
  }
}
