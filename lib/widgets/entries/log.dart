// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/log.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/activities/logs_add_edit.dart';
import 'package:cotwcompanion/activities/info_animal.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/animal_fur.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/widgets/snackbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EntryLog extends StatefulWidget {
  final Log log;
  final Animal animal;
  final Reserve reserve;
  final AnimalFur animalFur;
  final int index;
  final int? style;
  final bool trophyLodge;
  final Function callback;
  final BuildContext context;

  const EntryLog({
    Key? key,
    required this.log,
    required this.animal,
    required this.reserve,
    required this.animalFur,
    required this.trophyLodge,
    required this.index,
    this.style,
    required this.callback,
    required this.context,
    dismissible = true,
  }) : super(key: key);

  @override
  EntryLogState createState() => EntryLogState();
}

class EntryLogState extends State<EntryLog> {
  late final int _compactLogbook;
  late final bool _dateOfRecord;

  @override
  void initState() {
    _compactLogbook = Provider.of<Settings>(context, listen: false).getCompactLogbook;
    _dateOfRecord = Provider.of<Settings>(context, listen: false).getDateOfRecord;
    super.initState();
  }

  void _hideSnackBar() {
    ScaffoldMessenger.of(widget.context).hideCurrentSnackBar();
  }

  void _undo() {
    HelperLog.undoRemove();
    _hideSnackBar();
    widget.callback();
  }

