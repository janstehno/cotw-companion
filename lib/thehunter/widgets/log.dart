// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_log.dart';
import 'package:cotwcompanion/helpers/helper_settings.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/activities/add_edit_log.dart';
import 'package:cotwcompanion/thehunter/activities/animal_info.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/model/animal_fur.dart';
import 'package:cotwcompanion/thehunter/model/log.dart';
import 'package:cotwcompanion/thehunter/model/reserve.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_snackbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EntryLog extends StatefulWidget {
  final Log log;
  final Animal animal;
  final Reserve reserve;
  final AnimalFur animalFur;
  final bool trophyLodge;
  final int index;
  final int? style;
  final Function callback;
  final BuildContext context;
  final bool dismissible;

  const EntryLog(
      {Key? key,
      required this.log,
      required this.animal,
      required this.reserve,
      required this.animalFur,
      required this.trophyLodge,
      required this.index,
      this.style,
      required this.callback,
      required this.context,
      this.dismissible = true})
      : super(key: key);

  @override
  EntryLogState createState() => EntryLogState();
}

class EntryLogState extends State<EntryLog> {
  late Settings _settings;

  @override
  void initState() {
    _settings = Provider.of<Settings>(context, listen: false);
    super.initState();
  }

  _hideSnackBar() {
    ScaffoldMessenger.of(widget.context).hideCurrentSnackBar();
  }

  _undo() {
    LogHelper.undoRemove();
    _hideSnackBar();
    widget.callback();
  }

