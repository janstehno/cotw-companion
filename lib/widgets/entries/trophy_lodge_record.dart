// Copyright (c) 2022 - 2023 Jan Stehno

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
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(right: 10),
      child: AutoSizeText(_animal.getNameBasedOnReserve(context.locale, widget.log.reserveId).toUpperCase(),
          maxLines: 2,
          minFontSize: 10,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Interface.dark,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Condensed',
          )),
    );
  }

  Widget _buildGender() {
    return Container(
        width: 15,
        height: 15,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 5),
        child: SvgPicture.asset(
          widget.log.isMale ? "assets/graphics/icons/male.svg" : "assets/graphics/icons/female.svg",
          width: 13,
          height: 13,
          color: widget.log.isMale ? Interface.male : Interface.female,
        ));
  }

  Widget _buildFur() {
    String furName = widget.log.fur.getName(context.locale);
    return Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: 15,
          height: 15,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 5),
          child: Container(
              width: 10,
              height: 10,
              decoration: ShapeDecoration(
                color: widget.log.fur.color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ))),
      Expanded(
          child: Container(
              height: 15,
              alignment: Alignment.centerLeft,
              child: AutoSizeText(furName,
                  maxLines: 1,
                  minFontSize: 10,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Interface.dark,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ))))
    ]);
  }

  Widget _buildTrophy() {
    return ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 110,
          maxWidth: 110,
          minHeight: 30,
          maxHeight: 30,
        ),
        child: Container(
            alignment: Alignment.centerRight,
            child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
              Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                    width: 20,
                    height: 30,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 5),
                    child: SvgPicture.asset(
                      widget.log.getTrophyRatingIcon(_animal, true),
                      color: widget.log.getTrophyColor(_animal, true),
                      fit: BoxFit.fitWidth,
                    )),
                Container(
                    width: 10,
                    height: 30,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 10),
                    child: SvgPicture.asset(
                      widget.log.getTrophyRatingIcon(_animal, false),
                      color: widget.log.getTrophyColor(_animal, false),
                      fit: BoxFit.fitWidth,
                    )),
                Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: AutoSizeText(widget.log.trophy.toString(),
                            maxLines: 1,
                            minFontSize: 10,
                            style: TextStyle(
                              color: Interface.dark,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ))))
              ]),
            ])));
  }

  Widget _buildWeight() {
    return SizedBox(
        width: 65,
        height: 15,
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 10),
              child: AutoSizeText(widget.log.usesImperials ? ("${widget.log.weight} ${tr('pounds')}") : ("${widget.log.weight} ${tr('kilograms')}"),
                  maxLines: 1,
                  minFontSize: 10,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Interface.dark,
                    fontSize: 14,
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
                Expanded(child: widget.log.fur.furId == Interface.greatOneId ? Container() : _buildFur()),
                widget.log.weight > 0 ? _buildWeight() : Container(),
              ])
            ])));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
