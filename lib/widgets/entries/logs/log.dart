// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/activities/detail/animal.dart';
import 'package:cotwcompanion/activities/edit/logs.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/log.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/widgets/entries/logs/entry.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EntryLog extends EntryLogsEntry {
  final Function callback;
  final BuildContext context;

  const EntryLog({
    super.key,
    required super.index,
    required super.log,
    required this.callback,
    required this.context,
  });

  @override
  EntryLogState createState() => EntryLogState();
}

class EntryLogState extends EntryLogsEntryState {
  final double lodgeIconSize = 15;
  final double reserveIconHeight = 15;
  final double reserveIconSize = 10;
  final double harvestHeight = 30;
  final double harvestWidth = 20;
  final double harvestIconSize = 15;
  final double trophyWeightWidth = 100;
  final double editIconSize = 20;
  final double toLodgeIconSize = 20;

  late final Function _callback;

  late int _style;

  @override
  void initState() {
    _callback = (widget as EntryLog).callback;
    super.initState();
  }

  @override
  void getData() {
    _style = settings.compactLogbook;
    super.getData();
  }

  void undo() {
    HelperLog.undoRemove();
    _callback();
  }

  void startToEnd() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityEditLogs(log: widget.log, fromTrophyLodge: widget.log.reserveId == -1, callback: _callback)));
  }

  void endToStart() {
    setState(() {
      HelperLog.moveLogToLodge(widget.log.id);
      _callback();
    });
    Utils.buildSnackBarMessage(
      widget.log.isInLodge ? tr("item_moved_to_lodge") : tr("item_removed_from_lodge"),
      Process.info,
      (widget as EntryLog).context,
    );
  }

  Widget _buildDate() {
    return Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: dateHeight,
          height: dateHeight,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 5),
          padding: const EdgeInsets.all(3),
          child: SvgPicture.asset(
            "assets/graphics/icons/sort_date.svg",
            width: dateIconSize,
            height: dateIconSize,
            colorFilter: ColorFilter.mode(
              Interface.dark,
              BlendMode.srcIn,
            ),
          )),
      Expanded(
          child: Container(
              height: dateHeight,
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                widget.log.dateFormatted,
                maxLines: 1,
                minFontSize: 8,
                textAlign: TextAlign.left,
                style: Interface.s12w300n(Interface.dark.withOpacity(0.75)),
              )))
    ]);
  }

  Widget buildLodge() {
    return widget.log.isInLodge
        ? Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(right: 5),
            child: SvgPicture.asset(
              "assets/graphics/icons/trophy_lodge.svg",
              width: lodgeIconSize,
              height: lodgeIconSize,
              colorFilter: ColorFilter.mode(
                Interface.primary,
                BlendMode.srcIn,
              ),
            ))
        : const SizedBox.shrink();
  }

  Widget buildReserve() {
    return Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: reserveIconHeight,
          height: reserveIconHeight,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 5),
          child: SvgPicture.asset(
            "assets/graphics/icons/reserve.svg",
            width: reserveIconSize,
            height: reserveIconSize,
            colorFilter: ColorFilter.mode(
              Interface.dark,
              BlendMode.srcIn,
            ),
          )),
      Expanded(
          child: Container(
              height: reserveIconHeight,
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                reserve.getName(context.locale),
                maxLines: 1,
                minFontSize: 8,
                textAlign: TextAlign.left,
                style: Interface.s14w300n(Interface.dark.withOpacity(0.75)),
              )))
    ]);
  }

  Widget buildHarvestCheckIcon(String icon, bool checked) {
    return Container(
        height: harvestHeight,
        width: harvestWidth,
        margin: const EdgeInsets.only(right: 10),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          "assets/graphics/icons/$icon.svg",
          width: harvestIconSize,
          height: harvestIconSize,
          colorFilter: ColorFilter.mode(
            checked ? Interface.primary : Interface.disabled.withOpacity(0.3),
            BlendMode.srcIn,
          ),
        ));
  }

  Widget buildHarvestCheck() {
    return Container(
        height: harvestHeight,
        margin: const EdgeInsets.only(top: 15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildHarvestCheckIcon("harvest_correct_ammo", widget.log.correctAmmoUsed),
            buildHarvestCheckIcon("harvest_two_shots", widget.log.twoShotsFired),
            buildHarvestCheckIcon("harvest_no_trophy_organ", widget.log.trophyOrganUndamaged),
            buildHarvestCheckIcon("harvest_vital_organ", widget.log.vitalOrganHit),
          ],
        ));
  }

  Widget buildNameTrophy() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Row(
          children: [
            buildLodge(),
            Expanded(
              child: buildName(),
            )
          ],
        )),
        buildTrophy(),
      ],
    );
  }

  Widget buildLogCompact() {
    return Column(children: [
      buildNameTrophy(),
      entryDate ? _buildDate() : const SizedBox.shrink(),
    ]);
  }

  Widget buildLogSemiCompact() {
    return Column(children: [
      buildNameTrophy(),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
              child: Column(children: [
            entryDate ? _buildDate() : const SizedBox.shrink(),
            buildFur(),
          ])),
          buildGender(),
        ],
      )
    ]);
  }

  Widget buildLogNonCompact() {
    return Column(children: [
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildLodge(),
          Expanded(child: buildName()),
          buildGender(),
        ],
      ),
      entryDate ? _buildDate() : const SizedBox.shrink(),
      widget.log.reserveId > -1 ? buildReserve() : const SizedBox.shrink(),
      buildFur(),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: widget.log.reserveId > -1 ? buildHarvestCheck() : const SizedBox.shrink()),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              widget.log.weight > 0 ? buildWeight() : const SizedBox.shrink(),
              buildTrophy(),
            ],
          ),
        ],
      )
    ]);
  }

  @override
  Widget buildEntry() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityDetailAnimal(animalId: animal.id)));
      },
      onDoubleTap: () {
        setState(() {
          HelperLog.removeLogOnIndex(widget.log.id);
          _callback();
        });
        Utils.buildSnackBarUndo(
          tr("item_removed"),
          Process.info,
          undo,
          (widget as EntryLog).context,
        );
      },
      child: Dismissible(
        key: Key(widget.log.id.toString()),
        direction: widget.log.reserveId == -1 ? DismissDirection.startToEnd : DismissDirection.horizontal,
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            startToEnd();
          } else {
            endToStart();
          }
          return false;
        },
        background: Container(
            alignment: Alignment.centerLeft,
            color: Interface.green,
            child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SvgPicture.asset(
                  "assets/graphics/icons/edit.svg",
                  height: editIconSize,
                  width: editIconSize,
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
                  height: toLodgeIconSize,
                  width: toLodgeIconSize,
                  alignment: Alignment.centerLeft,
                  colorFilter: ColorFilter.mode(
                    Interface.light,
                    BlendMode.srcIn,
                  ),
                ))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _style == 1
                  ? buildLogCompact()
                  : _style == 2
                      ? buildLogSemiCompact()
                      : _style == 3
                          ? buildLogNonCompact()
                          : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
