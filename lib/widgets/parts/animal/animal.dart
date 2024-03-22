import 'package:cotwcompanion/activities/detail/animal.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/graphics.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/parts/items/item.dart';
import 'package:cotwcompanion/widgets/tag/tag.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WidgetAnimal extends StatelessWidget {
  final int _index;
  final Animal _animal;
  final Function _onTap;

  const WidgetAnimal(
    Animal animal, {
    super.key,
    required int i,
    required Function onTap,
  })  : _animal = animal,
        _index = i,
        _onTap = onTap;

  void onTap(BuildContext context) {
    _onTap();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (e) => ActivityDetailAnimal(_animal)),
    );
  }

  List<WidgetTag> _listTags() {
    return [
      if (_animal.isFromDlc)
        WidgetTag.big(
          icon: Assets.graphics.icons.dlc,
          color: Interface.alwaysDark,
          background: Interface.primary,
        ),
      if (_animal.hasGO)
        WidgetTag.big(
          icon: Assets.graphics.icons.trophyGreatOne,
          color: Interface.light,
          background: Interface.trophyGreatOne,
        ),
      WidgetTag.big(
        icon: Assets.graphics.icons.level,
        value: _animal.level.toString(),
        color: Interface.dark,
        background: Interface.tag,
      ),
      WidgetTag.big(
        icon: Assets.graphics.icons.stats,
        value: _animal.difficulty.toString(),
        color: Interface.dark,
        background: Interface.tag,
      ),
      WidgetTag.big(
        icon: Assets.graphics.icons.trophyDiamond,
        value: _animal.trophyAsString(_animal.diamond),
        color: Interface.alwaysDark,
        background: Interface.trophyDiamond,
      ),
      if (_animal.grounded)
        WidgetTag.big(
          icon: Assets.graphics.icons.grounded,
          color: Interface.dark,
          background: Interface.tag,
        ),
      if (_animal.femaleDiamond)
        WidgetTag.big(
          icon: Assets.graphics.icons.genderFemale,
          color: Interface.dark,
          background: Interface.tag,
        )
    ];
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetItem(
      _index,
      text: _animal.getNameByLocale(context.locale),
      icon: Graphics.getAnimalIcon(_animal),
      tags: _listTags(),
      onTap: () => onTap(context),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
