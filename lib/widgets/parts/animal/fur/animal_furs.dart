import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/lists/animal_info/animal_furs.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/tag/tag_tap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WidgetAnimalFurs extends StatelessWidget {
  final Animal _animal;
  final int _toggledRarity;
  final Function _onToggled;

  const WidgetAnimalFurs(
    Animal animal, {
    super.key,
    required int toggledRarity,
    required Function onToggled,
  })  : _animal = animal,
        _toggledRarity = toggledRarity,
        _onToggled = onToggled;

  Widget _buildFursRarity() {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      alignment: WrapAlignment.center,
      children: [
        WidgetTagTap.small(
          value: tr("RARITY_COMMON"),
          color: Interface.light,
          background: Interface.rarityCommon,
          onTap: () => _onToggled(0),
        ),
        if (_animal.hasUncommonFurs)
          WidgetTagTap.small(
            value: tr("RARITY_UNCOMMON"),
            color: Interface.alwaysDark,
            background: Interface.rarityUncommon,
            onTap: () => _onToggled(1),
          ),
        if (_animal.hasRareFurs)
          WidgetTagTap.small(
            value: tr("RARITY_RARE"),
            color: Interface.alwaysDark,
            background: Interface.rarityRare,
            onTap: () => _onToggled(2),
          ),
        if (_animal.hasMissionFurs)
          WidgetTagTap.small(
            value: tr("RARITY_MISSION"),
            color: Interface.alwaysDark,
            background: Interface.rarityMission,
            onTap: () => _onToggled(3),
          ),
      ],
    );
  }

  Widget _buildWidgets() {
    return WidgetPadding.a30(
      child: Column(
        children: [
          _buildFursRarity(),
          const SizedBox(height: 30),
          ListAnimalFurs(
            _animal,
            chosenRarity: _toggledRarity,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
