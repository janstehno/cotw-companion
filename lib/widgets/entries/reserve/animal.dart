// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EntryReserveAnimal extends StatefulWidget {
  final int animalId, reserveId;
  final Color color, background;
  final Function onDismiss;
  final Function onTap;

  final double height = 60;

  const EntryReserveAnimal({
    Key? key,
    required this.animalId,
    required this.reserveId,
    required this.color,
    required this.background,
    required this.onDismiss,
    required this.onTap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EntryReserveAnimalState();
}

class EntryReserveAnimalState extends State<EntryReserveAnimal> {
  final double _editIconSize = 20;
  final double _loadoutIconSize = 10;
  final double _dotSize = 10;

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
                  width: _editIconSize,
                  height: _editIconSize,
                  alignment: Alignment.centerLeft,
                  colorFilter: ColorFilter.mode(
                    Interface.light,
                    BlendMode.srcIn,
                  ),
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
                  AutoSizeText(
                    _animal.level.toString(),
                    maxLines: 1,
                    style: Interface.s18w500n(Interface.dark),
                  ),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.only(left: 15, right: 30),
                          child: AutoSizeText(
                            _animal.getNameBasedOnReserve(context.locale, widget.reserveId),
                            maxLines: 1,
                            style: Interface.s16w300n(Interface.dark),
                          ))),
                  if (HelperLoadout.isLoadoutActivated)
                    Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                      (HelperLoadout.loadoutMin <= _animal.level && _animal.level <= HelperLoadout.loadoutMax)
                          ? Container(
                              padding: EdgeInsets.only(bottom: HelperLoadout.containsCallerForAnimal(_animal.id) ? 3 : 0),
                              child: SvgPicture.asset(
                                "assets/graphics/icons/loadout.svg",
                                width: _loadoutIconSize,
                                colorFilter: ColorFilter.mode(
                                  Interface.dark,
                                  BlendMode.srcIn,
                                ),
                              ))
                          : const SizedBox.shrink(),
                      HelperLoadout.containsCallerForAnimal(_animal.id)
                          ? Container(
                              padding: EdgeInsets.only(top: (HelperLoadout.loadoutMin <= _animal.level && _animal.level <= HelperLoadout.loadoutMax) ? 3 : 0),
                              child: SvgPicture.asset(
                                "assets/graphics/icons/sense_hearing.svg",
                                width: _loadoutIconSize,
                                colorFilter: ColorFilter.mode(
                                  Interface.dark,
                                  BlendMode.srcIn,
                                ),
                              ))
                          : const SizedBox.shrink()
                    ]),
                  Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: _animal.isFromDlc
                          ? Container(
                              height: _dotSize,
                              width: _dotSize,
                              decoration: BoxDecoration(
                                color: Interface.primary,
                                border: Border.all(
                                  color: Interface.accentBorder,
                                  width: Interface.accentBorderWidth,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ))
                          : Container(
                              width: _dotSize,
                            ))
                ]))));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
