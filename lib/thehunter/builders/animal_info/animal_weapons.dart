// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/thehunter/widgets/entries/entry_with_dlc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_settings.dart';
import 'package:cotwcompanion/thehunter/model/weapon.dart';

class BuilderAnimalWeapons extends StatefulWidget {
  final int animalLevel;
  final int weaponType;

  const BuilderAnimalWeapons({Key? key, required this.animalLevel, required this.weaponType}) : super(key: key);

  @override
  BuilderAnimalWeaponsState createState() => BuilderAnimalWeaponsState();
}

class BuilderAnimalWeaponsState extends State<BuilderAnimalWeapons> {
  late final bool _bestWeaponsForAnimal;
  late final List<Weapon> _weapons = [];
  late final List<Weapon> _actualWeapons = [];
  late final List<Weapon> _bestNoDLCWeapons = [];
  late final List<Weapon> _bestDLCWeapons = [];

  @override
  void initState() {
    _weapons.addAll(JSONHelper.weaponsInfo);
    _bestWeaponsForAnimal = Provider.of<Settings>(context, listen: false).getBestWeaponsForAnimal;
    super.initState();
  }

  _getWeapons() {
    _actualWeapons.clear();
    _weapons.sort((b, a) => a.getPenetration.compareTo(b.getPenetration));
    for (Weapon w in _weapons) {
      if (w.getMin <= widget.animalLevel && widget.animalLevel <= w.getMax && w.getType == widget.weaponType) {
        if (_canBeAdded(w)) _actualWeapons.add(w);
      }
    }
    if (_bestWeaponsForAnimal) _getBestWeapons();
  }

  _sortWeapons() {
    if (widget.weaponType == 1 || widget.weaponType == 3) {
      _actualWeapons.sort((a, b) => a.getNameAmmo(context.locale).compareTo(b.getNameAmmo(context.locale)));
    } else {
      _actualWeapons.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
    }
  }

  _getBestWeapons() {
    _bestNoDLCWeapons.clear();
    _bestDLCWeapons.clear();
    int minNoDlc = 0, penNoDlc = 0, minDlc = 0, penDlc = 0;
    for (Weapon w in _actualWeapons) {
      if (w.getDlc) {
        if (w.getMin > minDlc) minDlc = w.getMin;
        if (w.getPenetration > penDlc) penDlc = w.getPenetration;
      } else {
        if (w.getMin > minNoDlc) minNoDlc = w.getMin;
        if (w.getPenetration > penNoDlc) penNoDlc = w.getPenetration;
      }
    }
    for (Weapon w in _actualWeapons) {
      if (w.getDlc) {
        if (w.getMin >= minDlc && w.getPenetration >= penDlc) {
          _bestDLCWeapons.add(w);
        }
      } else {
        if (w.getMin >= minNoDlc && w.getPenetration >= penNoDlc) {
          _bestNoDLCWeapons.add(w);
        }
      }
    }
  }

  _canBeAdded(Weapon add) {
    if (_actualWeapons.isEmpty) return true;
    for (Weapon w in _actualWeapons) {
      if (w.getType == 1 || w.getType == 3) {
        if (add.getAmmoID == w.getAmmoID) {
          if (add.getPenetration > w.getPenetration) {
            _actualWeapons.remove(w);
            return true;
          } else {
            return false;
          }
        }
        if (add.getNameAmmo(context.locale) == w.getNameAmmo(context.locale)) {
          _actualWeapons.remove(w);
          return true;
        }
      }
      if (add.getID == w.getID) {
        if (add.getPenetration > w.getPenetration) {
          _actualWeapons.remove(w);
          return true;
        } else {
          return false;
        }
      }
    }
    return true;
  }

  Widget _buildAllWeapons() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _actualWeapons.length,
        itemBuilder: (context, index) {
          Weapon weapon = _actualWeapons[index];
          String name = widget.weaponType == 1 || widget.weaponType == 3 ? weapon.getNameAmmo(context.locale) : weapon.getName(context.locale);
          return EntryWithDlc(text: name, dlc: weapon.getDlc);
        });
  }

  Widget _buildBestWeapons() {
    return Column(children: [
      ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _bestNoDLCWeapons.length,
          itemBuilder: (context, index) {
            Weapon weapon = _bestNoDLCWeapons[index];
            String name = widget.weaponType == 1 || widget.weaponType == 3 ? weapon.getNameAmmo(context.locale) : weapon.getName(context.locale);
            return EntryWithDlc(text: name, dlc: weapon.getDlc);
          }),
      ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _bestDLCWeapons.length,
          itemBuilder: (context, index) {
            Weapon weapon = _bestDLCWeapons[index];
            String name = widget.weaponType == 1 || widget.weaponType == 3 ? weapon.getNameAmmo(context.locale) : weapon.getName(context.locale);
            return EntryWithDlc(text: name, dlc: weapon.getDlc);
          })
    ]);
  }

  Widget _buildWidgets() {
    return _bestWeaponsForAnimal ? _buildBestWeapons() : _buildAllWeapons();
  }

  @override
  Widget build(BuildContext context) {
    _getWeapons();
    _sortWeapons();
    return _buildWidgets();
  }
}
