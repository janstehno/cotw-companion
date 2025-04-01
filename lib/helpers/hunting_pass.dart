import 'dart:math';

import 'package:collection/collection.dart';
import 'package:cotwcompanion/filters/hunting_pass.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/describable/dlc.dart';
import 'package:cotwcompanion/model/exportable/hunting_pass.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HelperHuntingPass {
  HuntingPass? _huntingPass;

  HuntingPass? get huntingPass => _huntingPass;

  void generateHuntingPass(FilterHuntingPass filter, BuildContext context) {
    Random random = Random();
    HuntingPass huntingPass = HuntingPass();
    if (filter.allowedReserves) _generateReserve(filter, huntingPass);
    if (filter.allowedAnimals) _generateAnimal(filter, huntingPass);
    if (filter.allowedWeapons) _generateWeapon(filter, huntingPass);
    if (filter.allowedAmmo) _generateAmmo(filter, huntingPass);
    if (filter.allowedDistance) _generateDistance(filter, huntingPass, context);
    if (filter.allowedDog) huntingPass.setAllowedDog(random.nextBool());
    if (filter.allowedCallers) huntingPass.setAllowedCallers(random.nextBool());
    if (filter.allowedScopes) huntingPass.setAllowedScopes(random.nextBool());
    if (filter.allowedAtv) huntingPass.setAllowedAtv(random.nextBool());
    if (filter.allowedStructures) huntingPass.setAllowedStructures(random.nextBool());
    if (filter.allowedFastTravel) huntingPass.setAllowedFastTravel(random.nextBool());
    if (filter.allowedDayTime) huntingPass.setAllowedDayTime(random.nextBool());
    _huntingPass = huntingPass;
  }

  void _generateReserve(FilterHuntingPass filter, HuntingPass huntingPass) {
    List<Reserve> reserves = HelperJSON.reserves.where((e) {
      bool dlcAllowed = false;
      final bool isFromDlc = e.isFromDlc;
      if (isFromDlc) {
        final Dlc? dlc = HelperJSON.getDlcs(DlcType.reserve).firstWhereOrNull((d) => d.reserve == e.id);
        dlcAllowed = dlc != null && filter.isEnabled(FilterKey.huntingPassReserveDlcs, filter.reserveDlcs.indexOf(dlc));
      }
      return !isFromDlc || (isFromDlc && dlcAllowed);
    }).toList();
    Reserve reserve = reserves.elementAt(Random().nextInt(reserves.length));
    huntingPass.setReserve(reserve);
  }

  void _generateAnimal(FilterHuntingPass filter, HuntingPass huntingPass) {
    Animal animal;
    List<Animal> animals;
    if (filter.allowedReserves) {
      animals = HelperJSON.getReserveAnimals(huntingPass.reserve!.id);
    } else {
      animals = HelperJSON.animals.where((e) {
        bool dlcAllowed = false;
        final bool isFromDlc = e.isFromDlc;
        if (isFromDlc) {
          final Dlc? dlc = HelperJSON.getDlcs(DlcType.reserve).firstWhereOrNull((d) => d.animals.contains(e.id));
          dlcAllowed =
              dlc != null && filter.isEnabled(FilterKey.huntingPassReserveDlcs, filter.reserveDlcs.indexOf(dlc));
        }
        return !isFromDlc || (isFromDlc && dlcAllowed);
      }).toList();
    }
    animal = animals.elementAt(Random().nextInt(animals.length));
    huntingPass.setAnimal(animal);
  }

  void _generateWeapon(FilterHuntingPass filter, HuntingPass huntingPass) {
    Weapon weapon;
    List<Weapon> weapons = HelperJSON.weapons.where((e) {
      bool dlcAllowed = false;
      final bool isFromDlc = e.isFromDlc;
      final bool isTypeAllowed = filter.isEnabled(FilterKey.huntingPassWeapons, e.type.index);
      if (isTypeAllowed && isFromDlc) {
        final Dlc? dlc = HelperJSON.dlcs
            .where((d) => d.type == DlcType.reserve || d.type == DlcType.weapon)
            .firstWhereOrNull((d) => d.weapons.contains(e.id));
        dlcAllowed = dlc != null &&
            ((dlc.type == DlcType.reserve &&
                    filter.isEnabled(FilterKey.huntingPassReserveDlcs, filter.reserveDlcs.indexOf(dlc))) ||
                (dlc.type == DlcType.weapon &&
                    filter.isEnabled(FilterKey.huntingPassWeaponDlcs, filter.weaponDlcs.indexOf(dlc))));
      }
      return isTypeAllowed && (!isFromDlc || (isFromDlc && dlcAllowed));
    }).toList();

    if (filter.allowedAnimals) {
      List<Weapon> animalWeapons = weapons.where((e) => e.levels.contains(huntingPass.animal!.level)).toList();
      weapon = animalWeapons.elementAt(Random().nextInt(animalWeapons.length));
    } else {
      weapon = weapons.elementAt(Random().nextInt(weapons.length));
    }
    huntingPass.setWeapon(weapon);
  }

  Ammo _generateAmmo(FilterHuntingPass filter, HuntingPass huntingPass) {
    Ammo ammo;
    List<Ammo> allAmmo = HelperJSON.ammo;
    if (filter.allowedAnimals) {
      allAmmo = allAmmo.where((e) => e.min <= huntingPass.animal!.level && e.max >= huntingPass.animal!.level).toList();
    }
    if (filter.allowedWeapons) {
      List<Ammo> weaponAmmo = HelperJSON.getWeaponsAmmo(huntingPass.weapon!.id)
          .where((e) => allAmmo.firstWhereOrNull((f) => e.id == f.id) != null)
          .toList();
      ammo = weaponAmmo.elementAt(Random().nextInt(weaponAmmo.length));
    } else {
      ammo = allAmmo.elementAt(Random().nextInt(allAmmo.length));
    }
    huntingPass.setAmmo(ammo);
    return ammo;
  }

  void _generateDistance(FilterHuntingPass filter, HuntingPass huntingPass, BuildContext context) {
    bool imperials = Provider.of<Settings>(context, listen: false).imperialUnits;
    int max = 300;
    if (filter.allowedAmmo) {
      max = huntingPass.ammo!.range(imperials).floor();
    }
    double distance = (Random().nextInt(max) + 15) * (imperials ? 1.0936 : 1);
    huntingPass.setDistance(distance);
  }
}
