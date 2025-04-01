import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/lists/fur_info/fur_animals.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/translatable/fur.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityDetailFur extends StatelessWidget {
  final Fur _fur;

  const ActivityDetailFur(
    Fur fur, {
    super.key,
  }) : _fur = fur;

  List<Widget> _listFurAnimals(BuildContext context) {
    bool showPerCent = Provider.of<Settings>(context, listen: false).furRarityPerCent;
    return [
      ListFurAnimals(_fur, rarity: FurRarity.common, showPerCent: showPerCent),
      ListFurAnimals(_fur, rarity: FurRarity.uncommon, showPerCent: showPerCent),
      ListFurAnimals(_fur, rarity: FurRarity.rare, showPerCent: showPerCent),
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
        ..._listFurAnimals(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
