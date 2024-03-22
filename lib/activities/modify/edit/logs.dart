import 'package:cotwcompanion/activities/modify/add/logs.dart';
import 'package:cotwcompanion/helpers/log.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/exportable/log.dart';
import 'package:flutter/material.dart';

class ActivityEditLogs extends ActivityAddLogs {
  final Log _log;

  const ActivityEditLogs({
    super.key,
    required Log log,
    required super.trophyLodgeOnly,
    required super.onSuccess,
  })  : _log = log,
        super(type: ModifyType.edit);

  Log get log => _log;

  @override
  State<StatefulWidget> createState() => ActivityEditLogsState();
}

class ActivityEditLogsState extends ActivityAddLogsState {
  late final Log _log;

  @override
  bool get usesImperials => _log.usesImperials;

  @override
  void initializeData() {
    _log = (widget as ActivityEditLogs).log;
    dateTime = _log.dateTime;
    selectedReserve = _log.reserve;
    selectedAnimal = _log.animal!;
    selectedAnimalFur = _log.animalFur!;
    trophyRating = _log.trophyRating;
    trophy = _log.trophy;
    weight = _log.weight;
    isMale = _log.isMale;
    correctAmmo = _log.correctAmmo;
    twoShots = _log.twoShots;
    vitalOrgan = _log.vitalOrgan;
    trophyOrgan = _log.trophyOrgan;
    trophyController.text = trophy.toString();
    weightController.text = weight.toString();
  }

  @override
  void onSuccess() {
    _log.setDate = dateTime;
    _log.setReserveId = selectedReserve == null ? -1 : selectedReserve!.id;
    _log.setAnimalId = selectedAnimal.id;
    _log.setFurId = selectedAnimalFur.furId;
    _log.setTrophyRating = trophyRating;
    _log.setTrophy = trophy;
    _log.setWeight = weight;
    _log.setGender = isMale;
    _log.setCorrectAmmo = correctAmmo;
    _log.setTwoShots = twoShots;
    _log.setTrophyOrgan = trophyOrgan;
    _log.setVitalOrgan = vitalOrgan;
    HelperLog.save();
  }
}
