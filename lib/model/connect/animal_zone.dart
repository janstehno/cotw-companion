import 'dart:ui';

import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';

class AnimalZone {
  final int _animalId;
  final int _reserveId;
  final int _zone;
  final int _from;
  final int _to;

  AnimalZone({
    required int animalId,
    required int reserveId,
    required int zone,
    required int from,
    required int to,
  })  : _animalId = animalId,
        _reserveId = reserveId,
        _zone = zone,
        _from = from,
        _to = to;

  int get animalId => _animalId;

  int get reserveId => _reserveId;

  int get zone => _zone;

  int get from => _from;

  int get to => _to;

  Color get color => colorFor(_zone);

  String get icon => iconFor(_zone);

  Color get iconColor => iconColorFor(_zone);

  static Color colorFor(int zone) {
    switch (zone) {
      case 0:
        return Interface.zoneFeed;
      case 1:
        return Interface.zoneDrink;
      case 2:
        return Interface.zoneRest;
      case 3:
        return Interface.zoneOther;
      default:
        return Interface.zoneNothing;
    }
  }

  static String iconFor(int zone) {
    switch (zone) {
      case 0:
        return Assets.graphics.icons.zoneFeed;
      case 1:
        return Assets.graphics.icons.zoneDrink;
      case 2:
        return Assets.graphics.icons.zoneRest;
      case 3:
        return Assets.graphics.icons.zoneOther;
      default:
        return Assets.graphics.icons.zoneNothing;
    }
  }

  static Color iconColorFor(int zone) {
    if (zone == 4) return Interface.dark;
    if (zone == 3) return Interface.light;
    return Interface.alwaysDark;
  }

  factory AnimalZone.fromJson(Map<String, dynamic> json) {
    return AnimalZone(
      animalId: json['ANIMAL_ID'],
      reserveId: json['RESERVE_ID'],
      zone: json['ZONE'],
      from: json['TIME_FROM'],
      to: json['TIME_TO'],
    );
  }

  static Comparator<AnimalZone> sortByTime = (a, b) => a.from.compareTo(b.from);
}
