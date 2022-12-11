// Copyright (c) 2022 Jan Stehno

import 'dart:ui';

import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/model/idtoid.dart';

class ZoneList {
  List<Zone> zone;

  ZoneList({required this.zone});

  factory ZoneList.fromJson(List<dynamic> json) {
    List<Zone> zone = <Zone>[];
    zone = json.map((i) => Zone.fromJson(i)).toList();
    return ZoneList(zone: zone);
  }
}

class Zone {
  int id;
  int animalID, reserveID;
  int zone;
  int from, to;

  Zone({required this.id, required this.animalID, required this.reserveID, required this.zone, required this.from, required this.to});

  int get getID => id;

  int get getAnimalID => animalID;

  int get getReserveID => reserveID;

  int get getZone => zone;

  int get getFrom => from;

  int get getTo => to;

  static int getColorByZone(int zone) {
    switch (zone) {
      case 0:
        return Values.colorZoneFeed;
      case 1:
        return Values.colorZoneDrink;
      case 2:
        return Values.colorZoneRest;
      case 3:
        return Values.colorZoneOther;
      default:
        return Values.colorNothing;
    }
  }

  Color getColor() {
    switch (zone) {
      case 0:
        return Color(Values.colorZoneFeed);
      case 1:
        return Color(Values.colorZoneDrink);
      case 2:
        return Color(Values.colorZoneRest);
      case 3:
        return Color(Values.colorZoneOther);
      default:
        return Color(Values.colorNothing);
    }
  }

  static String getIconByZone(int zone) {
    switch (zone) {
      case 0:
        return "assets/graphics/icons/zone_feed.svg";
      case 1:
        return "assets/graphics/icons/zone_drink.svg";
      case 2:
        return "assets/graphics/icons/zone_rest.svg";
      case 3:
        return "assets/graphics/icons/zone_other.svg";
      case 4:
        return "assets/graphics/icons/zone_nothing.svg";
      default:
        return "";
    }
  }

  String getIcon() {
    switch (zone) {
      case 0:
        return "assets/graphics/icons/zone_feed.svg";
      case 1:
        return "assets/graphics/icons/zone_drink.svg";
      case 2:
        return "assets/graphics/icons/zone_rest.svg";
      case 3:
        return "assets/graphics/icons/zone_other.svg";
      case 4:
        return "assets/graphics/icons/zone_nothing.svg";
      default:
        return "";
    }
  }

  static Map<int, List<Zone>> getZones(int animalID) {
    Map<int, List<Zone>> allAnimalZones = {};
    List<Zone> animalZones = [];
    for (IDtoID iti in JSONHelper.animalsReserves) {
      if (iti.getFirstID == animalID) {
        for (Zone z in JSONHelper.animalsZones) {
          if (iti.getSecondID == z.getReserveID && z.getAnimalID == animalID) {
            animalZones.add(z);
          }
        }
        allAnimalZones[iti.getSecondID] = animalZones;
        animalZones = [];
      }
    }
    for (int reserveID in allAnimalZones.keys) {
      if (allAnimalZones[reserveID]!.isEmpty) {
        allAnimalZones[reserveID]!.add(Zone(id: -1, animalID: animalID, reserveID: reserveID, zone: 4, from: 0, to: 24));
      }
    }
    return allAnimalZones;
  }

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(id: json['ID'], animalID: json['ANIMAL_ID'], reserveID: json['RESERVE_ID'], zone: json['ZONE'], from: json['TIME_FROM'], to: json['TIME_TO']);
  }
}
