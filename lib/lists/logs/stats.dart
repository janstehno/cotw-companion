import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/exportable/log.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/tag/tag.dart';
import 'package:cotwcompanion/widgets/tag/tag_special.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:cotwcompanion/widgets/title/title_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListLogsStats extends StatefulWidget {
  final List<dynamic> _logs;
  final bool _trophyLodge;

  const ListLogsStats(
    List<dynamic> logs, {
    super.key,
    required bool trophyLodge,
  })  : _logs = logs,
        _trophyLodge = trophyLodge;

  List<dynamic> get logs => _logs;

  bool get trophyLodge => _trophyLodge;

  @override
  ListLogsStatsState createState() => ListLogsStatsState();
}

class ListLogsStatsState extends State<ListLogsStats> {
  final Map<int, int> _trophyCount = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
  final Map<int, int> _furCount = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

  int _trophyLodgeCount = 0;

  @override
  void initState() {
    _initializeStats();
    super.initState();
  }

  void _initializeStats() {
    for (Log log in widget.logs) {
      if (log.isInLodge) _trophyLodgeCount += 1;
      _updateTrophy(log.trophyRatingWithGO);
      _updateFur(log.animalFur!.rarity.index);
    }
  }

  void _updateTrophy(int trophyRating) => _trophyCount.update(trophyRating, (v) => v + 1);

  void _updateFur(int furRarity) => _furCount.update(furRarity, (v) => v + 1);

  List<WidgetTag> _listGeneralTags() {
    return [
      if (!widget.trophyLodge)
        WidgetTagSpecial(
          identifier: Assets.graphics.icons.menuOpen,
          value: widget.logs.length.toString(),
          color: Interface.light.withValues(alpha: 0.8),
          background: Interface.dark,
          withIcon: true,
        ),
      if (_trophyLodgeCount > 0)
        WidgetTagSpecial(
          identifier: Assets.graphics.icons.trophyLodge,
          value: _trophyLodgeCount.toString(),
          color: Interface.alwaysDark.withValues(alpha: 0.8),
          background: Interface.primary,
          withIcon: true,
        )
    ];
  }

  List<WidgetTag> _listTrophyTags() {
    return [
      if (_trophyCount[0]! > 0)
        WidgetTagSpecial(
          identifier: Assets.graphics.icons.trophyNone,
          value: _trophyCount[0].toString(),
          color: Interface.light.withValues(alpha: 0.8),
          background: Interface.trophyNone,
          withIcon: true,
        ),
      if (_trophyCount[1]! > 0)
        WidgetTagSpecial(
          identifier: Assets.graphics.icons.trophyBronze,
          value: _trophyCount[1].toString(),
          color: Interface.alwaysDark.withValues(alpha: 0.8),
          background: Interface.trophyBronze,
          withIcon: true,
        ),
      if (_trophyCount[2]! > 0)
        WidgetTagSpecial(
          identifier: Assets.graphics.icons.trophySilver,
          value: _trophyCount[2].toString(),
          color: Interface.alwaysDark.withValues(alpha: 0.8),
          background: Interface.trophySilver,
          withIcon: true,
        ),
      if (_trophyCount[3]! > 0)
        WidgetTagSpecial(
          identifier: Assets.graphics.icons.trophyGold,
          value: _trophyCount[3].toString(),
          color: Interface.alwaysDark.withValues(alpha: 0.8),
          background: Interface.trophyGold,
          withIcon: true,
        ),
      if (_trophyCount[4]! > 0)
        WidgetTagSpecial(
          identifier: Assets.graphics.icons.trophyDiamond,
          value: _trophyCount[4].toString(),
          color: Interface.alwaysDark.withValues(alpha: 0.8),
          background: Interface.trophyDiamond,
          withIcon: true,
        ),
      if (_trophyCount[5]! > 0)
        WidgetTagSpecial(
          identifier: Assets.graphics.icons.trophyGreatOne,
          value: _trophyCount[5].toString(),
          color: Interface.light.withValues(alpha: 0.8),
          background: Interface.trophyGreatOne,
          withIcon: true,
        )
    ];
  }

  List<WidgetTag> _buildFurTags() {
    return [
      if (_furCount[0]! > 0)
        WidgetTagSpecial(
          identifier: tr("RARITY_COMMON"),
          value: _furCount[0].toString(),
          color: Interface.light.withValues(alpha: 0.8),
          background: Interface.rarityCommon,
        ),
      if (_furCount[1]! > 0)
        WidgetTagSpecial(
          identifier: tr("RARITY_UNCOMMON"),
          value: _furCount[1].toString(),
          color: Interface.alwaysDark.withValues(alpha: 0.8),
          background: Interface.rarityUncommon,
        ),
      if (_furCount[2]! > 0)
        WidgetTagSpecial(
          identifier: tr("RARITY_RARE"),
          value: _furCount[2].toString(),
          color: Interface.alwaysDark.withValues(alpha: 0.8),
          background: Interface.rarityRare,
        ),
      if (_furCount[3]! > 0)
        WidgetTagSpecial(
          identifier: tr("RARITY_MISSION"),
          value: _furCount[3].toString(),
          color: Interface.alwaysDark.withValues(alpha: 0.8),
          background: Interface.rarityMission,
        ),
      if (_furCount[4]! > 0)
        WidgetTagSpecial(
          identifier: HelperJSON.getFur(Values.greatOneId)!.name,
          value: _furCount[4].toString(),
          color: Interface.alwaysDark.withValues(alpha: 0.8),
          background: Interface.rarityGreatOne,
        ),
    ];
  }

  Widget _buildStats(String icon, String text, List<WidgetTag> tags) {
    return Column(
      children: [
        WidgetTitleIcon(
          text,
          icon: icon,
        ),
        WidgetPadding.h30v20(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.start,
            children: tags,
          ),
        ),
      ],
    );
  }

  List<Widget> _listStats() {
    if (widget.logs.isNotEmpty) {
      return [
        _buildStats(Assets.graphics.icons.stats, tr("STATS"), _listGeneralTags()),
        _buildStats(Assets.graphics.icons.trophyDiamond, tr("TROPHY_RATING"), _listTrophyTags()),
        _buildStats(Assets.graphics.icons.fur, tr("FUR_RARITY"), _buildFurTags()),
      ];
    }
    return [
      WidgetPadding.a30(
        child: WidgetText(
          tr("NONE"),
          color: Interface.dark,
          style: Style.normal.s16.w300,
        ),
      )
    ];
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        tr("STATS"),
        context: context,
      ),
      children: _listStats(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