  _startToEnd() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ActivityLogsAddEdit(
                fromTrophyLodge: widget.log.getReserveID == -1,
                toEdit: {
                  "id": widget.log.getID,
                  "gender": widget.log.getGender,
                  "imperials": widget.log.getImperials,
                  "lodge": widget.log.lodge,
                  "correctAmmunition": widget.log.getCorrectAmmo,
                  "maxTwoShots": widget.log.getTwoShots,
                  "vitalOrgan": widget.log.getVitalOrgan,
                  "noTrophyOrgan": widget.log.getNoTrophyOrgan,
                  "trophy": widget.log.getTrophy,
                  "weight": widget.log.getWeight,
                  "animalID": widget.log.getAnimalID,
                  "reserveID": widget.log.getReserveID,
                  "furID": widget.log.getFurID,
                  //TROPHY RATING WITHOUT HARVEST CHECK
                  "trophyRating": widget.log.getTrophyRating(widget.animal, true),
                  "date": widget.log.getDate
                },
                callback: widget.callback)));
  }

  _endToStart() {
    setState(() {
      LogHelper.moveLogToLodge(widget.log.getID);
      widget.callback();
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1000),
      padding: const EdgeInsets.all(0),
      backgroundColor: Color(Values.colorSearchBackground),
      content: GestureDetector(
          onTap: () {
            _hideSnackBar();
          },
          child: WidgetSnackBar(text: widget.log.getLodge ? tr('item_moved_to_lodge') : tr('item_removed_from_lodge'))),
    ));
  }

  Widget _buildDate() {
    return Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Expanded(
          child: AutoSizeText(widget.log.getDateFormatted,
              maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize10, fontWeight: FontWeight.w400)))
    ]);
  }

  Widget _buildName() {
    return Container(
      height: 30,
      margin: EdgeInsets.only(right: 30, bottom: _settings.getCompactLogbook == 1 ? 1 : 5),
      alignment: Alignment.centerLeft,
      child: AutoSizeText(widget.animal.getNameBasedOnReserve(context.locale, widget.log.getReserveID).toUpperCase(),
          maxLines: 2,
          textAlign: TextAlign.left,
          style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w800, fontFamily: 'Title')),
    );
  }

  Widget _buildLodge() {
    return widget.log.getLodge
        ? Container(
            margin: EdgeInsets.only(right: 5, bottom: _settings.getCompactLogbook == 1 ? 1 : 4),
            alignment: Alignment.centerLeft,
            child: SvgPicture.asset("assets/graphics/icons/trophy_lodge.svg", width: 15, height: 15, color: Color(Values.colorPrimary)))
        : Container();
  }

  Widget _buildGender() {
    return Container(
        alignment: Alignment.centerRight,
        child: SvgPicture.asset(widget.log.getGender ? "assets/graphics/icons/male.svg" : "assets/graphics/icons/female.svg",
            width: 15, height: 15, color: widget.log.getGender ? Color(Values.colorMale) : Color(Values.colorFemale)));
  }

  Widget _buildReserve() {
    return Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: 15,
          height: 15,
          margin: const EdgeInsets.only(right: 5),
          alignment: Alignment.center,
          child: SizedBox(width: 10, height: 10, child: SvgPicture.asset("assets/graphics/icons/reserve.svg", width: 10, height: 10, color: Color(Values.colorDark)))),
      Expanded(
          child: Container(
              height: 15,
              alignment: Alignment.centerLeft,
              child: AutoSizeText(widget.reserve.getName(context.locale),
                  maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize10, fontWeight: FontWeight.w400))))
    ]);
  }

  Widget _buildFur() {
    return Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: 15,
          height: 15,
          margin: const EdgeInsets.only(right: 5),
          padding: const EdgeInsets.only(top: 2),
          alignment: Alignment.center,
          child: Container(
              width: 10,
              height: 10,
              decoration: ShapeDecoration(
                color: Color(widget.animalFur.getColor()),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ))),
      Expanded(
          child: Container(
              height: 15,
              alignment: Alignment.centerLeft,
              child: AutoSizeText(widget.animalFur.getName(context.locale),
                  maxLines: 1, textAlign: TextAlign.start, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize10, fontWeight: FontWeight.w400))))
    ]);
  }

  Widget _buildHarvestCheck() {
    return Container(
        height: widget.log.getWeight > 0 ? 50 : 30,
        margin: EdgeInsets.only(top: widget.log.getWeight > 0 ? 0 : 15),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: widget.log.getWeight > 0 ? CrossAxisAlignment.end : CrossAxisAlignment.center,
            children: [
              Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.only(right: 5),
                  alignment: Alignment.center,
                  child: SvgPicture.asset("assets/graphics/icons/harvest_correct_ammo.svg",
                      width: 15, height: 15, color: widget.log.getCorrectAmmo ? Color(Values.colorPrimary) : Color(Values.colorDisabled).withOpacity(0.3))),
              Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.only(right: 5, left: 5),
                  alignment: Alignment.center,
                  child: SvgPicture.asset("assets/graphics/icons/harvest_two_shots.svg",
                      width: 15, height: 15, color: widget.log.getTwoShots ? Color(Values.colorPrimary) : Color(Values.colorDisabled).withOpacity(0.3))),
              Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.only(right: 5, left: 5),
                  alignment: Alignment.center,
                  child: SvgPicture.asset("assets/graphics/icons/harvest_no_trophy_organ.svg",
                      width: 15, height: 15, color: widget.log.getNoTrophyOrgan ? Color(Values.colorPrimary) : Color(Values.colorDisabled).withOpacity(0.3))),
              Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.only(left: 5),
                  alignment: Alignment.center,
                  child: SvgPicture.asset("assets/graphics/icons/harvest_vital_organ.svg",
                      width: 15, height: 15, color: widget.log.getVitalOrgan ? Color(Values.colorPrimary) : Color(Values.colorDisabled).withOpacity(0.3))),
            ]));
  }

  Widget _buildTrophyWeight(bool buildWeight) {
    return ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: 120,
            maxWidth: 120,
            minHeight: widget.log.getWeight > 0 && buildWeight
                ? 50
                : _settings.getCompactLogbook == 3
                    ? 45
                    : 30,
            maxHeight: widget.log.getWeight > 0 && buildWeight
                ? 50
                : _settings.getCompactLogbook == 3
                    ? 45
                    : 30),
        child: Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(
                top: widget.log.getWeight > 0
                    ? 0
                    : _settings.getCompactLogbook == 3
                        ? 15
                        : 0),
            child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
              Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                    width: 25,
                    height: 30,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 5),
                    child: SvgPicture.asset(widget.log.getTrophyRatingIcon(widget.animal, true),
                        height: 20, width: 20, color: widget.log.getTrophyColor(widget.animal, true))),
                Container(
                    width: 12,
                    height: 30,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 5),
                    child: SvgPicture.asset(widget.log.getTrophyRatingIcon(widget.animal, false),
                        height: 20, width: 20, color: widget.log.getTrophyColor(widget.animal, false))),
                Expanded(
                    child: Container(
                        height: 30,
                        alignment: Alignment.centerRight,
                        child: AutoSizeText(widget.log.getTrophy.toString(),
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w800))))
              ]),
              widget.log.getWeight > 0 && buildWeight ? _buildWeight() : Container()
            ])));
  }

  Widget _buildWeight() {
    return SizedBox(
        height: 20,
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 10),
              child: AutoSizeText(widget.log.getImperials ? ("${widget.log.getWeight} ${tr('pounds')}") : ("${widget.log.getWeight} ${tr('kilograms')}"),
                  maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize14, fontWeight: FontWeight.w400)))
        ]));
  }

  Widget _buildLogCompact() {
    return Column(children: [
      _settings.getDateOfRecord ? _buildDate() : Container(),
      Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_buildLodge(), Expanded(child: _buildName()), _buildTrophyWeight(false)])
    ]);
  }

  Widget _buildLogSemiCompact() {
    return Column(children: [
      _settings.getDateOfRecord ? _buildDate() : Container(),
      Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_buildLodge(), Expanded(child: _buildName()), _buildTrophyWeight(false)]),
      Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Expanded(child: _buildFur()), _buildGender()])
    ]);
  }

  Widget _buildLogNonCompact() {
    return Column(children: [
      _settings.getDateOfRecord ? _buildDate() : Container(),
      Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_buildLodge(), Expanded(child: _buildName()), _buildGender()]),
      widget.log.getReserveID > -1 ? _buildReserve() : Container(),
      _buildFur(),
      Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Expanded(child: widget.log.getReserveID > -1 ? _buildHarvestCheck() : Container()), _buildTrophyWeight(true)])
    ]);
  }

  Widget _buildLog() {
    return Container(
        color: widget.index % 2 == 0 ? Color(Values.colorEven) : Color(Values.colorOdd),
        child: Padding(
            padding: EdgeInsets.fromLTRB(30, _settings.getCompactLogbook == 1 ? 20 : 25, 30, _settings.getCompactLogbook == 1 ? 20 : 25),
            child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
              (widget.style ?? _settings.getCompactLogbook) == 1
                  ? _buildLogCompact()
                  : (widget.style ?? _settings.getCompactLogbook) == 2
                      ? _buildLogSemiCompact()
                      : (widget.style ?? _settings.getCompactLogbook) == 3
                          ? _buildLogNonCompact()
                          : Container()
            ])));
  }

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          if (widget.dismissible) {
            setState(() {
              widget.callback();
            });
            Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityAnimalInfo(animalID: widget.animal.getID)));
          }
        },
        onDoubleTap: () {
          if (widget.dismissible) {
            setState(() {
              LogHelper.removeLogOnIndex(widget.log.getID);
              _hideSnackBar();
              widget.callback();
            });
          }
          ScaffoldMessenger.of(widget.context).showSnackBar(SnackBar(
              duration: const Duration(milliseconds: 5000),
              padding: const EdgeInsets.all(0),
              backgroundColor: Color(Values.colorSearchBackground),
              content: GestureDetector(
                  onTap: () {
                    _hideSnackBar();
                  },
                  child: WidgetSnackBar(
                      text: tr('item_removed'),
                      buttonIcon: "assets/graphics/icons/reload.svg",
                      buttonColor: Values.colorPrimary,
                      onTap: () {
                        _undo();
                      }))));
        },
        child: Dismissible(
            key: Key(widget.log.getID.toString()),
            direction: widget.dismissible
                ? widget.log.getReserveID == -1
                    ? DismissDirection.startToEnd
                    : DismissDirection.horizontal
                : DismissDirection.none,
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                _startToEnd();
                return false;
              } else {
                _endToStart();
                return false;
              }
            },
            background: Container(
                alignment: Alignment.centerLeft,
                color: const Color(Values.colorSeventh),
                child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: SvgPicture.asset(
                      "assets/graphics/icons/edit.svg",
                      height: 20,
                      width: 20,
                      color: Color(Values.colorAlwaysDark),
                      alignment: Alignment.centerLeft,
                    ))),
            secondaryBackground: Container(
                alignment: Alignment.centerRight,
                color: Color(Values.colorDark),
                child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: SvgPicture.asset(
                      "assets/graphics/icons/trophy_lodge.svg",
                      height: 20,
                      width: 20,
                      color: Color(Values.colorLight),
                      alignment: Alignment.centerLeft,
                    ))),
            child: _buildLog()));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
