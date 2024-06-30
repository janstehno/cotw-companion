import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/logger.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/exportable/hunting_pass.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HelperHuntingPass {
  final HelperLogger _logger = HelperLogger.loadingHuntingPass();

  final Map<FilterKey, bool> _huntingPassFilter = {
    FilterKey.huntingPassRandomAllowedDlc: true,
    FilterKey.huntingPassRandomReserve: true,
    FilterKey.huntingPassRandomAnimal: true,
    FilterKey.huntingPassRandomWeapon: true,
    FilterKey.weaponsRifles: true,
    FilterKey.weaponsShotguns: true,
    FilterKey.weaponsHandguns: true,
    FilterKey.weaponsBows: true,
    FilterKey.huntingPassRandomAmmo: false,
    FilterKey.huntingPassRandomDistance: false,
    FilterKey.huntingPassRandomAllowedDog: true,
    FilterKey.huntingPassRandomAllowedCallers: true,
    FilterKey.huntingPassRandomAllowedScopes: true,
    FilterKey.huntingPassRandomAllowedAtv: true,
    FilterKey.huntingPassRandomAllowedStructures: true,
    FilterKey.huntingPassRandomAllowedFastTravel: true,
    FilterKey.huntingPassRandomAllowedDayTime: false,
  };

  HuntingPass? _huntingPass;

  HuntingPass? get huntingPass => _huntingPass;

  bool getValue(FilterKey filterKey) {
    return _huntingPassFilter[filterKey]!;
  }

  void switchValue(FilterKey filterKey) {
    _huntingPassFilter.update(filterKey, (v) => !v);
    _writeFilterFile();
  }

  void initFilter(Map<String, dynamic> huntingPassFilter) {
    for (MapEntry<String, dynamic> entry in huntingPassFilter.entries) {
      FilterKey? filterKey = FilterKey.values.firstWhereOrNull((e) => e.name == entry.key);
      if (filterKey != null) _huntingPassFilter[filterKey] = entry.value;
    }
  }

  void generateHuntingPass(BuildContext context) {
    Random random = Random();
    HuntingPass huntingPass = HuntingPass();
    _generateReserve(huntingPass);
    _generateAnimal(huntingPass);
    _generateWeapon(huntingPass);
    Ammo ammo = _generateAmmo(huntingPass);
    _generateDistance(huntingPass, ammo, context);
    if (getValue(FilterKey.huntingPassRandomAllowedDlc)) huntingPass.setAllowedDlc(random.nextBool());
    if (getValue(FilterKey.huntingPassRandomAllowedDog)) huntingPass.setAllowedDog(random.nextBool());
    if (getValue(FilterKey.huntingPassRandomAllowedCallers)) huntingPass.setAllowedCallers(random.nextBool());
    if (getValue(FilterKey.huntingPassRandomAllowedScopes)) huntingPass.setAllowedScopes(random.nextBool());
    if (getValue(FilterKey.huntingPassRandomAllowedAtv)) huntingPass.setAllowedAtv(random.nextBool());
    if (getValue(FilterKey.huntingPassRandomAllowedStructures)) huntingPass.setAllowedStructures(random.nextBool());
    if (getValue(FilterKey.huntingPassRandomAllowedFastTravel)) huntingPass.setAllowedFastTravel(random.nextBool());
    if (getValue(FilterKey.huntingPassRandomAllowedDayTime)) huntingPass.setAllowedDayTime(random.nextBool());
    _huntingPass = huntingPass;
  }

  void _generateReserve(HuntingPass huntingPass) {
    if (getValue(FilterKey.huntingPassRandomReserve)) {
      List<Reserve> reserves = HelperJSON.reserves
          .where((e) => !e.isFromDlc || (e.isFromDlc && getValue(FilterKey.huntingPassRandomAllowedDlc)))
          .toList();
      Reserve reserve = reserves.elementAt(Random().nextInt(reserves.length));
      huntingPass.setReserve(reserve);
    }
  }

  void _generateAnimal(HuntingPass huntingPass) {
    if (getValue(FilterKey.huntingPassRandomAnimal)) {
      Animal animal;
      if (getValue(FilterKey.huntingPassRandomReserve)) {
        List<Animal> animals = HelperJSON.getReserveAnimals(huntingPass.reserve!.id);
        animal = animals.elementAt(Random().nextInt(animals.length));
      } else {
        animal = HelperJSON.animals.elementAt(Random().nextInt(HelperJSON.animals.length));
      }
      huntingPass.setAnimal(animal);
    }
  }

  void _generateWeapon(HuntingPass huntingPass) {
    if (getValue(FilterKey.huntingPassRandomWeapon)) {
      Weapon weapon;
      List<Weapon> allWeapons = HelperJSON.weapons
          .where((e) => !e.isFromDlc || (e.isFromDlc && getValue(FilterKey.huntingPassRandomAllowedDlc)))
          .toList();
      if (getValue(FilterKey.weaponsRifles) ||
          getValue(FilterKey.weaponsShotguns) ||
          getValue(FilterKey.weaponsHandguns) ||
          getValue(FilterKey.weaponsBows)) {
        allWeapons = allWeapons.where((e) => getValue(e.typeToFilterKey())).toList();
      }
      if (getValue(FilterKey.huntingPassRandomAnimal)) {
        List<Weapon> animalWeapons = allWeapons.where((e) => e.levels.contains(huntingPass.animal!.level)).toList();
        weapon = animalWeapons.elementAt(Random().nextInt(animalWeapons.length));
      } else {
        weapon = allWeapons.elementAt(Random().nextInt(allWeapons.length));
      }
      huntingPass.setWeapon(weapon);
    }
  }

  Ammo _generateAmmo(HuntingPass huntingPass) {
    Ammo ammo;
    List<Ammo> allAmmo = HelperJSON.ammo;
    if (getValue(FilterKey.huntingPassRandomAnimal)) {
      allAmmo = allAmmo.where((e) => e.min <= huntingPass.animal!.level && e.max >= huntingPass.animal!.level).toList();
    }
    if (getValue(FilterKey.huntingPassRandomWeapon)) {
      List<Ammo> weaponAmmo = HelperJSON.getWeaponsAmmo(huntingPass.weapon!.id)
          .where((e) => allAmmo.firstWhereOrNull((f) => e.id == f.id) != null)
          .toList();
      ammo = weaponAmmo.elementAt(Random().nextInt(weaponAmmo.length));
    } else {
      ammo = allAmmo.elementAt(Random().nextInt(allAmmo.length));
    }
    if (getValue(FilterKey.huntingPassRandomAmmo)) {
      huntingPass.setAmmo(ammo);
    }
    return ammo;
  }

  void _generateDistance(HuntingPass huntingPass, Ammo ammo, BuildContext context) {
    if (getValue(FilterKey.huntingPassRandomDistance)) {
      bool imperials = Provider.of<Settings>(context, listen: false).imperialUnits;
      int max = 300;
      if (getValue(FilterKey.huntingPassRandomWeapon) || getValue(FilterKey.huntingPassRandomAmmo)) {
        max = ammo.range(imperials).floor();
      }
      double distance = (Random().nextInt(max) + 15) * (imperials ? 1.0936 : 1);
      huntingPass.setDistance(distance);
    }
  }

  void _writeFilterFile() async {
    final String content = parseFilterToJson();
    Utils.writeFile(content, Values.huntingPassFilter);
  }

  Future<Map<String, dynamic>> readFilterFile() async {
    try {
      final data = await Utils.readFile(Values.huntingPassFilter);
      final list = json.decode(data) as Map<String, dynamic>;
      _logger.t("${list.length} hunting pass filters loaded");
      return list;
    } catch (e) {
      _logger.w("Hunting pass filters not loaded");
      rethrow;
    }
  }

  parseFilterToJson() {
    return json.encode(_huntingPassFilter.map((k, v) => MapEntry<String, bool>(k.name, v)));
  }
}
