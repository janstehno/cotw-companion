import 'package:collection/collection.dart';
import 'package:cotwcompanion/activities/detail/weapon.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/model/connect/weapon_ammo.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:cotwcompanion/widgets/parts/reserve/weapon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListReserveWeapons extends StatelessWidget {
  final Reserve _reserve;
  final WeaponType _weaponType;
  final bool _withDlc;

  const ListReserveWeapons(
    Reserve reserve, {
    super.key,
    required WeaponType weaponType,
    required bool withDlc,
  })  : _reserve = reserve,
        _weaponType = weaponType,
        _withDlc = withDlc;

  List<Animal> get _animals => HelperJSON.getReserveAnimals(_reserve.id);

  void _onTap(BuildContext context, Weapon weapon) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (e) => ActivityDetailWeapon(weapon)),
    );
  }

  List<Weapon> _initializeWeapons(BuildContext context) {
    bool units = Provider.of<Settings>(context, listen: false).imperialUnits;
    Set<Weapon> recommendedWeaponsDLC = {};
    Set<Weapon> recommendedWeaponsNonDLC = {};

    Set<int> animalLevels = _getAnimalLevels();

    Map<int, WeaponAmmo> animalWeaponsDLC = _getAnimalWeapons(animalLevels, units, true, _withDlc);
    Map<int, WeaponAmmo> animalWeaponsNonDLC = _getAnimalWeapons(animalLevels, units, false, true);

    _populateRecommendedWeapons(animalWeaponsDLC, recommendedWeaponsDLC);
    _populateRecommendedWeapons(animalWeaponsNonDLC, recommendedWeaponsNonDLC);

    List<Weapon> allRecommendedWeapons = [...recommendedWeaponsNonDLC, ...recommendedWeaponsDLC];
    allRecommendedWeapons.sort(Weapon.sortByMinMax);

    return _reduceWeaponList(animalLevels, allRecommendedWeapons);
  }

  Set<int> _getAnimalLevels() {
    Set<int> levels = {};
    for (Animal animal in _animals) {
      levels.add(animal.level);
    }
    return levels;
  }

  Map<int, WeaponAmmo> _getAnimalWeapons(Set<int> animalLevels, bool units, bool fromDlc, bool withDlc) {
    Map<int, WeaponAmmo> animalWeapons = {};
    for (WeaponAmmo weaponAmmo in HelperJSON.weaponsAmmo) {
      Weapon weapon = HelperJSON.getWeapon(weaponAmmo.weaponId)!;
      Ammo ammo = HelperJSON.getAmmo(weaponAmmo.ammoId)!;

      if (weapon.type == _weaponType && (animalLevels.contains(ammo.min) || animalLevels.contains(ammo.max))) {
        if (weapon.isFromDlc == fromDlc && withDlc) {
          _updateBestWeaponForAnimalLevel(animalWeapons, weaponAmmo, units);
        }
      }
    }
    return animalWeapons;
  }

  void _updateBestWeaponForAnimalLevel(Map<int, WeaponAmmo> animalWeapons, WeaponAmmo weaponAmmo, bool units) {
    Ammo ammo = HelperJSON.getAmmo(weaponAmmo.ammoId)!;
    int minLevel = ammo.min;
    int maxLevel = ammo.max;

    for (int level = minLevel; level <= maxLevel; level++) {
      if (!animalWeapons.containsKey(level)) {
        animalWeapons[level] = weaponAmmo;
      } else {
        WeaponAmmo currentBest = animalWeapons[level]!;
        Ammo currentAmmo = HelperJSON.getAmmo(currentBest.ammoId)!;

        if (_levelsOverlap(minLevel, maxLevel, currentAmmo.min, currentAmmo.max)) {
          if (ammo.range(units) > currentAmmo.range(units) || ammo.penetration > currentAmmo.penetration) {
            animalWeapons[level] = weaponAmmo;
          }
        }
      }
    }
  }

  void _populateRecommendedWeapons(Map<int, WeaponAmmo> animalWeapons, Set<Weapon> recommendedWeapons) {
    for (int i = 9; i > 0; i--) {
      WeaponAmmo? weaponAmmo = animalWeapons[i];
      if (weaponAmmo != null) {
        Weapon weapon = HelperJSON.getWeapon(weaponAmmo.weaponId)!;
        recommendedWeapons.add(weapon);
        i = HelperJSON.getAmmo(weaponAmmo.ammoId)!.min;
      }
    }
  }

  List<Weapon> _reduceWeaponList(Set<int> animalLevels, List<Weapon> weapons) {
    List<Weapon> reducedWeapons = [];
    List<Weapon> nonDlcWeapons = [];
    List<Weapon> dlcWeapons = [];

    for (Weapon weapon in weapons) {
      if (weapon.isFromDlc) {
        dlcWeapons.add(weapon);
      } else {
        nonDlcWeapons.add(weapon);
      }
    }

    for (Weapon weapon in nonDlcWeapons) {
      bool shouldAdd = true;
      for (int j = 0; j < reducedWeapons.length; j++) {
        if (_canReplace(reducedWeapons[j], weapon)) {
          shouldAdd = false;
          break;
        }
      }
      if (shouldAdd) reducedWeapons.add(weapon);
    }

    for (Weapon weapon in dlcWeapons) {
      bool shouldAdd = true;
      for (int j = 0; j < reducedWeapons.length; j++) {
        if (_canReplace(reducedWeapons[j], weapon)) {
          shouldAdd = false;
          break;
        }
      }
      if (shouldAdd) reducedWeapons.add(weapon);
    }

    Set<int> coveredLevels = {};
    for (Weapon weapon in reducedWeapons) {
      coveredLevels.addAll(weapon.levels);
    }

    Set<int> uncoveredLevels = animalLevels.difference(coveredLevels);
    for (int level in uncoveredLevels) {
      Weapon? suitableWeapon = _findSuitableWeaponForLevel(level, nonDlcWeapons, dlcWeapons);
      if (suitableWeapon != null) {
        reducedWeapons.add(suitableWeapon);
      }
    }

    return reducedWeapons.sorted(Weapon.sortByMinMax);
  }

  Weapon? _findSuitableWeaponForLevel(int level, List<Weapon> nonDlcWeapons, List<Weapon> dlcWeapons) {
    for (Weapon weapon in nonDlcWeapons) {
      List<int> levels = weapon.levels;
      if (levels.min <= level && levels.max >= level) {
        return weapon;
      }
    }

    for (Weapon weapon in dlcWeapons) {
      List<int> levels = weapon.levels;
      if (levels.min <= level && levels.max >= level) {
        return weapon;
      }
    }

    return null; // Return null if no suitable weapon is found
  }

  bool _levelsOverlap(int newMin, int newMax, int existingMin, int existingMax) {
    return (newMin <= existingMax && newMax >= existingMin);
  }

  bool _canReplace(Weapon existingWeapon, Weapon newWeapon) {
    List<int> existingWeaponLevels = existingWeapon.levels;
    List<int> newWeaponLevels = newWeapon.levels;
    int existingMin = existingWeaponLevels.min;
    int existingMax = existingWeaponLevels.max;
    int newMin = newWeaponLevels.min;
    int newMax = newWeaponLevels.max;

    return _levelsOverlap(newMin, newMax, existingMin, existingMax);
  }

  Widget _buildEntry(int i, Weapon weapon, BuildContext context) {
    return WidgetReserveWeapon(
      weapon,
      background: Utils.backgroundAt(i),
      indicatorColor: Interface.primary,
      isShown: weapon.isFromDlc,
      onTap: () => _onTap(context, weapon),
    );
  }

  List<Widget> _listWeapons(BuildContext context) {
    List<Weapon> weapons = _initializeWeapons(context);
    return weapons.mapIndexed((i, weapon) => _buildEntry(i, weapon, context)).toList();
  }

  Widget _buildWidgets(BuildContext context) {
    return Column(children: _listWeapons(context));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
