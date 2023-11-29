import 'package:cotwcompanion/model/describable.dart';

abstract class Proficiency extends Describable {
  final int _level, _tier, _type, _ability;

  int _actualLevel = 0;

  Proficiency({
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
