// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/map.dart';
import 'package:cotwcompanion/builders/builder.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/map.dart';
import 'package:cotwcompanion/miscellaneous/interface/graphics.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderMap extends BuilderBuilder {
  final int reserveId;

  const BuilderMap({
    super.key,
    required this.reserveId,
  }) : super(builderId: "M");

  @override
  State<StatefulWidget> createState() => BuilderMapState();
}

class BuilderMapState extends BuilderBuilderState {
  late final HelperMap _helperMap;

  @override
  void initState() {
    _helperMap = HelperMap(reserveId: (widget as BuilderMap).reserveId);
    loadedData = [null];
    super.initState();
  }

  void _getAnimals(BuildContext context) {
    for (IdtoId iti in HelperJSON.animalsReserves) {
      if (iti.secondId == _helperMap.reserveId) {
        for (Animal animal in HelperJSON.animals) {
          if (animal.id == iti.firstId) {
            _helperMap.addAnimal(animal);
            break;
          }
        }
      }
    }
    _helperMap.addNames(context.locale);
  }

  @override
  void initializeData(AsyncSnapshot<List<dynamic>> snapshot, BuildContext context) {
    Map<String, dynamic> mapObjects = snapshot.data![0] ?? [];
    _helperMap.addObjects(mapObjects);
  }

  @override
  Future<List<dynamic>> loadData(BuildContext context) async {
    String reserveName = Graphics.getReserveName(_helperMap.reserveId);
    Map<String, dynamic> mapObjects = await _helperMap.readMapObjects(reserveName);
    updateProgress(0, mapObjects);
    return loadedData;
  }

  @override
  Widget buildFutureWidget(BuildContext context) {
    _getAnimals(context);
    return ActivityMap(helperMap: _helperMap);
  }
}
