// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_loadout.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryReserveAnimal extends StatefulWidget {
  final int animalID;
  final double height;
  final int? color;
  final int? background;
  final Function onDismiss;
  final Function onTap;

  const EntryReserveAnimal({Key? key, required this.animalID, this.height = 60, this.color, this.background, required this.onDismiss, required this.onTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => EntryReserveAnimalState();
}

class EntryReserveAnimalState extends State<EntryReserveAnimal> {
  late final Animal _animal;

  @override
  void initState() {
    _animal = JSONHelper.getAnimal(widget.animalID);
    super.initState();
  }

  Widget _buildWidgets() {
    return Dismissible(
        key: Key(widget.key.toString()),
        direction: DismissDirection.startToEnd,
        confirmDismiss: (direction) async {
          widget.onDismiss();
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
              widget.onTap();
            },
            child: Container(
                height: widget.height,
                color: Color(widget.background ?? Values.colorLight),
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(children: [
                  AutoSizeText(_animal.getLevel.toString(),
                      maxLines: 1, style: TextStyle(color: Color(widget.color ?? Values.colorDark), fontSize: Values.fontSize24, fontWeight: FontWeight.w600)),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.only(left: 15, right: 30),
                          child: AutoSizeText(_animal.getName(context.locale),
                              maxLines: 1, style: TextStyle(color: Color(widget.color ?? Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)))),
                  if (LoadoutHelper.isLoadoutActivated)
                    Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                      (LoadoutHelper.loadoutMin <= _animal.getLevel && _animal.getLevel <= LoadoutHelper.loadoutMax)
                          ? Container(
                          padding: EdgeInsets.only(bottom: (LoadoutHelper.containsCallerForAnimal(_animal.getID)) ? 3 : 0),
                              child: SvgPicture.asset("assets/graphics/icons/loadout.svg", color: Color(Values.colorDark), width: 11))
                          : Container(),
                      LoadoutHelper.containsCallerForAnimal(_animal.getID)
                          ? Container(
                          padding: EdgeInsets.only(top: (LoadoutHelper.loadoutMin <= _animal.getLevel && _animal.getLevel <= LoadoutHelper.loadoutMax) ? 3 : 0),
                              child: SvgPicture.asset("assets/graphics/icons/sense_hearing.svg", color: Color(Values.colorDark), width: 11))
                          : Container()
                    ]),
                  Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: _animal.getDlc
                          ? Container(
                              height: 9,
                              width: 9,
                              decoration: BoxDecoration(
                                  color: Color(Values.colorPrimary),
                                  border: Border.all(color: Color(Values.colorAccentBorder), width: Values.widthAccentBorder),
                                  borderRadius: BorderRadius.circular(5)))
                          : Container(width: 9))
                ]))));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
