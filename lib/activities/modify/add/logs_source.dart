import 'package:cotwcompanion/activities/modify/add/logs.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:flutter/material.dart';

class ActivityAddLogsSource extends ActivityAddLogs {
  final Reserve _reserve;
  final Animal _animal;

  const ActivityAddLogsSource({
    super.key,
    required Reserve reserve,
    required Animal animal,
    required super.context,
    required super.onSuccess,
  })  : _animal = animal,
        _reserve = reserve;

  Reserve get reserve => _reserve;

  Animal get animal => _animal;

  @override
  State<StatefulWidget> createState() => ActivityAddLogsSourceState();
}

class ActivityAddLogsSourceState extends ActivityAddLogsState {
  @override
  void initializeData() {
    selectedReserve = (widget as ActivityAddLogsSource).reserve;
    selectedAnimal = (widget as ActivityAddLogsSource).animal;
    selectedAnimalFur = animalFurs.first;
  }
}
