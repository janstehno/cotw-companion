// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_loadout.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/activities/add_edit_log.dart';
import 'package:cotwcompanion/thehunter/activities/animal_info.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/model/zone.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_icon.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryNeedZone extends StatefulWidget {
  final Animal animal;
  final int reserveID;
  final List<Zone> zones;
  final int hour;
  final int index;
  final int count;
  final bool compact;

  const EntryNeedZone(
      {Key? key,
      required this.animal,
      required this.reserveID,
      required this.zones,
      required this.hour,
      required this.index,
      required this.count,
      required this.compact})
      : super(key: key);

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

  _getZones() {
    List<Zone> tmp = widget.zones;
    int size = tmp.length;

    for (int nowID = 0; nowID < size; nowID++) {
      if (size == 1) {
        _zoneNow = tmp[nowID].getZone;
        _zoneTill = "-";
        _zoneNext = tmp[nowID].getZone;
        break;
      }

      int nextID = nowID + 1;
      int nextNextID = nextID + 1;

      if (nextID >= size) {
        nextID = 0;
        nextNextID = 1;
      }

      if (nextNextID >= size) {
        nextNextID = 0;
      }

      int zoneFrom = tmp[nowID].getFrom;
      int zoneTo = tmp[nowID].getTo;

      if (zoneFrom <= widget.hour && widget.hour < zoneTo) {
        _zoneNow = tmp[nowID].getZone;
        _zoneTill = tmp[nowID].getTo.toString() + tr('hour');
        _zoneNext = tmp[nextID].getZone;

        if (_zoneNow == _zoneNext) {
          _zoneTill = tmp[nextID].getTo.toString() + tr('hour');
          _zoneNext = tmp[nextNextID].getZone;
        }

        break;
      }
    }
  }

  Widget _buildWidgets() {
    return Dismissible(
        key: Key(widget.index.toString()),
        direction: DismissDirection.startToEnd,
        confirmDismiss: (direction) async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ActivityLogsAddEdit(animalID: widget.animal.getID, reserveID: widget.reserveID, callback: () {}, fromTrophyLodge: false)));
          return false;
        },
        background: Container(
            alignment: Alignment.centerLeft,
            color: Color(Values.colorDark),
            child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SvgPicture.asset(
                  "assets/graphics/icons/edit.svg",
                  height: 20,
                  width: 20,
                  color: Color(Values.colorLight),
                  alignment: Alignment.centerLeft,
                ))),
        child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityAnimalInfo(animalID: widget.animal.getID)));
            },
            child: Container(
                height: _getSize(),
                padding: const EdgeInsets.only(left: 30, right: 30),
                color: widget.index % 2 == 0 ? Color(Values.colorEven) : Color(Values.colorOdd),
                child: Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(right: 15),
                          child: AutoSizeText(
                            widget.animal.getNameBasedOnReserve(context.locale, widget.reserveID),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400),
                          ))),
                  WidgetContainer(
                      width: 10,
                      visible: LoadoutHelper.isLoadoutActivated,
                      padding: const EdgeInsets.all(0),
                      child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                        (LoadoutHelper.loadoutMin <= widget.animal.getLevel && widget.animal.getLevel <= LoadoutHelper.loadoutMax)
                            ? Container(
                                padding: EdgeInsets.only(bottom: (LoadoutHelper.containsCallerForAnimal(widget.animal.getID)) ? 3 : 0),
                                child: SvgPicture.asset("assets/graphics/icons/loadout.svg", color: Color(Values.colorContentIconTintDark), width: 10))
                            : Container(),
                        LoadoutHelper.containsCallerForAnimal(widget.animal.getID)
                            ? Container(
                                padding: EdgeInsets.only(
                                    top: (LoadoutHelper.loadoutMin <= widget.animal.getLevel && widget.animal.getLevel <= LoadoutHelper.loadoutMax) ? 3 : 0),
                                child: SvgPicture.asset("assets/graphics/icons/sense_hearing.svg", color: Color(Values.colorContentIconTintDark), width: 10))
                            : Container()
                      ])),
                  Container(
                      width: 165,
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, children: [
                        EntryIcon(
                            size: 40,
                            icon: Zone.getIconByZone(_zoneNow),
                            color: _zoneNow == 4
                                ? Values.colorContentIconTintDark
                                : _zoneNow == 3
                                    ? Values.colorContentIconTintLight
                                    : Values.colorContentIconTintAlwaysDark,
                            background: Zone.getColorByZone(_zoneNow)),
                        Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            alignment: Alignment.center,
                            height: 40,
                            width: 70,
                            child: AutoSizeText(
                              _zoneTill,
                              maxLines: 1,
                              style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize18, fontWeight: FontWeight.w400),
                            )),
                        EntryIcon(
                            size: 40,
                            icon: Zone.getIconByZone(_zoneNext),
                            color: _zoneNext == 4
                                ? Values.colorContentIconTintDark
                                : _zoneNext == 3
                                    ? Values.colorContentIconTintLight
                                    : Values.colorContentIconTintAlwaysDark,
                            background: Zone.getColorByZone(_zoneNext))
                      ]))
                ]))));
  }

  @override
  Widget build(BuildContext context) {
    _getZones();
    return _buildWidgets();
  }
}
