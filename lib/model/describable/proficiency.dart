import 'package:cotwcompanion/helpers/planner.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/describable/describable.dart';

abstract class Proficiency extends Describable {
  final int _level;
  final int _tier;
  final ProficiencyType _type;
  final bool _ability;

  int _actualLevel = 0;

  Proficiency({
    required super.id,
    required super.name,
    required super.description,
    required int level,
    required int tier,
    required ProficiencyType type,
    required bool ability,
  })  : _level = level,
        _tier = tier,
        _type = type,
        _ability = ability;

  int get level => _level;

  int get tier => _tier;

  ProficiencyType get type => _type;

  bool get isAbility => _ability;

  int get actualLevel => _actualLevel;

  bool get isLeveled => _actualLevel > 0;

  bool isUnlocked(HelperPlanner helperPlanner);

  bool isUsable(HelperPlanner helperPlanner, int availablePoints);

  bool isLevelActive(int level) => _actualLevel >= level;

  void addLevel() {
    if (_actualLevel < _level) {
      _actualLevel++;
    }
  }

  void resetLevel() {
    _actualLevel = 0;
  }
}
