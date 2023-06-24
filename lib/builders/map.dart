// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/map.dart';
import 'package:cotwcompanion/activities/map.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderMap extends StatefulWidget {
  final int reserveId;

  const BuilderMap({
    Key? key,
    required this.reserveId,
  }) : super(key: key);

  @override
  BuilderMapState createState() => BuilderMapState();
}

class BuilderMapState extends State<BuilderMap> {
  void _getAnimals() {
    _getMapObjects();
    for (IdtoId iti in HelperJSON.animalsReserves) {
      if (iti.secondId == widget.reserveId) {
        for (Animal animal in HelperJSON.animals) {
          if (animal.id == iti.firstId) {
            HelperMap.addAnimal(animal);
            break;
          }
        }
      }
    }
    HelperMap.addNames(context.locale, widget.reserveId);
  }

  void _getMapObjects() {
    HelperMap.clearMap();
    HelperMap.addObjects(HelperJSON.getMapObjects(widget.reserveId));
  }

  Widget _buildWidgets() {
    _getAnimals();
    return ActivityMap(reserveId: widget.reserveId);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
