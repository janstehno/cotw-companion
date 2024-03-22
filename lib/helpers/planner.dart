import 'dart:convert';

import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/logger.dart';
import 'package:cotwcompanion/model/describable/perk.dart';
import 'package:cotwcompanion/model/describable/proficiency.dart';
import 'package:cotwcompanion/model/describable/skill.dart';

class HelperPlanner {
  final HelperLogger _logger = HelperLogger.loadingPlanner();

  final List<Perk> _perks = [];
  final List<Skill> _skills = [];

  Perk getPerk(int perkId) {
    try {
      return _perks.firstWhere((e) => e.id == perkId);
    } catch (e) {
      throw Exception("Perk with ID: $perkId does not exist");
    }
  }

  Skill getSkill(int skillId) {
    try {
      return _skills.firstWhere((e) => e.id == skillId);
    } catch (e) {
      throw Exception("Perk with ID: $skillId does not exist");
    }
  }

  void setPerks(List<Perk> perks) {
    _logger.i("Initializing perks in HelperPlanner...");
    _perks.clear();
    _perks.addAll(perks);
    _logger.t("Perks initialized");
  }

  void setSkills(List<Skill> skills) {
    _logger.i("Initializing skills in HelperPlanner...");
    _skills.clear();
    _skills.addAll(skills);
    _logger.t("Skills initialized");
  }

  Map<int, List<Perk>> getPerksFor(ProficiencyType type) {
    Map<int, List<Perk>> perks = {0: [], 1: [], 2: [], 3: []};
    for (Perk perk in _perks) {
      if (perk.type == type) perks[perk.tier]!.add(perk);
    }
    return perks;
  }

  Map<int, List<Skill>> getSkillsFor(ProficiencyType type) {
    Map<int, List<Skill>> perks = {0: [], 1: [], 2: [], 3: [], 4: []};
    for (Skill skill in _skills) {
      if (skill.type == type) perks[skill.tier]!.add(skill);
    }
    return perks;
  }

  void resetSkillsFor(ProficiencyType type) {
    for (Skill skill in _skills) {
      if (skill.type == type) skill.resetLevel();
    }
  }

  void resetPerksFor(ProficiencyType type) {
    for (Perk perk in _perks) {
      if (perk.type == type) perk.resetLevel();
    }
  }

  int getSkillPointsFor(ProficiencyType type, bool actual) {
    int points = 0;
    for (Proficiency skill in _skills) {
      if (skill.type == type) points += actual ? skill.actualLevel : skill.level;
    }
    return points;
  }

  int getPerkPointsFor(ProficiencyType type, bool actual) {
    int points = 0;
    for (Perk perk in _perks) {
      if (perk.type == type) points += actual ? perk.actualLevel : perk.level;
    }
    return points;
  }

  int getActiveSkillPoints() {
    int points = 0;
    for (Proficiency skill in _skills) {
      points += skill.actualLevel;
    }
    return points;
  }

  int getActivePerkPoints() {
    int points = 0;
    for (Perk perk in _perks) {
      points += perk.actualLevel;
    }
    return points;
  }

  Future<List<Perk>> readPerks() async {
    try {
      final data = await HelperJSON.getData(Assets.raw.perks);
      final list = json.decode(data) as List<dynamic>;
      final List<Perk> perks = list.map((e) => Perk.fromJson(e)).toList();
      _logger.t("${perks.length} perks loaded");
      return perks;
    } catch (e) {
      _logger.w("Perks not loaded");
      rethrow;
    }
  }

  Future<List<Skill>> readSkills() async {
    try {
      final data = await HelperJSON.getData(Assets.raw.skills);
      final list = json.decode(data) as List<dynamic>;
      final List<Skill> skills = list.map((e) => Skill.fromJson(e)).toList();
      _logger.t("${skills.length} skills loaded");
      return skills;
    } catch (e) {
      _logger.w("Skills not loaded");
      rethrow;
    }
  }
}
