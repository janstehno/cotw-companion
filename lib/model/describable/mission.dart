import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/describable/describable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Mission extends Describable {
  final int _reserveId;
  final MissionType _type;
  final int _difficulty;
  final String _person;

  Mission({
    required super.id,
    required super.name,
    required super.description,
    required int reserveId,
    required MissionType type,
    required int difficulty,
    required String person,
  })  : _reserveId = reserveId,
        _type = type,
        _difficulty = difficulty,
        _person = person;

  MissionType get type => _type;

  int get difficulty => _difficulty;

  String get person => tr(_person);

  int get reserveId => _reserveId;

  String get typeAsString {
    return _type == MissionType.main ? tr("MISSION_MAIN") : tr("MISSION_SIDE");
  }

  String get difficultyAsString {
    switch (_difficulty) {
      case 1:
        return tr("DIFFICULTY_EASY");
      case 2:
        return tr("DIFFICULTY_MEDIOCRE");
      case 3:
        return tr("DIFFICULTY_HARD");
      case 4:
        return tr("DIFFICULTY_VERY_HARD");
      default:
        return tr("NONE");
    }
  }

  Color get difficultyColor {
    switch (_difficulty) {
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

  Color getObjectiveColor(String objective) {
    if (objective.startsWith("[I]")) return Interface.oceanBlue;
    if (objective.startsWith("[O]")) return Interface.disabled;
    return Interface.green;
  }

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      id: json['ID'],
      name: json['NAME'],
      type: MissionType.values.elementAt(json['TYPE']),
      person: json['PERSON'],
      reserveId: json['RESERVE_ID'],
      difficulty: json['DIFFICULTY'],
      description: json['OBJECTIVES'],
    );
  }

  static Comparator<Mission> sortByName = (a, b) => a.name.compareTo(b.name);

  static Comparator<Mission> sortByReserveName = (a, b) {
    if (a.reserveId == b.reserveId) return a.name.compareTo(b.name);
    return a.reserveId.compareTo(b.reserveId);
  };
}
