import 'package:cotwcompanion/lists/fur_info/fur_animals.dart';
import 'package:cotwcompanion/model/translatable/fur.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityDetailFur extends StatelessWidget {
  final Fur _fur;

  const ActivityDetailFur(
    Fur fur, {
    super.key,
  }) : _fur = fur;

  List<Widget> _listFurAnimals() {
    return [
      ListFurAnimals(_fur, rarity: 0),
      ListFurAnimals(_fur, rarity: 1),
      ListFurAnimals(_fur, rarity: 2),
      ListFurAnimals(_fur, rarity: 3),
      ListFurAnimals(_fur, rarity: 4),
    ];
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        _fur.name,
        context: context,
      ),
      children: [
        WidgetTitle(tr("FUR_RARITY")),
        ..._listFurAnimals(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
