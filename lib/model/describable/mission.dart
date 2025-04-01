import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/describable/describable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Mission extends Describable {
  final int _reserveId;
  final MissionType _type;
  final MissionDifficulty _difficulty;
  final String _person;

  Mission({
    required super.id,
    required super.name,
    required super.description,
    required int reserveId,
    required MissionType type,
    required MissionDifficulty difficulty,
    required String person,
  })  : _reserveId = reserveId,
        _type = type,
        _difficulty = difficulty,
        _person = person;

  MissionType get type => _type;

  MissionDifficulty get difficulty => _difficulty;

  String get person => tr(_person);

  int get reserveId => _reserveId;

  String get typeAsString {
    switch (_type) {
      case MissionType.main:
        return tr("MISSION_MAIN");
      case MissionType.side:
        return tr("MISSION_SIDE");
    }
  }

  String get difficultyAsString {
    switch (_difficulty) {
      case MissionDifficulty.easy:
        return tr("DIFFICULTY_EASY");
      case MissionDifficulty.mediocre:
        return tr("DIFFICULTY_MEDIOCRE");
      case MissionDifficulty.hard:
        return tr("DIFFICULTY_HARD");
      case MissionDifficulty.veryHard:
        return tr("DIFFICULTY_VERY_HARD");
    }
  }

  Color get difficultyColor {
    switch (_difficulty) {
      case MissionDifficulty.easy:
        return Interface.green;
      case MissionDifficulty.mediocre:
        return Interface.yellow;
      case MissionDifficulty.hard:
        return Interface.orange;
      case MissionDifficulty.veryHard:
        return Interface.red;
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
      difficulty: MissionDifficulty.values.elementAt(json['DIFFICULTY']),
      description: json['OBJECTIVES'],
    );
  }

  static Comparator<Mission> sortByName = (a, b) => a.name.compareTo(b.name);

  static Comparator<Mission> sortByReserveName = (a, b) {
    if (a.reserveId == b.reserveId) return a.name.compareTo(b.name);
    return a.reserveId.compareTo(b.reserveId);
  };
}
