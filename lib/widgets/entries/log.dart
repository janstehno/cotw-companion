// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/activities/info_animal.dart';
import 'package:cotwcompanion/activities/logs_add_edit.dart';
import 'package:cotwcompanion/miscellaneous/helpers/log.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
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
  final int index;
  final Log log;
  final Function callback;
  final BuildContext context;

  const EntryLog({
    Key? key,
    required this.index,
    required this.log,
    required this.callback,
    required this.context,
    dismissible = true,
  }) : super(key: key);

  @override
  EntryLogState createState() => EntryLogState();
}

class EntryLogState extends State<EntryLog> {
  late final Settings _settings;

  late int _style;
  late bool _dateOfRecord;
  late Reserve _reserve;
  late Animal _animal;
  late AnimalFur _fur;

  @override
  void initState() {
    _settings = Provider.of<Settings>(context, listen: false);
    super.initState();
  }

  void _getData() {
    _style = _settings.getCompactLogbook;
    _dateOfRecord = _settings.getDateOfRecord;
    _reserve = widget.log.reserve;
    _animal = widget.log.animal;
    _fur = widget.log.fur;
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
                  log: widget.log,
                  fromTrophyLodge: widget.log.reserveId == -1,
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
      backgroundColor: Interface.search,
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
    return Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: 15,
          height: 15,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 5),
          child: SvgPicture.asset(
            "assets/graphics/icons/sort_date.svg",
            width: 9,
            height: 9,
            colorFilter: ColorFilter.mode(
              Interface.dark,
              BlendMode.srcIn,
            ),
          )),
      Expanded(
          child: Container(
              height: 15,
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                widget.log.dateFormatted,
                maxLines: 1,
                minFontSize: 10,
                textAlign: TextAlign.left,
                style: Interface.s12w300n(Interface.dark.withOpacity(0.75)),
              )))
    ]);
  }

  Widget _buildName() {
    return Container(
      height: 30,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(right: 30),
      child: AutoSizeText(
        _animal.getNameBasedOnReserve(context.locale, widget.log.reserveId),
        maxLines: 2,
        textAlign: TextAlign.left,
        style: Interface.s18w300n(Interface.dark),
      ),
    );
  }

  Widget _buildLodge() {
    return widget.log.isInLodge
        ? Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(right: 5),
            child: SvgPicture.asset(
              "assets/graphics/icons/trophy_lodge.svg",
              width: 15,
              height: 15,
              colorFilter: ColorFilter.mode(
                Interface.primary,
                BlendMode.srcIn,
              ),
            ))
        : const SizedBox.shrink();
  }

  Widget _buildGender() {
    return Container(
        alignment: Alignment.centerRight,
        child: SvgPicture.asset(
          widget.log.isMale ? "assets/graphics/icons/gender_male.svg" : "assets/graphics/icons/gender_female.svg",
          width: 15,
          height: 15,
          colorFilter: ColorFilter.mode(
            widget.log.isMale ? Interface.male : Interface.female,
            BlendMode.srcIn,
          ),
        ));
  }

  Widget _buildReserve() {
    return Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: 15,
          height: 15,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 5),
          child: SvgPicture.asset(
            "assets/graphics/icons/reserve.svg",
            width: 10,
            height: 10,
            colorFilter: ColorFilter.mode(
              Interface.dark,
              BlendMode.srcIn,
            ),
          )),
      Expanded(
          child: Container(
              height: 15,
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                _reserve.getName(context.locale),
                maxLines: 1,
                minFontSize: 10,
                textAlign: TextAlign.left,
                style: Interface.s14w300n(Interface.dark.withOpacity(0.75)),
              )))
    ]);
  }

  Widget _buildFur() {
    return Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: 15,
          height: 15,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 5),
          child: Container(
              width: 9,
              height: 9,
              decoration: ShapeDecoration(
                color: _fur.color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
              ))),
      Expanded(
          child: Container(
              height: 15,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(right: _style == 2 ? 30 : 0),
              child: AutoSizeText(
                _fur.getName(context.locale),
                maxLines: 1,
                minFontSize: 10,
                textAlign: TextAlign.left,
                style: Interface.s14w300n(Interface.dark.withOpacity(0.75)),
              )))
    ]);
  }

  Widget _buildHarvestCheckIcon(String icon, bool checked) {
    return Container(
        height: 20,
        width: 20,
        margin: const EdgeInsets.only(right: 10),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          "assets/graphics/icons/$icon.svg",
          width: 15,
          height: 15,
          colorFilter: ColorFilter.mode(
            checked ? Interface.primary : Interface.disabled.withOpacity(0.3),
            BlendMode.srcIn,
          ),
        ));
  }

  Widget _buildHarvestCheck() {
    return Container(
        height: 30,
        margin: const EdgeInsets.only(top: 15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHarvestCheckIcon("harvest_correct_ammo", widget.log.correctAmmoUsed),
            _buildHarvestCheckIcon("harvest_two_shots", widget.log.twoShotsFired),
            _buildHarvestCheckIcon("harvest_no_trophy_organ", widget.log.trophyOrganUndamaged),
            _buildHarvestCheckIcon("harvest_vital_organ", widget.log.vitalOrganHit),
          ],
        ));
  }

  Widget _buildTrophyWeight(bool buildWeight) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 100,
          maxWidth: 100,
          minHeight: (widget.log.weight > 0 && buildWeight) || _style == 3 ? 45 : 30,
          maxHeight: (widget.log.weight > 0 && buildWeight) || _style == 3 ? 45 : 30,
        ),
        child: Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: (widget.log.weight > 0 && buildWeight) || (_style == 1 || _style == 2) ? 0 : 15),
            child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
              widget.log.weight > 0 && buildWeight ? _buildWeight() : const SizedBox.shrink(),
              Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                    width: 20,
                    height: 30,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 5),
                    child: SvgPicture.asset(
                      widget.log.getTrophyRatingIcon(),
                      fit: BoxFit.fitWidth,
                      colorFilter: ColorFilter.mode(
                        widget.log.getTrophyColor(),
                        BlendMode.srcIn,
                      ),
                    )),
                Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: AutoSizeText(
                          widget.log.removePointZero("${widget.log.trophy}"),
                          maxLines: 1,
                          minFontSize: 10,
                          style: Interface.s16w500n(Interface.dark),
                        )))
              ]),
            ])));
  }

  Widget _buildWeight() {
    return SizedBox(
        height: 15,
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 10),
              child: AutoSizeText(
                widget.log.removePointZero("${widget.log.weight} ${widget.log.usesImperials ? tr('pounds') : tr('kilograms')}"),
                maxLines: 1,
                minFontSize: 10,
                textAlign: TextAlign.left,
                style: Interface.s14w300n(Interface.dark),
              ))
        ]));
  }

  Widget _buildLogCompact() {
    return Column(children: [
      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Row(children: [_buildLodge(), Expanded(child: _buildName())])),
        _buildTrophyWeight(false),
      ]),
      _dateOfRecord ? _buildDate() : const SizedBox.shrink(),
    ]);
  }

  Widget _buildLogSemiCompact() {
    return Column(children: [
      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Row(children: [_buildLodge(), Expanded(child: _buildName())])),
        _buildTrophyWeight(false),
      ]),
      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
        Expanded(
            child: Column(children: [
          _dateOfRecord ? _buildDate() : const SizedBox.shrink(),
          widget.log.isGreatOne() ? const SizedBox.shrink() : _buildFur(),
        ])),
        _buildGender(),
      ])
    ]);
  }

  Widget _buildLogNonCompact() {
    return Column(children: [
      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
        _buildLodge(),
        Expanded(child: _buildName()),
        _buildGender(),
      ]),
      _dateOfRecord ? _buildDate() : const SizedBox.shrink(),
      widget.log.reserveId > -1 ? _buildReserve() : const SizedBox.shrink(),
      widget.log.isGreatOne() ? const SizedBox.shrink() : _buildFur(),
      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(child: widget.log.reserveId > -1 ? _buildHarvestCheck() : const SizedBox.shrink()),
        _buildTrophyWeight(true),
      ])
    ]);
  }

  Widget _buildLog() {
    return Container(
        color: widget.index % 2 == 0 ? Interface.even : Interface.odd,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
            child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
              _style == 1
                  ? _buildLogCompact()
                  : _style == 2
                      ? _buildLogSemiCompact()
                      : _style == 3
                          ? _buildLogNonCompact()
                          : const SizedBox.shrink()
            ])));
  }

  Widget _buildWidgets() {
    _getData();
    return GestureDetector(
        onTap: () {
          setState(() {
            widget.callback();
          });
          Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityAnimalInfo(animalId: _animal.id)));
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
              backgroundColor: Interface.search,
              content: GestureDetector(
                  onTap: () {
                    _hideSnackBar();
                  },
                  child: WidgetSnackBar(
                    text: tr('item_removed'),
                    icon: "assets/graphics/icons/reload.svg",
                    onSnackBarTap: () {
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
                      alignment: Alignment.centerLeft,
                      colorFilter: const ColorFilter.mode(
                        Interface.alwaysDark,
                        BlendMode.srcIn,
                      ),
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
                      alignment: Alignment.centerLeft,
                      colorFilter: ColorFilter.mode(
                        Interface.light,
                        BlendMode.srcIn,
                      ),
                    ))),
            child: _buildLog()));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
