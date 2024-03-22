import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/connect/weapon_ammo.dart';
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

  final List<WeaponAmmo> _items = [];
  final List<WeaponAmmo> _bestNonDlc = [];
  final List<WeaponAmmo> _bestFromDlc = [];

  @override
  void initState() {
    _initializeWeapons();
    super.initState();
  }

  void _initializeWeapons() {
    _items.clear();
    for (WeaponAmmo wa in HelperJSON.weaponsAmmo) {
      Weapon weapon = HelperJSON.getWeapon(wa.weaponId)!;
      Ammo ammo = HelperJSON.getAmmo(wa.ammoId)!;
      if (weapon.type == widget.weaponType) {
        if (ammo.min <= widget.animalLevel && widget.animalLevel <= ammo.max) {
          _items.add(wa);
        }
      }
    }
    _sortWeapons();
    if (_bestOnly) _getBestWeapons();
  }

  void _sortWeapons() {
    if (widget.weaponType == WeaponType.shotgun || widget.weaponType == WeaponType.bow) {
      _items.sort((a, b) {
        String nA = HelperJSON.getAmmo(a.ammoId)!.name;
        String nB = HelperJSON.getAmmo(b.ammoId)!.name;
        return nA.compareTo(nB);
      });
    } else {
      _items.sort((a, b) {
        String nA = HelperJSON.getWeapon(a.weaponId)!.name;
        String nB = HelperJSON.getWeapon(b.weaponId)!.name;
        return nA.compareTo(nB);
      });
    }
  }

  void _getBestWeapons() {
    int minNoDlc = 0, penNoDlc = 0, minDlc = 0, penDlc = 0;
    for (WeaponAmmo wa in _items) {
      Weapon weapon = HelperJSON.getWeapon(wa.weaponId)!;
      Ammo ammo = HelperJSON.getAmmo(wa.ammoId)!;
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
    for (WeaponAmmo wa in _items) {
      Weapon weapon = HelperJSON.getWeapon(wa.weaponId)!;
      Ammo ammo = HelperJSON.getAmmo(wa.ammoId)!;
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

  bool _contains(WeaponAmmo item, List<WeaponAmmo> items) {
    for (WeaponAmmo wa in items) {
      if (widget.weaponType == WeaponType.shotgun || widget.weaponType == WeaponType.bow) {
        if (HelperJSON.getAmmo(wa.ammoId)!.name == HelperJSON.getAmmo(item.ammoId)!.name) {
          return true;
        }
      } else {
        if (wa.weaponId == item.weaponId) return true;
      }
    }
    return false;
  }

  List<WeaponAmmo> _removeDuplicates(List<WeaponAmmo> items) {
    if (_bestOnly) {
      return items;
    } else {
      List<WeaponAmmo> reduced = [];
      for (WeaponAmmo item in items) {
        if (!_contains(item, reduced)) reduced.add(item);
      }
      return reduced;
    }
  }

  List<Widget> _listWeapons(List<WeaponAmmo> items) {
    return _removeDuplicates(items).map((e) {
      Weapon weapon = HelperJSON.getWeapon(e.weaponId)!;
      Ammo ammo = HelperJSON.getAmmo(e.ammoId)!;
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

  Widget _buildWeapons(List<WeaponAmmo> items) {
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
