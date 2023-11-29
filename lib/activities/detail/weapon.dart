// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/lists/weapon_info/weapon_ammo.dart';
import 'package:cotwcompanion/lists/weapon_info/weapon_animals.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/model/weapon.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/entries/parameter.dart';
import 'package:cotwcompanion/widgets/entries/weapon_statistics.dart';
import 'package:cotwcompanion/widgets/price.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityDetailWeapon extends StatefulWidget {
  final Weapon weapon;

  const ActivityDetailWeapon({
    Key? key,
    required this.weapon,
  }) : super(key: key);

  @override
  ActivityDetailWeaponState createState() => ActivityDetailWeaponState();
}

class ActivityDetailWeaponState extends State<ActivityDetailWeapon> {
  Widget _buildStatistics() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildType(),
              _buildMagazine(),
              EntryParameterPrice(price: widget.weapon.price),
              _buildRequirements(),
              _buildDlc(),
            ],
          ),
        ),
        EntryWeaponStatistics(
          weapon: widget.weapon,
        ),
      ],
    );
  }

  Widget _buildType() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: EntryParameter(
        text: tr("type"),
        value: widget.weapon.getTypeAsString(),
      ),
    );
  }

  Widget _buildMagazine() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: EntryParameter(
        text: tr("weapon_magazine"),
        value: widget.weapon.id == 21 ? "1/2" : widget.weapon.mag,
      ),
    );
  }

  Widget _buildRequirements() {
    return widget.weapon.hasRequirements
        ? Container(
            margin: const EdgeInsets.only(top: 10),
            child: EntryParameter(
              text: tr("requirement_score"),
              value: widget.weapon.score,
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildDlc() {
    return widget.weapon.isFromDlc
        ? Container(
            margin: const EdgeInsets.only(top: 10),
            child: EntryParameter(
              text: "DLC",
              value: Utils.getWeaponDLC(widget.weapon.id),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildAmmo() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("weapon_ammo"),
      ),
      ListWeaponAmmo(
        weaponId: widget.weapon.id,
      ),
    ]);
  }

  Widget _buildAnimals() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("recommended_animals"),
      ),
      ListWeaponAnimals(
        min: widget.weapon.min,
        max: widget.weapon.max,
      ),
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: widget.weapon.getName(context.locale),
          maxLines: widget.weapon.getName(context.locale).split(" ").length > 2 ? 2 : 1,
          context: context,
        ),
        body: Column(children: [
          _buildStatistics(),
          _buildAmmo(),
          _buildAnimals(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
