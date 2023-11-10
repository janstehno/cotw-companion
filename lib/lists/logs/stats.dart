// Copyright (c) 2022 - 2023 Jan Stehnoer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/tag_special.dart';
import 'package:cotwcompanion/widgets/title_info_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListLogsStats extends StatefulWidget {
  final List<Log> logs;
  final bool trophyLodge;

  const ListLogsStats({
    required this.logs,
    required this.trophyLodge,
    Key? key,
  }) : super(key: key);

  @override
  ListLogsStatsState createState() => ListLogsStatsState();
}

class ListLogsStatsState extends State<ListLogsStats> {
  final Map<int, int> _trophy = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
  final Map<int, int> _fur = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
  final double _wrapSpace = 5;

  int _trophyLodge = 0;

  @override
  void initState() {
    _getStats();
    super.initState();
  }

  void _getStats() {
    for (Log log in widget.logs) {
      if (log.isInLodge) _trophyLodge += 1;
      _setTrophy(log.trophyRatingWithGO);
      _setFur(log.fur.rarity);
    }
  }

  void _setTrophy(int trophyRating) {
    _trophy.update(trophyRating, (v) => v + 1);
  }

  void _setFur(int furRarity) {
    _fur.update(furRarity, (v) => v + 1);
  }

  List<WidgetTag> _buildGeneralTags() {
    List<WidgetTag> tags = [];
    if (!widget.trophyLodge) {
      tags.add(WidgetTag.special(
        identifier: "assets/graphics/icons/menu_open.svg",
        value: widget.logs.length.toString(),
        color: Interface.light,
        background: Interface.dark,
        withIcon: true,
      ));
    }
    if (_trophyLodge > 0) {
      tags.add(WidgetTag.special(
        identifier: "assets/graphics/icons/trophy_lodge.svg",
        value: _trophyLodge.toString(),
        color: Interface.accent,
        background: Interface.primary,
        withIcon: true,
      ));
    }
    return tags;
  }

  List<WidgetTag> _buildTrophyTags() {
    List<WidgetTag> tags = [];
    if (_trophy[0]! > 0) {
      tags.add(WidgetTag.special(
        identifier: "assets/graphics/icons/trophy_none.svg",
        value: _trophy[0].toString(),
        color: Interface.light,
        background: Interface.trophyNone,
        withIcon: true,
      ));
    }
    if (_trophy[1]! > 0) {
      tags.add(WidgetTag.special(
        identifier: "assets/graphics/icons/trophy_bronze.svg",
        value: _trophy[1].toString(),
        color: Interface.alwaysDark,
        background: Interface.trophyBronze,
        withIcon: true,
      ));
    }
    if (_trophy[2]! > 0) {
      tags.add(WidgetTag.special(
        identifier: "assets/graphics/icons/trophy_silver.svg",
        value: _trophy[2].toString(),
        color: Interface.alwaysDark,
        background: Interface.trophySilver,
        withIcon: true,
      ));
    }
    if (_trophy[3]! > 0) {
      tags.add(WidgetTag.special(
        identifier: "assets/graphics/icons/trophy_gold.svg",
        value: _trophy[3].toString(),
        color: Interface.alwaysDark,
        background: Interface.trophyGold,
        withIcon: true,
      ));
    }
    if (_trophy[4]! > 0) {
      tags.add(WidgetTag.special(
        identifier: "assets/graphics/icons/trophy_diamond.svg",
        value: _trophy[4].toString(),
        color: Interface.alwaysDark,
        background: Interface.trophyDiamond,
        withIcon: true,
      ));
    }
    if (_trophy[5]! > 0) {
      tags.add(WidgetTag.special(
        identifier: "assets/graphics/icons/trophy_great_one.svg",
        value: _trophy[5].toString(),
        color: Interface.light,
        background: Interface.trophyGreatOne,
        withIcon: true,
      ));
    }
    return tags;
  }

  List<WidgetTag> _buildFurTags() {
    List<WidgetTag> tags = [];
    if (_fur[0]! > 0) {
      tags.add(WidgetTag.special(
        identifier: tr('rarity_common'),
        value: _fur[0].toString(),
        color: Interface.light,
        background: Interface.rarityCommon,
      ));
    }
    if (_fur[1]! > 0) {
      tags.add(WidgetTag.special(
        identifier: tr('rarity_uncommon'),
        value: _fur[1].toString(),
        color: Interface.alwaysDark,
        background: Interface.rarityUncommon,
      ));
    }
    if (_fur[2]! > 0) {
      tags.add(WidgetTag.special(
        identifier: tr('rarity_rare'),
        value: _fur[2].toString(),
        color: Interface.alwaysDark,
        background: Interface.rarityRare,
      ));
    }
    if (_fur[3]! > 0) {
      tags.add(WidgetTag.special(
        identifier: tr('rarity_very_rare'),
        value: _fur[3].toString(),
        color: Interface.alwaysDark,
        background: Interface.rarityVeryRare,
      ));
    }
    if (_fur[4]! > 0) {
      tags.add(WidgetTag.special(
        identifier: tr('rarity_mission'),
        value: _fur[4].toString(),
        color: Interface.alwaysDark,
        background: Interface.rarityMission,
      ));
    }
    if (_fur[5]! > 0) {
      tags.add(WidgetTag.special(
        identifier: HelperJSON.getFur(Interface.greatOneId).getName(context.locale),
        value: _fur[5].toString(),
        color: Interface.alwaysDark,
        background: Interface.rarityGreatOne,
      ));
    }
    return tags;
  }

  Widget _buildStats(String icon, String text, List<WidgetTag> tags) {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/$icon.svg",
        text: tr(text),
      ),
      Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: _wrapSpace,
          runSpacing: _wrapSpace,
          children: tags,
        ),
      )
    ]);
  }

  Widget _buildList() {
    return widget.logs.isEmpty
        ? Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(30),
            child: AutoSizeText(
              tr('none'),
              style: Interface.s16w300n(Interface.dark),
            ),
          )
        : Column(children: [
            _buildStats("stats", "stats", _buildGeneralTags()),
            _buildStats("trophy_diamond", "trophy_rating", _buildTrophyTags()),
            _buildStats("fur", "fur_rarity", _buildFurTags()),
          ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        text: tr('stats'),
        context: context,
      ),
      appBarFixed: true,
      body: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
