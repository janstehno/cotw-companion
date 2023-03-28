// Copyright (c) 2022 Jan Stehno

import 'dart:core';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/animal_fur.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:flutter/material.dart';

class Log {
  int _id;
  String _date;
  String _animalName = "";
  int _animalId, _reserveId, _furId;
  double _trophy, _weight;
  int _imperials, _lodge, _gender;
  int _harvestCorrectAmmo, _harvestTwoShots, _harvestVitalOrgan, _harvestNoTrophyOrgan;
  bool _corrupted;

  Log({
    required id,
    required date,
    required animalName,
    required animalId,
    required reserveId,
    required furId,
    required trophy,
    required weight,
    required imperials,
    required lodge,
    required gender,
    required harvestCorrectAmmo,
    required harvestTwoShots,
    required harvestVitalOrgan,
    required harvestNoTrophyOrgan,
    required corrupted,
  })  : _id = id,
        _date = date,
        _animalName = animalName,
        _animalId = animalId,
        _reserveId = reserveId,
        _furId = furId,
        _trophy = trophy,
        _weight = weight,
        _imperials = imperials,
        _lodge = lodge,
        _gender = gender,
        _harvestCorrectAmmo = harvestCorrectAmmo,
        _harvestTwoShots = harvestTwoShots,
        _harvestVitalOrgan = harvestVitalOrgan,
        _harvestNoTrophyOrgan = harvestNoTrophyOrgan,
        _corrupted = corrupted;

  @override
  String toString() {
    return "$_id: RID: $_reserveId, AID: $_animalId, FID: $_furId, T: $_trophy, W: $_weight";
  }

  int get id => _id;

  String get date => _date;

  String get dateForCompare => _getDateForCompare();

  String get dateFormatted => _getDate(true);

  int get animalId => _animalId;

  int get reserveId => _reserveId;

  int get furId => _furId;

  double get trophy => _trophy;

  double get weight => _weight;

  int get imperials => _imperials;

  int get lodge => _lodge;

  int get gender => _gender;

  bool get usesImperials => _imperials == 1;

  bool get isInLodge => _lodge == 1;

  bool get isFemale => _gender == 0;

  bool get isMale => _gender == 1;

  bool get correctAmmoUsed => _harvestCorrectAmmo == 1;

  bool get twoShotsFired => _harvestTwoShots == 1;

  bool get vitalOrganHit => _harvestVitalOrgan == 1;

  bool get trophyOrganUndamaged => _harvestNoTrophyOrgan == 1;

  bool get harvestCheckPassed => correctAmmoUsed && twoShotsFired && vitalOrganHit && trophyOrganUndamaged;

  bool get isCorrupted => _corrupted;

  String toJson() =>
      '{"ID":$id,"DATE":"${_getDate(false)}","ANIMAL_ID":$_animalId,"RESERVE_ID":$_reserveId,"FUR_ID":$_furId,"TROPHY":$_trophy,"WEIGHT":$_weight,"IMPERIALS":$_imperials,"LODGE":$_lodge,"GENDER":$_gender,"CORRECT_AMMUNITION":$_harvestCorrectAmmo,"MAX_TWO_SHOTS":$_harvestTwoShots,"VITAL_ORGAN":$_harvestVitalOrgan,"NO_TROPHY_ORGAN":$_harvestNoTrophyOrgan}';

  String _getDate(bool formatted) {
    int year = int.parse(date.split("-")[0]);
    int month = int.parse(date.split("-")[1]);
    int day = int.parse(date.split("-")[2]);
    int hour = int.parse(date.split("-")[3]);
    int minute = int.parse(date.split("-")[4]);
    return formatted ? "$day.$month.$year  $hour:${minute / 10 < 1 ? "0$minute" : minute}" : "$year-$month-$day-$hour-$minute";
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

  set setId(int value) => _id = value;

  set setAnimalName(String value) => _animalName = value;

  set setLodge(int value) => _lodge = value;

  set setCorrupted(bool value) => _corrupted = value;

  Reserve get reserve => HelperJSON.getReserve(_reserveId == -1 ? 1 : _reserveId);

  Animal get animal => HelperJSON.getAnimal(_animalId == -1 ? 1 : _animalId);

  AnimalFur get fur => HelperJSON.getAnimalFur(null, _animalId, _furId);

  int getTrophyRating(Animal animal, bool harvestCheck) {
    int decrease = 0;
    if (harvestCheck) decrease = harvestCheckPassed ? 0 : 1;
    if (furId == Interface.greatOneId) {
      return 5 - (decrease * 2);
    }
    if (trophy >= animal.diamond) {
      return 4 - decrease;
    } else if (trophy >= animal.gold) {
      return 3 - decrease;
    } else if (trophy >= animal.silver) {
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
      return Colors.transparent;
    }
    switch (getTrophyRating(animal, harvestCheck)) {
      case 1:
        return Interface.trophyBronze;
      case 2:
        return Interface.trophySilver;
      case 3:
        return Interface.trophyGold;
      case 4:
        return Interface.trophyDiamond;
      case 5:
        return Interface.dark;
      default:
        return Interface.disabled;
    }
  }

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      id: json['ID'],
      date: json['DATE'],
      animalId: json['ANIMAL_ID'],
      reserveId: json['RESERVE_ID'],
      furId: json['FUR_ID'],
      trophy: json['TROPHY'],
      weight: json['WEIGHT'],
      imperials: json['IMPERIALS'],
      lodge: json['LODGE'],
      gender: json['GENDER'],
      harvestCorrectAmmo: json['CORRECT_AMMUNITION'],
      harvestTwoShots: json['MAX_TWO_SHOTS'],
      harvestVitalOrgan: json['VITAL_ORGAN'],
      harvestNoTrophyOrgan: json['NO_TROPHY_ORGAN'],
      animalName: "Unknown",
      corrupted: false,
    );
  }

  Map<String, dynamic> _toMap() {
    return {'DATE': dateForCompare, 'NAME': _animalName, 'TROPHY': _trophy};
  }

  dynamic get(String propertyName) {
    var mapRep = _toMap();
    if (mapRep.containsKey(propertyName)) {
      return mapRep[propertyName];
    }
    throw ArgumentError('Could not find filter property. Please, go back or restart the application.');
  }
}
