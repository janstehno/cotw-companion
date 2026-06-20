import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/pair.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/text/text_subtext_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListAnimalWeapons extends StatefulWidget {
  final int _animalLevel;
  final WeaponType _weaponType;

  const ListAnimalWeapons(
    int animalLevel, {
    super.key,
    required WeaponType weaponType,
  })  : _animalLevel = animalLevel,
        _weaponType = weaponType;

  int get animalLevel => _animalLevel;

  WeaponType get weaponType => _weaponType;

  @override
  ListAnimalWeaponsState createState() => ListAnimalWeaponsState();
}

class ListAnimalWeaponsState extends State<ListAnimalWeapons> {
  bool get _bestOnly => Provider.of<Settings>(context, listen: false).bestWeaponsForAnimal;

  final List<Pair<Weapon, Ammo>> _items = [];
  final List<Pair<Weapon, Ammo>> _bestNonDlc = [];
  final List<Pair<Weapon, Ammo>> _bestFromDlc = [];

  @override
  void initState() {
    _initializeWeapons();
    super.initState();
  }

  void _initializeWeapons() {
    _items.clear();
    for (Weapon w in HelperJSON.weapons) {
      for (Ammo a in HelperJSON.getWeaponsAmmo(w.id)) {
        if (w.type == widget.weaponType) {
          if (a.min <= widget.animalLevel && widget.animalLevel <= a.max) {
            _items.add(Pair(w, a));
          }
        }
      }
    }
    _sortWeapons();
    if (_bestOnly) _getBestWeapons();
  }

  void _sortWeapons() {
    if (widget.weaponType == WeaponType.shotgun || widget.weaponType == WeaponType.bow) {
      _items.sort((a, b) {
        String nA = HelperJSON.getAmmo(a.second.id)!.name;
        String nB = HelperJSON.getAmmo(b.second.id)!.name;
        return nA.compareTo(nB);
      });
    } else {
      _items.sort((a, b) {
        String nA = HelperJSON.getWeapon(a.first.id)!.name;
        String nB = HelperJSON.getWeapon(b.first.id)!.name;
        return nA.compareTo(nB);
      });
    }
  }

  void _getBestWeapons() {
    int minNoDlc = 0, penNoDlc = 0, minDlc = 0, penDlc = 0;
    for (var wa in _items) {
      Weapon weapon = HelperJSON.getWeapon(wa.first.id)!;
      Ammo ammo = HelperJSON.getAmmo(wa.second.id)!;
      if (weapon.isFromDlc) {
        if (ammo.min > minDlc) minDlc = ammo.min;
        if (ammo.penetration > penDlc) penDlc = ammo.penetration;
      } else {
        if (ammo.min > minNoDlc) minNoDlc = ammo.min;
        if (ammo.penetration > penNoDlc) penNoDlc = ammo.penetration;
      }
    }
    _setBestWeapons(minDlc, penDlc, minNoDlc, penNoDlc);
  }

  void _setBestWeapons(int minDlc, int penDlc, int minNoDlc, int penNoDlc) {
    _bestNonDlc.clear();
    _bestFromDlc.clear();
    for (var wa in _items) {
      Weapon weapon = HelperJSON.getWeapon(wa.first.id)!;
      Ammo ammo = HelperJSON.getAmmo(wa.second.id)!;
      if (weapon.isFromDlc) {
        if (ammo.min >= minDlc && ammo.penetration >= penDlc) {
          _bestFromDlc.add(wa);
        }
      } else {
        if (ammo.min >= minNoDlc && ammo.penetration >= penNoDlc) {
          _bestNonDlc.add(wa);
        }
      }
    }
  }

  bool _isBetter(Pair<Weapon, Ammo> item, List<Pair<Weapon, Ammo>> items) {
    for (var wa in items) {
      if (widget.weaponType == WeaponType.shotgun || widget.weaponType == WeaponType.bow) {
        if (item.second.id == wa.second.id) {
          if (HelperJSON.getWeapon(item.first.id)!.accuracy < HelperJSON.getWeapon(wa.first.id)!.accuracy) {
            return false;
          }
        }
      } else if (item.first.id == wa.first.id) {
        if (HelperJSON.getAmmo(item.second.id)!.penetration < HelperJSON.getAmmo(wa.second.id)!.penetration) {
          return false;
        }
      }
    }
    return true;
  }

  List<Pair<Weapon, Ammo>> _removeWorse(List<Pair<Weapon, Ammo>> items) {
    if (_bestOnly) {
      return items;
    } else {
      List<Pair<Weapon, Ammo>> reduced = [];
      for (var item in items) {
        if (_isBetter(item, items)) reduced.add(item);
      }
      return reduced;
    }
  }

  List<Widget> _listWeapons(List<Pair<Weapon, Ammo>> items) {
    return _removeWorse(items).map((e) {
      Weapon weapon = HelperJSON.getWeapon(e.first.id)!;
      Ammo ammo = HelperJSON.getAmmo(e.second.id)!;
      bool dlc = weapon.isFromDlc;
      String text = weapon.name;
      String subText = ammo.name;
      if (widget.weaponType == WeaponType.shotgun || widget.weaponType == WeaponType.bow) {
        dlc = ammo.isFromDlc;
        if (!_bestOnly) {
          text = ammo.name;
          subText = weapon.name;
        }
      }
      return WidgetTextSubtextIndicator(
        text,
        subtext: subText,
        indicatorColor: Interface.primary,
        isShown: dlc,
      );
    }).toList();
  }

  Widget _buildWeapons(List<Pair<Weapon, Ammo>> items) {
    return Column(children: _listWeapons(items));
  }

  Widget _buildAll() => _buildWeapons(_items);

  Widget _buildBest() => Column(children: [_buildWeapons(_bestNonDlc), _buildWeapons(_bestFromDlc)]);

  Widget _buildWidgets() {
    return WidgetPadding.a30(child: _bestOnly ? _buildBest() : _buildAll());
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
