// Copyright (c) 2022 - 2023 Jan Stehno

import 'dart:core';

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/log.dart';
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
  int _imperials, _trophyRating, _lodge, _gender;
  int _harvestCorrectAmmo, _harvestTwoShots, _harvestVitalOrgan, _harvestNoTrophyOrgan;
  bool _corrupted;

  Log({
    required id,
    required date,
    required animalName,
    required animalId,
    required reserveId,
    required furId,
    required trophyRating,
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
        _trophyRating = trophyRating,
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

  String get dateForCompare => getDate(DateStructure.compare, _date);

  String get dateFormatted => getDate(DateStructure.format, _date);

  String get animalName => _animalName;

  int get animalId => _animalId;

  int get reserveId => _reserveId;

  int get furId => _furId;

  double get trophy => _trophy;

  double get weight => _weight;

  int get imperials => _imperials;

  int get trophyRating => _trophyRating;

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

  set setId(int value) => _id = value;

  set setAnimalName(String value) => _animalName = value;

  set setLodge(int value) => _lodge = value;

  set setCorrupted(bool value) => _corrupted = value;

  Reserve get reserve => HelperJSON.getReserve(_reserveId == -1 ? 1 : _reserveId);

  Animal get animal => HelperJSON.getAnimal(_animalId == -1 ? 1 : _animalId);

  AnimalFur get fur => HelperJSON.getAnimalFur(_animalId, _furId);

  String toJson() =>
      '{"ID":$id,"DATE":"${getDate(DateStructure.json, _date)}","ANIMAL_ID":$_animalId,"RESERVE_ID":$_reserveId,"FUR_ID":$_furId,"TROPHY_RATING":$_trophyRating,"TROPHY":$_trophy,"WEIGHT":$_weight,"IMPERIALS":$_imperials,"LODGE":$_lodge,"GENDER":$_gender,"CORRECT_AMMUNITION":$_harvestCorrectAmmo,"MAX_TWO_SHOTS":$_harvestTwoShots,"VITAL_ORGAN":$_harvestVitalOrgan,"NO_TROPHY_ORGAN":$_harvestNoTrophyOrgan}';

  String removePointZero(String value) {
    String text = value;
    List<String> tmp = text.split(".");
    List<String> split = tmp[1].split(" ");
    if (int.parse(split[0]) == 0) {
      (split.length == 2 && split[1].isNotEmpty) ? text = tmp[0] + (" ${split[1]}") : text = tmp[0];
    }
    return text;
  }

  bool isGreatOne() {
    return _furId == Interface.greatOneId;
  }

  String getTrophyRatingIcon() {
    switch (_trophyRating) {
      case 1:
        return "assets/graphics/icons/trophy_bronze.svg";
      case 2:
        return "assets/graphics/icons/trophy_silver.svg";
      case 3:
        return "assets/graphics/icons/trophy_gold.svg";
      case 4:
        return isGreatOne() ? "assets/graphics/icons/trophy_great_one.svg" : "assets/graphics/icons/trophy_diamond.svg";
      default:
        return "assets/graphics/icons/trophy_none.svg";
    }
  }

  Color getTrophyColor() {
    switch (_trophyRating) {
      case 1:
        return Interface.trophyBronze;
      case 2:
        return Interface.trophySilver;
      case 3:
        return Interface.trophyGold;
      case 4:
        return isGreatOne() ? Interface.dark : Interface.trophyDiamond;
      default:
        return Interface.disabled;
    }
  }

  static String dateToString(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month}-${dateTime.day}-${dateTime.hour}-${dateTime.minute}";
  }

  static String getDate(DateStructure type, String date) {
    int year = int.parse(date.split("-")[0]);
    int month = int.parse(date.split("-")[1]);
    int day = int.parse(date.split("-")[2]);
    int hour = int.parse(date.split("-")[3]);
    int minute = int.parse(date.split("-")[4]);
    String yy = "$year";
    String mm = month < 9 ? "0$month" : "$month";
    String dd = day < 9 ? "0$day" : "$day";
    String h = hour < 9 ? "0$hour" : "$hour";
    String m = minute < 9 ? "0$minute" : "$minute";
    switch (type) {
      case DateStructure.format:
        return "$day. $month. $year  $hour:${minute < 9 ? "0$minute" : minute}";
      case DateStructure.compare:
        return "$yy$mm$dd$h$m";
      default:
        return "$yy-$mm-$dd-$h-$m";
    }
  }

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      id: json['ID'],
      date: json['DATE'],
      animalId: json['ANIMAL_ID'],
      reserveId: json['RESERVE_ID'],
      furId: json['FUR_ID'],
      trophyRating: json['TROPHY_RATING'] ??
          HelperLog.getTrophyRating(
            json['TROPHY'],
            json['ANIMAL_ID'],
            json['FUR_ID'],
            json['CORRECT_AMMUNITION'] == 1 && json['MAX_TWO_SHOTS'] == 1 && json['VITAL_ORGAN'] == 1 && json['NO_TROPHY_ORGAN'] == 1,
          ),
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
    return {
      "DATE": dateForCompare,
      "NAME": _animalName,
      "TROPHY": _trophy,
      "TROPHY_RATING": isGreatOne() ? 5 : _trophyRating,
      "FUR_RARITY": fur.rarity,
      "GENDER": _gender,
    };
  }

  dynamic get(String propertyName) {
    Map<String, dynamic> mapRep = _toMap();
    if (mapRep.containsKey(propertyName)) {
      return mapRep[propertyName];
    }
    throw ArgumentError('Could not find filter property. Please, go back or restart the application.');
  }
}
