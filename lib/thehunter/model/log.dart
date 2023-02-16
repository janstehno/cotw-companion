// Copyright (c) 2022 Jan Stehno

import 'dart:core';
import 'dart:ui';

import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/model/animal_fur.dart';
import 'package:cotwcompanion/thehunter/model/reserve.dart';

class LogList {
  List<Log> logs;

  LogList({required this.logs});

  factory LogList.fromJson(List<dynamic> json) {
    List<Log> logs = <Log>[];
    logs = json.map((i) => Log.fromJson(i)).toList();
    return LogList(logs: logs);
  }
}

class Log {
  int id;
  String date;
  int animalID, reserveID, furID;
  String animalName;
  double trophy, weight;
  int imperials, lodge, gender;
  int harvestCorrectAmmo, harvestTwoShots, harvestVitalOrgan, harvestNoTrophyOrgan;
  bool corrupted;

  Log(
      {required this.id,
      required this.date,
      required this.animalID,
      this.animalName = "",
      required this.reserveID,
      required this.furID,
      required this.trophy,
      required this.weight,
      required this.imperials,
      required this.lodge,
      required this.gender,
      required this.harvestCorrectAmmo,
      required this.harvestTwoShots,
      required this.harvestVitalOrgan,
      required this.harvestNoTrophyOrgan,
      this.corrupted = false});

  @override
  String toString() {
    return "$id: RID: $reserveID, AID: $animalID, FID: $furID, T: $trophy, W: $weight";
  }

  int get getID => id;

  String get getDate => date;

  String get getDateCompare => _getDateForCompare();

  String get getDateFormatted => _getDateFormatted();

  int get getAnimalID => animalID;

  int get getReserveID => reserveID;

  int get getFurID => furID;

  double get getTrophy => trophy;

  double get getWeight => weight;

  bool get getImperials => imperials == 1;

  bool get getLodge => lodge == 1;

  bool get getGender => gender == 1;

  bool get getCorrectAmmo => harvestCorrectAmmo == 1;

  bool get getTwoShots => harvestTwoShots == 1;

  bool get getVitalOrgan => harvestVitalOrgan == 1;

  bool get getNoTrophyOrgan => harvestNoTrophyOrgan == 1;

  bool get getHarvestCheck => getCorrectAmmo && getTwoShots && getVitalOrgan && getNoTrophyOrgan;

  bool get isCorrupted => corrupted;

  String toJson() =>
      '{"ID":$id,"DATE":"${_getDate()}","ANIMAL_ID":$animalID,"RESERVE_ID":$reserveID,"FUR_ID":$furID,"TROPHY":$trophy,"WEIGHT":$weight,"IMPERIALS":$imperials,"LODGE":$lodge,"GENDER":$gender,"CORRECT_AMMUNITION":$harvestCorrectAmmo,"MAX_TWO_SHOTS":$harvestTwoShots,"VITAL_ORGAN":$harvestVitalOrgan,"NO_TROPHY_ORGAN":$harvestNoTrophyOrgan}';

  String _getDate() {
    int y = int.parse(date.split("-")[0]);
    int m = int.parse(date.split("-")[1]);
    int d = int.parse(date.split("-")[2]);
    int hh = int.parse(date.split("-")[3]);
    int mm = int.parse(date.split("-")[4]);
    return "$y-$m-$d-$hh-$mm";
  }

  String _getDateFormatted() {
    int year = int.parse(date.split("-")[0]);
    int month = int.parse(date.split("-")[1]);
    int day = int.parse(date.split("-")[2]);
    int hour = int.parse(date.split("-")[3]);
    int minute = int.parse(date.split("-")[4]);
    return "$day.$month.$year  $hour:$minute";
  }

  String _getDateForCompare() {
    int y = int.parse(date.split("-")[0]);
    int m = int.parse(date.split("-")[1]);
    int d = int.parse(date.split("-")[2]);
    int hh = int.parse(date.split("-")[3]);
    int mm = int.parse(date.split("-")[4]);
    String year = y.toString();
    String month = m > 9 ? m.toString() : "0$m";
    String day = d > 9 ? d.toString() : "0$d";
    String hour = hh > 9 ? hh.toString() : "0$hh";
    String minute = mm > 9 ? mm.toString() : "0$mm";
    return year + month + day + hour + minute;
  }

