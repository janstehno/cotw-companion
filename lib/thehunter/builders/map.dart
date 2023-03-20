// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_map.dart';
import 'package:cotwcompanion/thehunter/activities/map.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/model/idtoid.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderMap extends StatefulWidget {
  final int reserveID;

  const BuilderMap({Key? key, required this.reserveID}) : super(key: key);

  @override
  BuilderMapState createState() => BuilderMapState();
}

class BuilderMapState extends State<BuilderMap> {
  _getAnimals() {
    for (IDtoID ar in JSONHelper.animalsReserves) {
      if (ar.getSecondID == widget.reserveID) {
        for (Animal a in JSONHelper.animals) {
          if (a.getID == ar.getFirstID) {
            HelperMap.addAnimal(a);
            break;
          }
        }
      }
    }
    HelperMap.addNames(context.locale, widget.reserveID);
  }

  _getMapObjects() {
    HelperMap.clearMap();
    HelperMap.addObjects(JSONHelper.getMapObjects(widget.reserveID));
    _getAnimals();
  }

  Widget _buildWidgets() {
    return ActivityMap(reserveID: widget.reserveID);
  }

  @override
  Widget build(BuildContext context) {
    _getMapObjects();
    return _buildWidgets();
  }
}