  void _startToEnd() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ActivityLogsAddEdit(
                  fromTrophyLodge: widget.log.reserveId == -1,
                  toEdit: {
                    "id": widget.log.id,
                    "gender": widget.log.isFemale,
                    "imperials": widget.log.usesImperials,
                    "lodge": widget.log.isInLodge,
                    "correctAmmunition": widget.log.correctAmmoUsed,
                    "maxTwoShots": widget.log.twoShotsFired,
                    "vitalOrgan": widget.log.vitalOrganHit,
                    "noTrophyOrgan": widget.log.trophyOrganUndamaged,
                    "trophy": widget.log.trophy,
                    "weight": widget.log.weight,
                    "animalId": widget.log.animalId,
                    "reserveId": widget.log.reserveId,
                    "furId": widget.log.furId,
                    //TROPHY RATING WITHOUT HARVEST CHECK
                    "trophyRating": widget.log.getTrophyRating(widget.animal, true),
                    "date": widget.log.date
                  },
                  callback: widget.callback,
                )));
  }

  void _endToStart() {
    setState(() {
      HelperLog.moveLogToLodge(widget.log.id);
      widget.callback();
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1000),
      padding: const EdgeInsets.all(0),
      backgroundColor: Interface.searchBackground,
      content: GestureDetector(
          onTap: () {
            _hideSnackBar();
          },
          child: WidgetSnackBar(
            text: widget.log.isInLodge ? tr('item_moved_to_lodge') : tr('item_removed_from_lodge'),
          )),
    ));
  }

  Widget _buildDate() {
    return Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Expanded(
          child: AutoSizeText(widget.log.dateFormatted,
              maxLines: 1,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Interface.dark,
                fontSize: Interface.s10,
                fontWeight: FontWeight.w400,
              )))
    ]);
  }

  Widget _buildName() {
    return Container(
      height: 30,
      margin: EdgeInsets.only(right: 30, bottom: _compactLogbook == 1 ? 1 : 5),
      alignment: Alignment.centerLeft,
      child: AutoSizeText(widget.animal.getNameBasedOnReserve(context.locale, widget.log.reserveId).toUpperCase(),
          maxLines: 2,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Interface.dark,
            fontSize: Interface.s20,
            fontWeight: FontWeight.w800,
            fontFamily: 'Title',
          )),
    );
  }

  Widget _buildLodge() {
    return widget.log.isInLodge
        ? Container(
            margin: EdgeInsets.only(right: 5, bottom: _compactLogbook == 1 ? 1 : 4),
            alignment: Alignment.centerLeft,
            child: SvgPicture.asset(
              "assets/graphics/icons/trophy_lodge.svg",
              width: 15,
              height: 15,
              color: Interface.primary,
            ))
        : Container();
  }

  Widget _buildGender() {
    return Container(
        alignment: Alignment.centerRight,
        child: SvgPicture.asset(
          widget.log.isFemale ? "assets/graphics/icons/male.svg" : "assets/graphics/icons/female.svg",
          width: 15,
          height: 15,
          color: widget.log.isFemale ? Interface.male : Interface.female,
        ));
  }

  Widget _buildReserve() {
    return Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: 15,
          height: 15,
          margin: const EdgeInsets.only(right: 5),
          alignment: Alignment.center,
          child: SizedBox(
              width: 10,
              height: 10,
              child: SvgPicture.asset(
                "assets/graphics/icons/reserve.svg",
                width: 10,
                height: 10,
                color: Interface.dark,
              ))),
      Expanded(
          child: Container(
              height: 15,
              alignment: Alignment.centerLeft,
              child: AutoSizeText(widget.reserve.getName(context.locale),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Interface.dark,
                    fontSize: Interface.s10,
                    fontWeight: FontWeight.w400,
                  ))))
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
                color: widget.animalFur.color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ))),
      Expanded(
          child: Container(
              height: 15,
              alignment: Alignment.centerLeft,
              child: AutoSizeText(widget.animalFur.getName(context.locale),
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Interface.dark,
                    fontSize: Interface.s10,
                    fontWeight: FontWeight.w400,
                  ))))
    ]);
  }

  Widget _buildHarvestCheck() {
    return Container(
        height: widget.log.weight > 0 ? 50 : 30,
        margin: EdgeInsets.only(top: widget.log.weight > 0 ? 0 : 15),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: widget.log.weight > 0 ? CrossAxisAlignment.end : CrossAxisAlignment.center,
            children: [
              Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.only(right: 5),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/graphics/icons/harvest_correct_ammo.svg",
                    width: 15,
                    height: 15,
                    color: widget.log.correctAmmoUsed ? Interface.primary : Interface.disabled.withOpacity(0.3),
                  )),
              Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.only(right: 5, left: 5),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/graphics/icons/harvest_two_shots.svg",
                    width: 15,
                    height: 15,
                    color: widget.log.twoShotsFired ? Interface.primary : Interface.disabled.withOpacity(0.3),
                  )),
              Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.only(right: 5, left: 5),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/graphics/icons/harvest_no_trophy_organ.svg",
                    width: 15,
                    height: 15,
                    color: widget.log.trophyOrganUndamaged ? Interface.primary : Interface.disabled.withOpacity(0.3),
                  )),
              Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.only(left: 5),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/graphics/icons/harvest_vital_organ.svg",
                    width: 15,
                    height: 15,
                    color: widget.log.vitalOrganHit ? Interface.primary : Interface.disabled.withOpacity(0.3),
                  )),
            ]));
  }

  Widget _buildTrophyWeight(bool buildWeight) {
    return ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: 120,
            maxWidth: 120,
            minHeight: widget.log.weight > 0 && buildWeight
                ? 50
                : _compactLogbook == 3
                    ? 45
                    : 30,
            maxHeight: widget.log.weight > 0 && buildWeight
                ? 50
                : _compactLogbook == 3
                    ? 45
                    : 30),
        child: Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(
                top: widget.log.weight > 0
                    ? 0
                    : _compactLogbook == 3
                        ? 15
                        : 0),
            child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
              Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                    width: 25,
                    height: 30,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 5),
                    child: SvgPicture.asset(
                      widget.log.getTrophyRatingIcon(widget.animal, true),
                      height: 20,
                      width: 20,
                      color: widget.log.getTrophyColor(widget.animal, true),
                    )),
                Container(
                    width: 12,
                    height: 30,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 5),
                    child: SvgPicture.asset(
                      widget.log.getTrophyRatingIcon(widget.animal, false),
                      height: 20,
                      width: 20,
                      color: widget.log.getTrophyColor(widget.animal, false),
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
              ]),
              widget.log.weight > 0 && buildWeight ? _buildWeight() : Container()
            ])));
  }

  Widget _buildWeight() {
    return SizedBox(
        height: 20,
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

  Widget _buildLogCompact() {
    return Column(children: [
      _dateOfRecord ? _buildDate() : Container(),
      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
        _buildLodge(),
        Expanded(child: _buildName()),
        _buildTrophyWeight(false),
      ])
    ]);
  }

  Widget _buildLogSemiCompact() {
    return Column(children: [
      _dateOfRecord ? _buildDate() : Container(),
      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
        _buildLodge(),
        Expanded(child: _buildName()),
        _buildTrophyWeight(false),
      ]),
      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(child: _buildFur()),
        _buildGender(),
      ])
    ]);
  }

  Widget _buildLogNonCompact() {
    return Column(children: [
      _dateOfRecord ? _buildDate() : Container(),
      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
        _buildLodge(),
        Expanded(child: _buildName()),
        _buildGender(),
      ]),
      widget.log.reserveId > -1 ? _buildReserve() : Container(),
      _buildFur(),
      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(child: widget.log.reserveId > -1 ? _buildHarvestCheck() : Container()),
        _buildTrophyWeight(true),
      ])
    ]);
  }

  Widget _buildLog() {
    return Container(
        color: widget.index % 2 == 0 ? Interface.even : Interface.odd,
        child: Padding(
            padding: EdgeInsets.fromLTRB(30, _compactLogbook == 1 ? 20 : 25, 30, _compactLogbook == 1 ? 20 : 25),
            child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
              (widget.style ?? _compactLogbook) == 1
                  ? _buildLogCompact()
                  : (widget.style ?? _compactLogbook) == 2
                      ? _buildLogSemiCompact()
                      : (widget.style ?? _compactLogbook) == 3
                          ? _buildLogNonCompact()
                          : Container()
            ])));
  }

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          setState(() {
            widget.callback();
          });
          Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityAnimalInfo(animalId: widget.animal.id)));
        },
        onDoubleTap: () {
          setState(() {
            HelperLog.removeLogOnIndex(widget.log.id);
            _hideSnackBar();
            widget.callback();
          });
          ScaffoldMessenger.of(widget.context).showSnackBar(SnackBar(
              duration: const Duration(milliseconds: 5000),
              padding: const EdgeInsets.all(0),
              backgroundColor: Interface.searchBackground,
              content: GestureDetector(
                  onTap: () {
                    _hideSnackBar();
                  },
                  child: WidgetSnackBar(
                    text: tr('item_removed'),
                    icon: "assets/graphics/icons/reload.svg",
                    iconColor: Interface.primary,
                    onTap: () {
                      _undo();
                    },
                  ))));
        },
        child: Dismissible(
            key: Key(widget.log.id.toString()),
            direction: widget.log.reserveId == -1 ? DismissDirection.startToEnd : DismissDirection.horizontal,
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
                color: Interface.green,
                child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: SvgPicture.asset(
                      "assets/graphics/icons/edit.svg",
                      height: 20,
                      width: 20,
                      color: Interface.alwaysDark,
                      alignment: Alignment.centerLeft,
                    ))),
            secondaryBackground: Container(
                alignment: Alignment.centerRight,
                color: Interface.dark,
                child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: SvgPicture.asset(
                      "assets/graphics/icons/trophy_lodge.svg",
                      height: 20,
                      width: 20,
                      color: Interface.light,
                      alignment: Alignment.centerLeft,
                    ))),
            child: _buildLog()));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
