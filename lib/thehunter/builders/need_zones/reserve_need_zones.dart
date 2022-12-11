// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/model/idtoid.dart';
import 'package:cotwcompanion/thehunter/model/zone.dart';
import 'package:cotwcompanion/thehunter/widgets/need_zone.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderReserveNeedZones extends StatefulWidget {
  final int reserveID;
  final int hour;
  final bool compact;

  const BuilderReserveNeedZones({Key? key, required this.reserveID, required this.hour, required this.compact}) : super(key: key);

  @override
  BuilderReserveNeedZonesState createState() => BuilderReserveNeedZonesState();
}

class BuilderReserveNeedZonesState extends State<BuilderReserveNeedZones> {
  late final List<Animal> _animals = [];

  _getAnimals() {
    _animals.clear();
    for (IDtoID iti in JSONHelper.animalsReserves) {
      if (iti.getSecondID == widget.reserveID) {
        for (Animal a in JSONHelper.animals) {
          if (iti.getFirstID == a.getID) {
            _animals.add(a);
            break;
          }
        }
      }
    }
    _animals.sort((a, b) => a.getNameBasedOnReserve(context.locale, widget.reserveID).compareTo(b.getNameBasedOnReserve(context.locale, widget.reserveID)));
  }

  Widget _buildWidgets() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _animals.length,
        itemBuilder: (context, index) {
          Map<int, List<Zone>> zonesList = Zone.getZones(_animals[index].getID);
          List<Zone> zones = [];
          for (int key in zonesList.keys) {
            if (key == widget.reserveID) {
              zones.addAll(zonesList[key]!);
            }
          }
          return EntryNeedZone(
              animal: _animals[index], reserveID: widget.reserveID, zones: zones, hour: widget.hour, index: index, count: _animals.length, compact: widget.compact);
        });
  }

  @override
  Widget build(BuildContext context) {
    _getAnimals();
    return _buildWidgets();
  }
}
