// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/map.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/map.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderMap extends StatelessWidget {
  final int reserveId;

  const BuilderMap({
    Key? key,
    required this.reserveId,
  }) : super(key: key);

  void _getAnimals(BuildContext context) {
    for (IdtoId iti in HelperJSON.animalsReserves) {
      if (iti.secondId == reserveId) {
        for (Animal animal in HelperJSON.animals) {
          if (animal.id == iti.firstId) {
            HelperMap.addAnimal(animal);
            break;
          }
        }
      }
    }
    HelperMap.addNames(context.locale, reserveId);
  }

  void _getMapObjects() {
    HelperMap.clearMap();
    HelperMap.addObjects(HelperJSON.getMapObjects(reserveId));
  }

  Widget _buildWidgets(BuildContext context) {
    _getMapObjects();
    _getAnimals(context);
    return ActivityMap(reserveId: reserveId);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