  setAnimalName(String s) {
    animalName = s;
  }

  setLodge(int i) {
    lodge = i;
  }

  setID(int i) {
    id = i;
  }

  setCorrupted(bool b) {
    corrupted = b;
  }

  Reserve getReserve() {
    for (Reserve r in JSONHelper.reserves) {
      if (r.getID == getReserveID) {
        return r;
      }
    }
    return JSONHelper.getReserve(1);
  }

  Animal getAnimal() {
    for (Animal a in JSONHelper.animals) {
      if (a.getID == getAnimalID) {
        return a;
      }
    }
    return JSONHelper.getAnimal(1);
  }

  AnimalFur getAnimalFur() {
    for (AnimalFur af in JSONHelper.animalsFurs) {
      if (af.getAnimalID == animalID && af.getFurID == furID) {
        return af;
      }
    }
    return JSONHelper.getAnimalFur(1);
  }

  int getTrophyRating(Animal animal, bool harvestCheck) {
    int decrease = 0;
    if (harvestCheck) decrease = getHarvestCheck ? 0 : 1;
    if (furID == Values.greatOneID) {
      return 5 - (decrease * 2);
    }
    if (trophy >= animal.getDiamond) {
      return 4 - decrease;
    } else if (trophy >= animal.getGold) {
      return 3 - decrease;
    } else if (trophy >= animal.getSilver) {
      return 2 - decrease;
    } else if (trophy > 0) {
      return 1 - decrease;
    } else {
      return 0;
    }
  }

  String getTrophyRatingIcon(Animal animal, bool harvestCheck) {
    switch (getTrophyRating(animal, harvestCheck)) {
      case 1:
        return "assets/graphics/icons/trophy_bronze.svg";
      case 2:
        return "assets/graphics/icons/trophy_silver.svg";
      case 3:
        return "assets/graphics/icons/trophy_gold.svg";
      case 4:
        return "assets/graphics/icons/trophy_diamond.svg";
      case 5:
        return "assets/graphics/icons/trophy_great_one.svg";
      default:
        return "assets/graphics/icons/trophy_none.svg";
    }
  }

  Color getTrophyColor(Animal animal, bool harvestCheck) {
    if (!harvestCheck && getTrophyRating(animal, harvestCheck) == getTrophyRating(animal, !harvestCheck)) {
      return const Color(Values.colorTransparent);
    }
    switch (getTrophyRating(animal, harvestCheck)) {
      case 1:
        return Color(Values.colorBronze);
      case 2:
        return Color(Values.colorSilver);
      case 3:
        return Color(Values.colorGold);
      case 4:
        return Color(Values.colorDiamond);
      case 5:
        return Color(Values.colorDark);
      default:
        return Color(Values.colorDisabled);
    }
  }

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
        id: json['ID'],
        date: json['DATE'],
        animalID: json['ANIMAL_ID'],
        reserveID: json['RESERVE_ID'],
        furID: json['FUR_ID'],
        trophy: json['TROPHY'],
        weight: json['WEIGHT'],
        imperials: json['IMPERIALS'],
        lodge: json['LODGE'],
        gender: json['GENDER'],
        harvestCorrectAmmo: json['CORRECT_AMMUNITION'],
        harvestTwoShots: json['MAX_TWO_SHOTS'],
        harvestVitalOrgan: json['VITAL_ORGAN'],
        harvestNoTrophyOrgan: json['NO_TROPHY_ORGAN']);
  }

  Map<String, dynamic> _toMap() {
    return {'DATE': getDateCompare, 'NAME': animalName, 'TROPHY': trophy};
  }

  dynamic get(String propertyName) {
    var mapRep = _toMap();
    if (mapRep.containsKey(propertyName)) {
      return mapRep[propertyName];
    }
    throw ArgumentError('Could not find filter property. Please, go back or restart the application.');
  }
}
