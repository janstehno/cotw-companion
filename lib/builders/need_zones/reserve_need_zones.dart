// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/model/zone.dart';
import 'package:cotwcompanion/widgets/entries/need_zone.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderReserveNeedZones extends StatefulWidget {
  final int reserveId;
  final int hour;
  final bool compact;

  const BuilderReserveNeedZones({
    Key? key,
    required this.reserveId,
    required this.hour,
    required this.compact,
  }) : super(key: key);

  @override
  BuilderReserveNeedZonesState createState() => BuilderReserveNeedZonesState();
}

class BuilderReserveNeedZonesState extends State<BuilderReserveNeedZones> {
  late final List<Animal> _animals = [];

  void _getAnimals() {
    _animals.clear();
    for (IdtoId iti in HelperJSON.animalsReserves) {
      if (iti.secondId == widget.reserveId) {
        for (Animal a in HelperJSON.animals) {
          if (iti.firstId == a.id) {
            _animals.add(a);
            break;
          }
        }
      }
    }
    _animals.sort((a, b) => a.getNameBasedOnReserve(context.locale, widget.reserveId).compareTo(b.getNameBasedOnReserve(context.locale, widget.reserveId)));
  }

  Widget _buildWidgets() {
    _getAnimals();
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _animals.length,
        itemBuilder: (context, index) {
          Map<int, List<Zone>> zonesList = Zone.animalZones(_animals[index].id);
          List<Zone> zones = [];
          for (int key in zonesList.keys) {
            if (key == widget.reserveId) {
              zones.addAll(zonesList[key]!);
            }
          }
          return EntryNeedZone(
              animal: _animals[index], reserveId: widget.reserveId, zones: zones, hour: widget.hour, index: index, count: _animals.length, compact: widget.compact);
        });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
