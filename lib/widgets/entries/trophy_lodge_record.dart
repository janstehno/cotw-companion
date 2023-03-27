// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryTrophyLodgeRecord extends StatefulWidget {
  final Log log;
  final int index;

  const EntryTrophyLodgeRecord({
    Key? key,
    required this.log,
    required this.index,
  }) : super(key: key);

  @override
  EntryTrophyLodgeRecordState createState() => EntryTrophyLodgeRecordState();
}

class EntryTrophyLodgeRecordState extends State<EntryTrophyLodgeRecord> {
  late Animal _animal;

  Widget _buildName() {
    return Container(
      height: 30,
      padding: const EdgeInsets.only(right: 30),
      alignment: Alignment.centerLeft,
      child: AutoSizeText(_animal.getNameBasedOnReserve(context.locale, widget.log.reserveId),
          maxLines: 1,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Interface.dark,
            fontSize: Interface.s18,
            fontWeight: FontWeight.w600,
          )),
    );
  }

  Widget _buildGender() {
    return Container(
        height: 30,
        padding: const EdgeInsets.only(right: 8),
        alignment: Alignment.centerLeft,
        child: SvgPicture.asset(
          widget.log.isMale ? "assets/graphics/icons/male.svg" : "assets/graphics/icons/female.svg",
          width: 17,
          height: 17,
          color: widget.log.isMale ? Interface.male : Interface.female,
        ));
  }

  Widget _buildFur() {
    String furName = widget.log.fur.getName(context.locale);
    return Container(
        height: 20,
        alignment: widget.log.weight > 0 ? Alignment.bottomLeft : Alignment.centerLeft,
        child: AutoSizeText(furName,
            maxLines: 1,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Interface.dark,
              fontSize: Interface.s14,
              fontWeight: FontWeight.w400,
            )));
  }

  Widget _buildTrophy() {
    return Container(
        height: 30,
        width: 120,
        alignment: Alignment.centerRight,
        child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
          Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
                width: 25,
                height: 30,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 5),
                child: SvgPicture.asset(
                  widget.log.getTrophyRatingIcon(_animal, true),
                  height: 20,
                  width: 20,
                  color: widget.log.getTrophyColor(_animal, true),
                )),
            Container(
                width: 12,
                height: 30,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 5),
                child: SvgPicture.asset(
                  widget.log.getTrophyRatingIcon(_animal, false),
                  height: 20,
                  width: 20,
                  color: widget.log.getTrophyColor(_animal, false),
                )),
            Expanded(
                child: Container(
                    height: 30,
                    alignment: Alignment.centerRight,
                    child: AutoSizeText(widget.log.trophy.toString(),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Interface.dark,
                          fontSize: Interface.s20,
                          fontWeight: FontWeight.w800,
                        ))))
          ])
        ]));
  }

  Widget _buildWeight() {
    return Container(
        height: 20,
        alignment: Alignment.centerRight,
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 10),
              child: AutoSizeText(widget.log.usesImperials ? ("${widget.log.weight} ${tr('pounds')}") : ("${widget.log.weight} ${tr('kilograms')}"),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Interface.dark,
                    fontSize: Interface.s14,
                    fontWeight: FontWeight.w400,
                  )))
        ]));
  }

  Widget _buildWidgets() {
    _animal = HelperJSON.getAnimal(widget.log.animalId);
    return Container(
        color: widget.index % 2 == 0 ? Interface.even : Interface.odd,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Column(children: [
              Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                _buildGender(),
                Expanded(child: _buildName()),
                _buildTrophy(),
              ]),
              Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
                Expanded(child: _buildFur()),
                widget.log.weight > 0 ? _buildWeight() : Container(),
              ])
            ])));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
