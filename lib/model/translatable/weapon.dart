import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';
import 'package:cotwcompanion/model/translatable/translatable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class Weapon extends Translatable {
  final WeaponType _type;
  final int _mag;
  final int _accuracy;
  final int _recoil;
  final int _reload;
  final int _hipshot;
  final int _price;
  final int _score;
  final bool _dlc;

  Weapon({
    required super.id,
    required super.name,
    required WeaponType type,
    required int mag,
    required int accuracy,
    required int recoil,
    required int reload,
    required int hipshot,
    required int price,
    required int score,
    required bool dlc,
  })  : _type = type,
        _mag = mag,
        _accuracy = accuracy,
        _recoil = recoil,
        _reload = reload,
        _hipshot = hipshot,
        _price = price,
        _score = score,
        _dlc = dlc;

  WeaponType get type => _type;

  int get mag => _mag;

  int get accuracy => _accuracy;

  int get recoil => _recoil;

  int get reload => _reload;

  int get hipshot => _hipshot;

  int get price => _price;

  int get score => _score;

  bool get isFromDlc => _dlc;

  bool get hasRequirements => _score > 0;

  List<int> get levels {
    Set<int> levels = {};
    List<Ammo> ammo = HelperJSON.getWeaponsAmmo(id);
    for (Ammo a in ammo) {
      levels.addAll(a.levels);
    }
    return levels.sorted((a, b) => a.compareTo(b));
  }

  FilterKey typeToFilterKey() {
    switch (type) {
      case WeaponType.rifle:
        return FilterKey.weaponsRifles;
      case WeaponType.shotgun:
        return FilterKey.weaponsShotguns;
      case WeaponType.handgun:
        return FilterKey.weaponsHandguns;
      case WeaponType.bow:
        return FilterKey.weaponsBows;
    }
  }

  String getNameForRecommendedWeaponsList(Locale locale, int? ammoId) =>
      type == WeaponType.shotgun || type == WeaponType.bow ? getNameAmmo(locale, ammoId) : name;

  String getNameAmmo(Locale locale, int? ammoId) => ammoId == null ? "" : HelperJSON.getAmmo(ammoId)!.name;

  String get typeAsString {
    switch (type) {
      case (WeaponType.rifle):
        return tr("RIFLE");
      case (WeaponType.shotgun):
        return tr("SHOTGUN");
      case (WeaponType.handgun):
        return tr("HANDGUN");
      case (WeaponType.bow):
        return tr("BOW_CROSSBOW");
      default:
        throw UnimplementedError();
    }
  }

  factory Weapon.fromJson(Map<String, dynamic> json) {
    return Weapon(
      id: json['ID'],
      name: json['NAME'],
      type: WeaponType.values.elementAt(json['TYPE']),
      mag: json['MAG'],
      accuracy: json['ACCURACY'],
      recoil: json['RECOIL'],
      reload: json['RELOAD'],
      hipshot: json['HIPSHOT'],
      price: json['PRICE'],
      score: json['SCORE'],
      dlc: json['DLC'] == 1,
    );
  }

  static Comparator<Weapon> sortByTypeName = (a, b) {
    if (a.type.index == b.type.index) return a.name.compareTo(b.name);
    return a.type.index.compareTo(b.type.index);
  };
}
