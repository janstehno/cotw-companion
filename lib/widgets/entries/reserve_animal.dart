// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryReserveAnimal extends StatefulWidget {
  final int animalId;
  final Color color, background;
  final Function onDismiss;
  final Function onTap;
  final double height = 60;

  const EntryReserveAnimal({
    Key? key,
    required this.animalId,
    required this.color,
    required this.background,
    required this.onDismiss,
    required this.onTap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EntryReserveAnimalState();
}

class EntryReserveAnimalState extends State<EntryReserveAnimal> {
  late final Animal _animal;

  @override
  void initState() {
    _animal = HelperJSON.getAnimal(widget.animalId);
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
              widget.onTap();
            },
            child: Container(
                height: widget.height,
                color: widget.background,
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(children: [
                  AutoSizeText(_animal.level.toString(),
                      maxLines: 1,
                      style: TextStyle(
                        color: widget.color,
                        fontSize: Interface.s24,
                        fontWeight: FontWeight.w600,
                      )),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.only(left: 15, right: 30),
                          child: AutoSizeText(_animal.getName(context.locale),
                              maxLines: 1,
                              style: TextStyle(
                                color: widget.color,
                                fontSize: Interface.s20,
                                fontWeight: FontWeight.w400,
                              )))),
                  if (HelperLoadout.isLoadoutActivated)
                    Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                      (HelperLoadout.loadoutMin <= _animal.level && _animal.level <= HelperLoadout.loadoutMax)
                          ? Container(
                              padding: EdgeInsets.only(bottom: (HelperLoadout.containsCallerForAnimal(_animal.id)) ? 3 : 0),
                              child: SvgPicture.asset(
                                "assets/graphics/icons/loadout.svg",
                                width: 11,
                                color: Interface.dark,
                              ))
                          : Container(),
                      HelperLoadout.containsCallerForAnimal(_animal.id)
                          ? Container(
                              padding: EdgeInsets.only(top: (HelperLoadout.loadoutMin <= _animal.level && _animal.level <= HelperLoadout.loadoutMax) ? 3 : 0),
                              child: SvgPicture.asset(
                                "assets/graphics/icons/sense_hearing.svg",
                                width: 11,
                                color: Interface.dark,
                              ))
                          : Container()
                    ]),
                  Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: _animal.isFromDlc
                          ? Container(
                              height: 9,
                              width: 9,
                              decoration: BoxDecoration(
                                color: Interface.primary,
                                border: Border.all(
                                  color: Interface.accentBorder,
                                  width: Interface.accentBorderWidth,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ))
                          : Container(width: 9))
                ]))));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
