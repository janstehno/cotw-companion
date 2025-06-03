import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/lists/weapon_info/weapon_ammo.dart';
import 'package:cotwcompanion/lists/weapon_info/weapon_animals.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/parts/stats/parameter.dart';
import 'package:cotwcompanion/widgets/parts/stats/price.dart';
import 'package:cotwcompanion/widgets/parts/weapon/statistics.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityDetailWeapon extends StatelessWidget {
  final Weapon _weapon;

  const ActivityDetailWeapon(
    Weapon weapon, {
    super.key,
  }) : _weapon = weapon;

  Widget _buildType() {
    return WidgetParameter(
      text: tr("TYPE"),
      value: tr(_weapon.type.key),
    );
  }

  Widget _buildMagazine() {
    return WidgetParameter(
      text: tr("WEAPON_MAGAZINE"),
      value: _weapon.id == 21 ? "1/2" : _weapon.mag,
    );
  }

  Widget _buildPrice() {
    return WidgetParameterPrice(price: _weapon.price);
  }

  Widget _buildRequirements() {
    return WidgetParameter(
      text: tr("REQUIREMENT_SCORE"),
      value: _weapon.score,
    );
  }

  Widget _buildDlc() {
    return WidgetParameter(
      text: "DLC",
      value: HelperJSON.getWeaponDlc(_weapon.id)!.name,
    );
  }

  Widget _buildStatistics() {
    return WidgetPadding.a30(
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        children: [
          _buildType(),
          _buildMagazine(),
          _buildPrice(),
          if (_weapon.hasRequirements) _buildRequirements(),
          if (_weapon.isFromDlc) _buildDlc(),
        ],
      ),
    );
  }

  List<Widget> _listAmmo() {
    return [
      WidgetTitle(tr("WEAPON_AMMO")),
      ListWeaponAmmo(_weapon),
    ];
  }

  List<Widget> _listAnimals() {
    return [
      WidgetTitle(tr("RECOMMENDED_ANIMALS")),
      ..._weapon.levels.map((e) => ListWeaponAnimals(level: e)),
    ];
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        _weapon.name,
        context: context,
      ),
      children: [
        _buildStatistics(),
        WidgetPadding.h30v20(child: ListWeaponStatistics(_weapon)),
        ..._listAmmo(),
        ..._listAnimals(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
