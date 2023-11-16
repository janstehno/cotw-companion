// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/lists/fur_info/fur_animals.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/model/fur.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityFurInfo extends StatefulWidget {
  final int furId;

  const ActivityFurInfo({
    Key? key,
    required this.furId,
  }) : super(key: key);

  @override
  ActivityFurInfoState createState() => ActivityFurInfoState();
}

class ActivityFurInfoState extends State<ActivityFurInfo> {
  late final Fur _fur;

  @override
  void initState() {
    _fur = HelperJSON.getFur(widget.furId);
    super.initState();
  }

  Widget _buildStatistics() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("fur_rarity"),
      ),
      ListFurAnimals(
        furId: widget.furId,
        rarity: 0,
      ),
      ListFurAnimals(
        furId: widget.furId,
        rarity: 1,
      ),
      ListFurAnimals(
        furId: widget.furId,
        rarity: 2,
      ),
      ListFurAnimals(
        furId: widget.furId,
        rarity: 3,
      ),
      ListFurAnimals(
        furId: widget.furId,
        rarity: 4,
      ),
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: _fur.getName(context.locale),
          maxLines: _fur.getName(context.locale).split(" ").length > 2 ? 2 : 1,
          context: context,
        ),
        body: Column(children: [
          _buildStatistics(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
