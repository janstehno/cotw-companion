import 'package:cotwcompanion/helpers/planner.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/describable/proficiency.dart';

class Perk extends Proficiency {
  List<dynamic> _parent;

  Perk({
    required super.id,
    required super.name,
    required super.description,
    required super.level,
    required super.tier,
    required super.type,
    required super.ability,
    required List<dynamic> parent,
  }) : _parent = parent;

  List<dynamic> get parents => _parent;

  @override
  bool isUnlocked(HelperPlanner helperPlanner) {
    if (tier == 0) return true;
    for (int parentId in _parent) {
      if (helperPlanner.getPerk(parentId).isLeveled) return true;
    }
    return false;
  }

  @override
  bool isUsable(HelperPlanner helperPlanner, int availablePoints) {
    return availablePoints - helperPlanner.getActivePerkPoints() > 0;
  }

  factory Perk.fromJson(Map<String, dynamic> json) {
    return Perk(
      id: json['ID'],
      name: json['NAME'],
      level: json['LEVEL'],
      tier: json['TIER'],
      parent: json['PARENT'],
      type: ProficiencyType.values.elementAt(json['TYPE']),
      ability: json['ABILITY'],
      description: json['DESCRIPTION'],
    );
  }
}
