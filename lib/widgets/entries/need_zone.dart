// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/activities/logs_add_edit.dart';
import 'package:cotwcompanion/activities/info_animal.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/zone.dart';
import 'package:cotwcompanion/widgets/icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryNeedZone extends StatefulWidget {
  final Animal animal;
  final int reserveId, index, count, hour;
  final List<Zone> zones;
  final bool compact;

  const EntryNeedZone({
    Key? key,
    required this.animal,
    required this.reserveId,
    required this.zones,
    required this.hour,
    required this.index,
    required this.count,
    required this.compact,
  }) : super(key: key);

  @override
  EntryNeedZoneState createState() => EntryNeedZoneState();
}

class EntryNeedZoneState extends State<EntryNeedZone> {
  int _zoneNow = 4;
  int _zoneNext = 4;
  String _zoneTill = "-";

  double _getSize() {
    return !widget.compact ? (MediaQuery.of(context).size.height - 75) / (widget.count <= 10 ? widget.count : 10) : 75;
  }

  void _getZones() {
    List<Zone> tmp = widget.zones;
    int size = tmp.length;
    for (int nowId = 0; nowId < size; nowId++) {
      if (size == 1) {
        _zoneNow = tmp[nowId].zone;
        _zoneTill = "-";
        _zoneNext = tmp[nowId].zone;
        break;
      }
      int nextId = nowId + 1;
      int nextNextId = nextId + 1;

      if (nextId >= size) {
        nextId = 0;
        nextNextId = 1;
      }
      if (nextNextId >= size) {
        nextNextId = 0;
      }

      int zoneFrom = tmp[nowId].from;
      int zoneTo = tmp[nowId].to;

      if (zoneFrom <= widget.hour && widget.hour < zoneTo) {
        _zoneNow = tmp[nowId].zone;
        _zoneTill = tmp[nowId].to.toString();
        _zoneNext = tmp[nextId].zone;
        if (_zoneNow == _zoneNext) {
          _zoneTill = tmp[nextId].to.toString();
          _zoneNext = tmp[nextNextId].zone;
        }
        break;
      }
    }
  }

  Widget _buildWidgets() {
    _getZones();
    return Dismissible(
        key: Key(widget.index.toString()),
        direction: DismissDirection.startToEnd,
        confirmDismiss: (direction) async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ActivityLogsAddEdit(
                        animalId: widget.animal.id,
                        reserveId: widget.reserveId,
                        callback: () {},
                        fromTrophyLodge: false,
                      )));
          return false;
        },
        background: Container(
            alignment: Alignment.centerLeft,
            color: Interface.dark,
            child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SvgPicture.asset(
                  "assets/graphics/icons/edit.svg",
                  height: 20,
                  width: 20,
                  color: Interface.light,
                  alignment: Alignment.centerLeft,
                ))),
        child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityAnimalInfo(animalId: widget.animal.id)));
            },
            child: Container(
                height: _getSize(),
                padding: const EdgeInsets.only(left: 30, right: 30),
                color: widget.index % 2 == 0 ? Interface.even : Interface.odd,
                child: Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(right: 15),
                          child: AutoSizeText(
                            widget.animal.getNameBasedOnReserve(context.locale, widget.reserveId),
                            textAlign: TextAlign.start,
                            maxLines: widget.animal.getNameBasedOnReserve(context.locale, widget.reserveId).split(" ").length == 1 ? 1 : 2,
                            style: TextStyle(
                              color: Interface.dark,
                              fontSize: Interface.s20,
                              fontWeight: FontWeight.w400,
                            ),
                          ))),
                  HelperLoadout.isLoadoutActivated
                      ? Container(
                          width: 10,
                          padding: const EdgeInsets.all(0),
                          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                            (HelperLoadout.loadoutMin <= widget.animal.level && widget.animal.level <= HelperLoadout.loadoutMax)
                                ? Container(
                                    padding: EdgeInsets.only(bottom: (HelperLoadout.containsCallerForAnimal(widget.animal.id)) ? 3 : 0),
                                    child: SvgPicture.asset(
                                      "assets/graphics/icons/loadout.svg",
                                      width: 10,
                                      color: Interface.dark,
                                    ))
                                : Container(),
                            HelperLoadout.containsCallerForAnimal(widget.animal.id)
                                ? Container(
                                    padding: EdgeInsets.only(
                                        top: (HelperLoadout.loadoutMin <= widget.animal.level && widget.animal.level <= HelperLoadout.loadoutMax) ? 3 : 0),
                                    child: SvgPicture.asset(
                                      "assets/graphics/icons/sense_hearing.svg",
                                      width: 10,
                                      color: Interface.dark,
                                    ))
                                : Container()
                          ]))
                      : Container(),
                  Container(
                      width: 165,
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, children: [
                        WidgetIcon(
                          size: 40,
                          icon: Zone.iconForZone(_zoneNow),
                          color: _zoneNow == 4
                              ? Interface.dark
                              : _zoneNow == 3
                                  ? Interface.light
                                  : Interface.alwaysDark,
                          background: Zone.colorForZone(_zoneNow),
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            alignment: Alignment.center,
                            height: 40,
                            width: 45,
                            child: AutoSizeText(
                              _zoneTill,
                              maxLines: 1,
                              style: TextStyle(color: Interface.dark, fontSize: Interface.s18, fontWeight: FontWeight.w400),
                            )),
                        WidgetIcon(
                          size: 40,
                          icon: Zone.iconForZone(_zoneNext),
                          color: _zoneNext == 4
                              ? Interface.dark
                              : _zoneNext == 3
                                  ? Interface.light
                                  : Interface.alwaysDark,
                          background: Zone.colorForZone(_zoneNext),
                        )
                      ]))
                ]))));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
