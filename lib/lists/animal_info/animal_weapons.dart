// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/model/weapon.dart';
import 'package:cotwcompanion/widgets/text_dlc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListAnimalWeapons extends StatefulWidget {
  final int animalLevel;
  final WeaponType weaponType;

  const ListAnimalWeapons({
    Key? key,
    required this.animalLevel,
    required this.weaponType,
  }) : super(key: key);

  @override
  ListAnimalWeaponsState createState() => ListAnimalWeaponsState();
}

class ListAnimalWeaponsState extends State<ListAnimalWeapons> {
  late final bool _bestOnly;
  late final List<IdtoId> _items = [];
  late final List<IdtoId> _bestNonDlc = [];
  late final List<IdtoId> _bestFromDlc = [];

  @override
  void initState() {
    _bestOnly = Provider.of<Settings>(context, listen: false).bestWeaponsForAnimal;
    super.initState();
  }

  bool _contains(IdtoId item, List<IdtoId> list) {
    for (IdtoId iti in list) {
      if (widget.weaponType == WeaponType.shotgun || widget.weaponType == WeaponType.bow) {
        if (HelperJSON.getAmmo(iti.secondId).getName(context.locale) == HelperJSON.getAmmo(item.secondId).getName(context.locale)) return true;
      } else {
        if (iti.firstId == item.firstId) return true;
      }
    }
    return false;
  }

  void _getData() {
    _items.clear();
    for (IdtoId iti in HelperJSON.weaponsAmmo) {
      Weapon weapon = HelperJSON.getWeapon(iti.firstId);
      Ammo ammo = HelperJSON.getAmmo(iti.secondId);
      if (weapon.type == widget.weaponType) {
        if (ammo.min <= widget.animalLevel && widget.animalLevel <= ammo.max) {
          _items.add(iti);
        }
      }
    }
    _sortData();
    if (_bestOnly) _getBestData();
  }

  void _sortData() {
    widget.weaponType == WeaponType.shotgun || widget.weaponType == WeaponType.bow
        ? _items.sort((a, b) {
            String nA = HelperJSON.getAmmo(a.secondId).getName(context.locale);
            String nB = HelperJSON.getAmmo(b.secondId).getName(context.locale);
            return nA.compareTo(nB);
          })
        : _items.sort((a, b) {
            String nA = HelperJSON.getWeapon(a.firstId).getName(context.locale);
            String nB = HelperJSON.getWeapon(b.firstId).getName(context.locale);
            return nA.compareTo(nB);
          });
  }

  void _getBestData() {
    _bestNonDlc.clear();
    _bestFromDlc.clear();
    int minNoDlc = 0, penNoDlc = 0, minDlc = 0, penDlc = 0;
    for (IdtoId iti in _items) {
      Weapon weapon = HelperJSON.getWeapon(iti.firstId);
      Ammo ammo = HelperJSON.getAmmo(iti.secondId);
      if (weapon.isFromDlc) {
        if (ammo.min > minDlc) minDlc = ammo.min;
        if (ammo.penetration > penDlc) penDlc = ammo.penetration;
      } else {
        if (ammo.min > minNoDlc) minNoDlc = ammo.min;
        if (ammo.penetration > penNoDlc) penNoDlc = ammo.penetration;
      }
    }
    for (IdtoId iti in _items) {
      Weapon weapon = HelperJSON.getWeapon(iti.firstId);
      Ammo ammo = HelperJSON.getAmmo(iti.secondId);
      if (weapon.isFromDlc) {
        if (ammo.min >= minDlc && ammo.penetration >= penDlc) {
          _bestFromDlc.add(iti);
        }
      } else {
        if (ammo.min >= minNoDlc && ammo.penetration >= penNoDlc) {
          _bestNonDlc.add(iti);
        }
      }
    }
  }

  Widget _buildList(List<IdtoId> items) {
    List<IdtoId> reduced = [];
    if (_bestOnly) {
      reduced.addAll(items);
    } else {
      reduced.clear();
      for (IdtoId item in items) {
        if (!_contains(item, reduced)) reduced.add(item);
      }
    }
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: reduced.length,
        itemBuilder: (context, index) {
          dynamic item = reduced[index];
          Weapon weapon = HelperJSON.getWeapon(item.firstId);
          Ammo ammo = HelperJSON.getAmmo(item.secondId);
          bool dlc = weapon.isFromDlc;
          String text = weapon.getName(context.locale);
          String subText = ammo.getName(context.locale);
          if (widget.weaponType == WeaponType.shotgun || widget.weaponType == WeaponType.bow) {
            dlc = ammo.isFromDlc;
            if (!_bestOnly) {
              text = ammo.getName(context.locale);
              subText = weapon.getName(context.locale);
            }
          }
          return WidgetTextDlc(
            text: text,
            subText: _bestOnly ? subText : "",
            dlc: dlc,
          );
        });
  }

  Widget _buildAll() => _buildList(_items);

  Widget _buildBest() => Column(children: [_buildList(_bestNonDlc), _buildList(_bestFromDlc)]);

  Widget _buildWidgets() {
    _getData();
    return _bestOnly ? _buildBest() : _buildAll();
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
