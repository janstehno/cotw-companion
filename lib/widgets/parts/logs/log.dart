import 'package:cotwcompanion/activities/detail/animal.dart';
import 'package:cotwcompanion/activities/modify/edit/logs.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/log.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/parts/logs/dismissible.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WidgetLog extends WidgetLogsDismissible {
  final bool _trophyLodge;

  const WidgetLog(
    super.i, {
    super.key,
    required bool trophyLodge,
    required super.log,
    required super.callback,
    required super.context,
  }) : _trophyLodge = trophyLodge;

  bool get trophyLodge => _trophyLodge;

  @override
  EntryLogState createState() => EntryLogState();
}

class EntryLogState extends WidgetLogsDismissibleState {
  final double _iconSize = 15;
  final double _harvestWidth = 30;
  final double _harvestHeight = 30;

  @override
  void undo() {
    HelperLog.undoRemove();
    if ((widget as WidgetLog).callback != null) (widget as WidgetLog).callback!();
  }

  @override
  void onTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (e) => ActivityDetailAnimal(
          (widget as WidgetLogsDismissible).log.animal!,
        ),
      ),
    );
  }

  @override
  void onDoubleTap() {
    Utils.buildSnackBarUndo(
      tr("ITEM_REMOVED"),
      Process.info,
      undo,
      (widget as WidgetLog).context,
    );
    setState(() {
      HelperLog.removeLog((widget as WidgetLogsDismissible).log);
      if ((widget as WidgetLog).callback != null) (widget as WidgetLog).callback!();
    });
  }

  @override
  void startToEnd() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (e) => ActivityEditLogs(
          log: (widget as WidgetLogsDismissible).log,
          trophyLodgeOnly: (widget as WidgetLog).log.reserve == null,
          onSuccess: (widget as WidgetLog).callback ?? () {},
        ),
      ),
    );
  }

  @override
  void endToStart() {
    if ((widget as WidgetLog).log.reserve != null) {
      Utils.buildSnackBarMessage(
        (widget as WidgetLogsDismissible).log.isInLodge ? tr("ITEM_MOVED_TO_LODGE") : tr("ITEM_REMOVED_FROM_LODGE"),
        Process.info,
        (widget as WidgetLog).context,
      );
      setState(() {
        HelperLog.moveLogToLodge((widget as WidgetLogsDismissible).log);
        if ((widget as WidgetLog).callback != null) (widget as WidgetLog).callback!();
      });
    }
  }

  Widget buildLodge() {
    return WidgetIcon.withSize(
      Assets.graphics.icons.trophyLodge,
      color: Interface.primary,
      size: _iconSize,
    );
  }

  Widget _buildDateIcon() {
    return Container(
      width: dateHeight,
      height: dateHeight,
      alignment: Alignment.center,
      child: WidgetIcon.withSize(
        Assets.graphics.icons.sortDate,
        color: Interface.dark,
        size: dateHeight - 5,
      ),
    );
  }

  Widget _buildDateValue() {
    return Container(
      height: dateHeight,
      alignment: Alignment.centerLeft,
      child: WidgetText(
        Utils.dateTimeAs(DateStructure.format, (widget as WidgetLogsDismissible).log.dateTime),
        color: Interface.dark,
        style: Style.normal.s12.w300,
      ),
    );
  }

  Widget _buildDate() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildDateIcon(),
        const SizedBox(width: 5),
        Expanded(child: _buildDateValue()),
      ],
    );
  }

  Widget _buildReserveIcon() {
    return Container(
      height: _iconSize,
      alignment: Alignment.center,
      child: WidgetIcon(
        Assets.graphics.icons.reserve,
        color: Interface.dark,
      ),
    );
  }

  Widget _buildReserveValue() {
    return Container(
      height: _iconSize,
      alignment: Alignment.centerLeft,
      child: WidgetText(
        (widget as WidgetLogsDismissible).log.reserve!.name,
        color: Interface.dark,
        style: Style.normal.s14.w300,
      ),
    );
  }

  Widget _buildReserve() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildReserveIcon(),
        const SizedBox(width: 5),
        Expanded(child: _buildReserveValue()),
      ],
    );
  }

  Widget _buildHarvestCheckIcon(String icon, bool checked) {
    return SizedBox(
      height: _harvestHeight,
      width: _harvestWidth,
      child: WidgetMargin.right(
        10,
        alignment: Alignment.center,
        child: WidgetIcon(
          icon,
          color: checked ? Interface.primary : Interface.disabled,
        ),
      ),
    );
  }

  Widget _buildHarvestCheck() {
    return SizedBox(
      height: _harvestHeight,
      child: WidgetMargin.top(
        15,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHarvestCheckIcon(
              Assets.graphics.icons.harvestCorrectAmmo,
              (widget as WidgetLogsDismissible).log.correctAmmo,
            ),
            _buildHarvestCheckIcon(
              Assets.graphics.icons.harvestTwoShots,
              (widget as WidgetLogsDismissible).log.twoShots,
            ),
            _buildHarvestCheckIcon(
              Assets.graphics.icons.harvestNoTrophyOrgan,
              (widget as WidgetLogsDismissible).log.trophyOrgan,
            ),
            _buildHarvestCheckIcon(
              Assets.graphics.icons.harvestVitalOrgan,
              (widget as WidgetLogsDismissible).log.vitalOrgan,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameTrophy() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              if ((widget as WidgetLogsDismissible).log.isInLodge) ...[buildLodge(), const SizedBox(width: 5)],
              Expanded(child: buildName()),
            ],
          ),
        ),
        buildTrophy(),
      ],
    );
  }

  Widget _buildWeightTrophy() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if ((widget as WidgetLogsDismissible).log.weight > 0) buildWeight(),
        buildTrophy(),
      ],
    );
  }

  Widget _buildHarvestCheckTrophy() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if ((widget as WidgetLogsDismissible).log.reserve != null) Expanded(child: _buildHarvestCheck()),
        _buildWeightTrophy(),
      ],
    );
  }

  List<Widget> _listLogCompact() {
    return [
      _buildNameTrophy(),
      if (settings.entryDate) _buildDate(),
    ];
  }

  List<Widget> _listLogSemiCompact() {
    return [
      _buildNameTrophy(),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              children: [
                if (settings.entryDate) _buildDate(),
                buildFur(),
              ],
            ),
          ),
          buildGender(),
        ],
      ),
    ];
  }

  List<Widget> _listLogNonCompact() {
    return [
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if ((widget as WidgetLogsDismissible).log.isInLodge) ...[buildLodge(), const SizedBox(width: 5)],
          Expanded(child: buildName()),
          buildGender(),
        ],
      ),
      if (settings.entryDate) _buildDate(),
      if ((widget as WidgetLogsDismissible).log.reserve != null) _buildReserve(),
      buildFur(),
      _buildHarvestCheckTrophy(),
    ];
  }

  @override
  Widget buildEntry() {
    return WidgetPadding.h30v20(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (settings.compactLogbook == 1) ..._listLogCompact(),
          if (settings.compactLogbook == 2) ..._listLogSemiCompact(),
          if (settings.compactLogbook == 3) ..._listLogNonCompact(),
        ],
      ),
    );
  }
}
