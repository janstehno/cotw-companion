import 'dart:core';

import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/connect/animal_fur.dart';
import 'package:cotwcompanion/model/exportable/exportable.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Log extends Exportable {
  DateTime _dateTime;
  int _reserveId;
  int _animalId;
  int _furId;
  int _trophyRating;
  double _trophy;
  double _weight;
  bool _lodge;
  bool _gender;
  bool _imperials;
  bool _harvestCorrectAmmo;
  bool _harvestTwoShots;
  bool _harvestVitalOrgan;
  bool _harvestTrophyOrgan;
  bool _corrupted;

  Log({
    required DateTime dateTime,
    required int reserveId,
    required int animalId,
    required int furId,
    required int trophyRating,
    required double trophy,
    required double weight,
    required bool imperials,
    required bool lodge,
    required bool gender,
    required bool harvestCorrectAmmo,
    required bool harvestTwoShots,
    required bool harvestVitalOrgan,
    required bool harvestTrophyOrgan,
    required bool corrupted,
  })  : _dateTime = dateTime,
        _reserveId = reserveId,
        _animalId = animalId,
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
        _harvestTrophyOrgan = harvestTrophyOrgan,
        _corrupted = corrupted;

  DateTime get dateTime => _dateTime;

  Reserve? get reserve => HelperJSON.getReserve(_reserveId);

  Animal? get animal => HelperJSON.getAnimal(_animalId);

  AnimalFur? get animalFur => HelperJSON.getAnimalFurByParameters(_animalId, _furId, _gender, !_gender);

  double get trophy => _trophy;

  double get weight => _weight;

  bool get imperials => _imperials;

  int get trophyRating => _trophyRating;

  int get trophyRatingWithGO => isGreatOne ? 5 : trophyRating;

  bool get lodge => _lodge;

  bool get usesImperials => _imperials;

  bool get isInLodge => _lodge;

  bool get isFemale => !_gender;

  bool get isMale => _gender;

  bool get correctAmmo => _harvestCorrectAmmo;

  bool get twoShots => _harvestTwoShots;

  bool get vitalOrgan => _harvestVitalOrgan;

  bool get trophyOrgan => _harvestTrophyOrgan;

  bool get harvestCheckPassed => correctAmmo && twoShots && vitalOrgan && trophyOrgan;

  bool get isCorrupted => _corrupted;

  bool get isGreatOne => animalFur!.furId == Values.greatOneId;

  set setDate(DateTime value) => _dateTime = value;

  set setReserveId(int value) => _reserveId = value;

  set setAnimalId(int value) => _animalId = value;

  set setFurId(int value) => _furId = value;

  set setTrophy(double value) => _trophy = value;

  set setWeight(double value) => _weight = value;

  set setTrophyRating(int value) => _trophyRating = value;

  set setImperials(bool value) => _imperials = value;

  set setLodge(bool value) => _lodge = value;

  set setGender(bool value) => _gender = value;

  set setCorrectAmmo(bool value) => _harvestCorrectAmmo = value;

  set setTwoShots(bool value) => _harvestTwoShots = value;

  set setVitalOrgan(bool value) => _harvestVitalOrgan = value;

  set setTrophyOrgan(bool value) => _harvestTrophyOrgan = value;

  set setCorrupted(bool value) => _corrupted = value;

  String getTrophyRatingIcon() {
    switch (_trophyRating) {
      case 1:
        return Assets.graphics.icons.trophyBronze;
      case 2:
        return Assets.graphics.icons.trophySilver;
      case 3:
        return Assets.graphics.icons.trophyGold;
      case 4:
        return isGreatOne ? Assets.graphics.icons.trophyGreatOne : Assets.graphics.icons.trophyDiamond;
      default:
        return Assets.graphics.icons.trophyNone;
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
        return isGreatOne ? Interface.trophyGreatOne : Interface.trophyDiamond;
      default:
        return Interface.trophyNone;
    }
  }

  static DateTime _dateTimeFromJson(String dateTime) {
    // input: 2023-07-02-13-41
    List<String> split = dateTime.split("-");
    return DateTime(
      int.parse(split.elementAt(0)),
      int.parse(split.elementAt(1)),
      int.parse(split.elementAt(2)),
      int.parse(split.elementAt(3)),
      int.parse(split.elementAt(4)),
    );
  }

  static Log create(
    DateTime date,
    Animal? animal,
    Reserve? reserve,
    AnimalFur? animalFur,
    int trophyRating,
    double trophy,
    double weight,
    bool imperials,
    bool lodge,
    bool gender,
    bool harvestCorrectAmmo,
    bool harvestTwoShots,
    bool harvestVitalOrgan,
    bool harvestNoTrophyOrgan,
    bool corrupted,
  ) {
    return Log(
      dateTime: date,
      animalId: animal == null ? -1 : animal.id,
      reserveId: reserve == null ? -1 : reserve.id,
      furId: animalFur == null ? -1 : animalFur.furId,
      trophyRating: trophyRating,
      trophy: trophy,
      weight: weight,
      imperials: imperials,
      lodge: lodge,
      gender: gender,
      harvestCorrectAmmo: harvestCorrectAmmo,
      harvestTwoShots: harvestTwoShots,
      harvestVitalOrgan: harvestVitalOrgan,
      harvestTrophyOrgan: harvestNoTrophyOrgan,
      corrupted: corrupted,
    );
  }

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      dateTime: _dateTimeFromJson(json['DATE']),
      animalId: json['ANIMAL_ID'],
      reserveId: json['RESERVE_ID'],
      furId: json['FUR_ID'],
      trophyRating: json['TROPHY_RATING'] ?? 0,
      trophy: json['TROPHY'],
      weight: json['WEIGHT'],
      imperials: json['IMPERIALS'] == 1,
      lodge: json['LODGE'] == 1,
      gender: json['GENDER'] == 1,
      harvestCorrectAmmo: json['CORRECT_AMMUNITION'] == 1,
      harvestTwoShots: json['MAX_TWO_SHOTS'] == 1,
      harvestVitalOrgan: json['VITAL_ORGAN'] == 1,
      harvestTrophyOrgan: json['NO_TROPHY_ORGAN'] == 1,
      corrupted: false,
    );
  }

  @override
  String toString() {
    return '''{
      "DATE": "${Utils.dateTimeAs(DateStructure.json, _dateTime)}",
      "ANIMAL_ID": $_animalId,
      "RESERVE_ID": $_reserveId,
      "FUR_ID": $_furId,
      "TROPHY_RATING": $_trophyRating,
      "TROPHY": $_trophy,
      "WEIGHT": $_weight,
      "IMPERIALS": ${_imperials ? 1 : 0},
      "LODGE": ${_lodge ? 1 : 0},
      "GENDER": ${_gender ? 1 : 0},
      "CORRECT_AMMUNITION": ${_harvestCorrectAmmo ? 1 : 0},
      "MAX_TWO_SHOTS": ${_harvestTwoShots ? 1 : 0},
      "VITAL_ORGAN": ${_harvestVitalOrgan ? 1 : 0},
      "NO_TROPHY_ORGAN": ${_harvestTrophyOrgan ? 1 : 0}
    }''';
  }

  Map<String, dynamic> _toMap(BuildContext context) {
    return {
      "NAME": HelperJSON.getAnimal(_animalId)!.getNameByReserve(context.locale, HelperJSON.getReserve(_reserveId)),
      "DATE": Utils.dateTimeAs(DateStructure.compare, _dateTime),
      "TROPHY": _trophy,
      "TROPHY_RATING": isGreatOne ? 5 : _trophyRating,
      "FUR_RARITY": animalFur!.rarity,
      "GENDER": _gender ? 1 : 0,
    };
  }

  dynamic get(BuildContext context, String propertyName) {
    Map<String, dynamic> mapRep = _toMap(context);
    if (mapRep.containsKey(propertyName)) {
      return mapRep[propertyName];
    }
    throw ArgumentError("Could not find filter property. Please, go back or restart the application.");
  }

  static Comparator<Log> sortByTrophy = (a, b) => a.trophy.compareTo(b.trophy);

  static Comparator<Log> sortByDate = (a, b) => Utils.dateTimeAs(DateStructure.compare, a.dateTime)
      .compareTo(Utils.dateTimeAs(DateStructure.compare, b.dateTime));
}
