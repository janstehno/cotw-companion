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

  Color getObjectiveColor(String objective) {
    if (objective.startsWith("[I]")) return Interface.oceanBlue;
    if (objective.startsWith("[O]")) return Interface.disabled;
    return Interface.green;
  }

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      id: json['ID'],
      name: json['NAME'],
      type: MissionType.values.firstWhere((e) => e.id == json['TYPE']),
      person: json['PERSON'],
      reserveId: json['RESERVE_ID'],
      difficulty: MissionDifficulty.values.firstWhere((e) => e.id == json['DIFFICULTY']),
      description: json['OBJECTIVES'],
    );
  }

  static Comparator<Mission> sortByName = (a, b) => a.name.compareTo(b.name);

  static Comparator<Mission> sortByReserveName = (a, b) {
    if (a.reserveId == b.reserveId) return a.name.compareTo(b.name);
    return a.reserveId.compareTo(b.reserveId);
  };
}
