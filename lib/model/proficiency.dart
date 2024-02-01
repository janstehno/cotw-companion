import 'package:cotwcompanion/model/describable.dart';

abstract class Proficiency extends Describable {
  final int _level, _tier, _type, _ability;

  int _actualLevel = 0;

  Proficiency({
    required super.id,
    required super.en,
    super.ru,
    super.cs,
    super.pl,
    super.de,
    super.fr,
    super.es,
    super.br,
    super.ja,
    super.zh,
    required super.dEn,
    super.dRu,
    super.dCs,
    super.dPl,
    super.dDe,
    super.dFr,
    super.dEs,
    super.dBr,
    super.dJa,
    super.dZh,
    required level,
    required tier,
    required type,
    required ability,
  })  : _level = level,
        _tier = tier,
        _type = type,
        _ability = ability;

  int get level => _level;

  int get tier => _tier;

  int get type => _type;

  bool get isAbility => _ability == 1;

  int get actualLevel => _actualLevel;

  bool get isLeveled => _actualLevel > 0;

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
