// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/model/log.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryRecord extends StatefulWidget {
  final Log log;
  final int index;

  const EntryRecord({Key? key, required this.log, required this.index}) : super(key: key);

  @override
  EntryRecordState createState() => EntryRecordState();
}

class EntryRecordState extends State<EntryRecord> {
  late Animal animal;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildName() {
    return Container(
      height: 30,
      padding: const EdgeInsets.only(right: 30),
      alignment: Alignment.centerLeft,
      child: AutoSizeText(animal.getNameBasedOnReserve(context.locale, widget.log.getReserveID),
          maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize18, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildGender() {
    return Container(
        height: 30,
        padding: const EdgeInsets.only(right: 8),
        alignment: Alignment.centerLeft,
        child: SvgPicture.asset(widget.log.getGender ? "assets/graphics/icons/male.svg" : "assets/graphics/icons/female.svg",
            width: 17, height: 17, color: widget.log.getGender ? Color(Values.colorMale) : Color(Values.colorFemale)));
  }

  Widget _buildFur() {
    String furName = widget.log.getAnimalFur().getName(context.locale);
    return Container(
        height: 20,
        alignment: widget.log.getWeight > 0 ? Alignment.bottomLeft : Alignment.centerLeft,
        child: AutoSizeText(furName,
            maxLines: 1, textAlign: TextAlign.start, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize14, fontWeight: FontWeight.w400)));
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
                child: SvgPicture.asset(widget.log.getTrophyRatingIcon(animal, true), height: 20, width: 20, color: widget.log.getTrophyColor(animal, true))),
            Container(
                width: 12,
                height: 30,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 5),
                child: SvgPicture.asset(widget.log.getTrophyRatingIcon(animal, false), height: 20, width: 20, color: widget.log.getTrophyColor(animal, false))),
            Expanded(
                child: Container(
                    height: 30,
                    alignment: Alignment.centerRight,
                    child: AutoSizeText(widget.log.getTrophy.toString(),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w800))))
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
              child: AutoSizeText(widget.log.getImperials ? ("${widget.log.getWeight} ${tr('pounds')}") : ("${widget.log.getWeight} ${tr('kilograms')}"),
                  maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize14, fontWeight: FontWeight.w400)))
        ]));
  }

  Widget _buildWidgets() {
    return Container(
        color: widget.index % 2 == 0 ? Color(Values.colorEven) : Color(Values.colorOdd),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Column(children: [
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [_buildGender(), Expanded(child: _buildName()), _buildTrophy()]),
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [Expanded(child: _buildFur()), widget.log.getWeight > 0 ? _buildWeight() : Container()])
            ])));
  }

  @override
  Widget build(BuildContext context) {
    animal = JSONHelper.getAnimal(widget.log.getAnimalID);
    return _buildWidgets();
  }
}
