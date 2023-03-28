// Copyright (c) 2022 Jan Stehno

import 'dart:ui';

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/idtoid.dart';

class Zone {
  final int _id;
  final int _animalId, _reserveId;
  final int _zone;
  final int _from, _to;

  Zone({
    required id,
    required animalId,
    required reserveId,
    required zone,
    required from,
    required to,
  })  : _id = id,
        _animalId = animalId,
        _reserveId = reserveId,
        _zone = zone,
        _from = from,
        _to = to;

  int get id => _id;

  int get animalId => _animalId;

  int get reserveId => _reserveId;

  int get zone => _zone;

  int get from => _from;

  int get to => _to;

  Color get color => colorForZone(_zone);

  String get icon => iconForZone(_zone);

  static Color colorForZone(int zone) {
    switch (zone) {
      case 0:
        return Interface.feed;
      case 1:
        return Interface.drink;
      case 2:
        return Interface.rest;
      case 3:
        return Interface.other;
      default:
        return Interface.nothing;
    }
  }

  static String iconForZone(int zone) {
    switch (zone) {
      case 0:
        return "assets/graphics/icons/zone_feed.svg";
      case 1:
        return "assets/graphics/icons/zone_drink.svg";
      case 2:
        return "assets/graphics/icons/zone_rest.svg";
      case 3:
        return "assets/graphics/icons/zone_other.svg";
      default:
        return "assets/graphics/icons/zone_nothing.svg";
    }
  }

  static List<Zone> animalZones(int animalId, int reserveId) {
    List<Zone> animalZones = [];
    animalZones.addAll(HelperJSON.getAnimalZones(animalId, reserveId));
    if (animalZones.isEmpty) animalZones.add(Zone(id: -1, animalId: animalId, reserveId: reserveId, zone: 4, from: 0, to: 24));
    return animalZones;
  }

  static Map<int, List<Zone>> allAnimalZones(int animalId) {
    Map<int, List<Zone>> allAnimalZones = {};
    List<int> animalReserves = [];
    for (IdtoId iti in HelperJSON.animalsReserves) {
      if (iti.firstId == animalId) animalReserves.add(iti.secondId);
    }
    for (int reserveId in animalReserves) {
      allAnimalZones[reserveId] = animalZones(animalId, reserveId);
    }
    return allAnimalZones;
  }

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      id: json['ID'],
      animalId: json['ANIMAL_ID'],
      reserveId: json['RESERVE_ID'],
      zone: json['ZONE'],
      from: json['TIME_FROM'],
      to: json['TIME_TO'],
    );
  }
}
