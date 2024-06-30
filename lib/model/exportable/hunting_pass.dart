import 'dart:core';

import 'package:cotwcompanion/model/exportable/exportable.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';

class HuntingPass extends Exportable {
  Reserve? _reserve;
  Animal? _animal;
  Weapon? _weapon;
  Ammo? _ammo;
  double? _distance;
  bool? _allowedDlc;
  bool? _allowedDog;
  bool? _allowedCallers;
  bool? _allowedScopes;
  bool? _allowedAtv;
  bool? _allowedStructures;
  bool? _allowedFastTravel;
  bool? _allowedDayTime;

  HuntingPass({
    Reserve? reserve,
    Animal? animal,
    Weapon? weapon,
    Ammo? ammo,
    double? distance,
    bool? allowedDlc,
    bool? allowedDog,
    bool? allowedCallers,
    bool? allowedScopes,
    bool? allowedAtv,
    bool? allowedStructures,
    bool? allowedFastTravel,
    bool? allowedDayTime,
  })  : _reserve = reserve,
        _animal = animal,
        _weapon = weapon,
        _ammo = ammo,
        _distance = distance,
        _allowedDlc = allowedDlc,
        _allowedDog = allowedDog,
        _allowedCallers = allowedCallers,
        _allowedScopes = allowedScopes,
        _allowedAtv = allowedAtv,
        _allowedStructures = allowedStructures,
        _allowedFastTravel = allowedFastTravel,
        _allowedDayTime = allowedDayTime;

  Reserve? get reserve => _reserve;

  Animal? get animal => _animal;

  Weapon? get weapon => _weapon;

  Ammo? get ammo => _ammo;

  double? get distance => _distance;

  bool? get allowedDlc => _allowedDlc;

  bool? get allowedDog => _allowedDog;

  bool? get allowedCallers => _allowedCallers;

  bool? get allowedScopes => _allowedScopes;

  bool? get allowedAtv => _allowedAtv;

  bool? get allowedStructures => _allowedStructures;

  bool? get allowedFastTravel => _allowedFastTravel;

  bool? get allowedDayTime => _allowedDayTime;

  void setReserve(Reserve value) => _reserve = value;

  void setAnimal(Animal value) => _animal = value;

  void setWeapon(Weapon value) => _weapon = value;

  void setAmmo(Ammo value) => _ammo = value;

  void setDistance(double value) => _distance = value;

  void setAllowedDlc(bool value) => _allowedDlc = value;

  void setAllowedDog(bool value) => _allowedDog = value;

  void setAllowedCallers(bool value) => _allowedCallers = value;

  void setAllowedScopes(bool value) => _allowedScopes = value;

  void setAllowedAtv(bool value) => _allowedAtv = value;

  void setAllowedStructures(bool value) => _allowedStructures = value;

  void setAllowedFastTravel(bool value) => _allowedFastTravel = value;

  void setAllowedDayTime(bool value) => _allowedDayTime = value;
}
