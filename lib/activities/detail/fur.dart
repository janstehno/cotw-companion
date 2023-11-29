// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/lists/fur_info/fur_animals.dart';
import 'package:cotwcompanion/model/fur.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityDetailFur extends StatefulWidget {
  final Fur fur;

  const ActivityDetailFur({
    Key? key,
    required this.fur,
  }) : super(key: key);

  @override
  ActivityDetailFurState createState() => ActivityDetailFurState();
}

class ActivityDetailFurState extends State<ActivityDetailFur> {
  Widget _buildStatistics() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("fur_rarity"),
      ),
      ListFurAnimals(
        furId: widget.fur.id,
        rarity: 0,
      ),
      ListFurAnimals(
        furId: widget.fur.id,
        rarity: 1,
      ),
      ListFurAnimals(
        furId: widget.fur.id,
        rarity: 2,
      ),
      ListFurAnimals(
        furId: widget.fur.id,
        rarity: 3,
      ),
      ListFurAnimals(
        furId: widget.fur.id,
        rarity: 4,
      ),
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: widget.fur.getName(context.locale),
          maxLines: widget.fur.getName(context.locale).split(" ").length > 2 ? 2 : 1,
          context: context,
        ),
        body: Column(children: [
          _buildStatistics(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
