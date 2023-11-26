// Copyright (c) 2022 - 2023 Jan Stehno

import 'dart:ui';

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/model/translatable.dart';
import 'package:easy_localization/easy_localization.dart';

class Weapon extends Translatable {
  String _name;
  final WeaponType _type;
  final int _mag, _accuracy, _recoil, _reload, _hipshot, _price;
  int _min, _max;
  final List<dynamic> _ammo = [];
  final int _dlc;

  Weapon({
    required super.id,
    required super.en,
    required super.ru,
    required super.cs,
    required super.pl,
    required super.de,
    required super.fr,
    required super.es,
    required super.br,
    required super.ja,
    required name,
    required type,
    required mag,
    required accuracy,
    required recoil,
    required reload,
    required hipshot,
    required price,
    required min,
    required max,
    required ammo,
    required dlc,
  })  : _name = name,
        _type = type,
        _mag = mag,
        _accuracy = accuracy,
        _recoil = recoil,
        _reload = reload,
        _hipshot = hipshot,
        _price = price,
        _min = min,
        _max = max,
        _dlc = dlc;

  WeaponType get type => _type;

  int get mag => _mag;

  int get accuracy => _accuracy;

  int get recoil => _recoil;

  int get reload => _reload;

  int get hipshot => _hipshot;

  int get price => _price;

  int get min => _min;

  int get max => _max;

  List<dynamic> get ammo => _ammo;

  int get dlc => _dlc;

  bool get isFromDlc => _dlc == 1;

  int get maxPenetration {
    int max = 0;
    for (int index in _ammo) {
      int pen = HelperJSON.getAmmo(index).penetration;
      if (max < pen) max = pen;
    }
    return max;
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

  set setAmmo(List<dynamic> list) {
    _ammo.clear();
    _ammo.addAll(list);
    _findMinMax();
  }

  void setName(Locale locale) {
    _name = getName(locale);
  }

  void _findMinMax() {
    int min = 9;
    int max = 1;
    Ammo ammo;
    for (int index in _ammo) {
      ammo = HelperJSON.getAmmo(index);
      if (ammo.min < min) min = ammo.min;
      if (ammo.max > max) max = ammo.max;
    }
    _min = min;
    _max = max;
  }

  String getNameForRecommendedWeaponsList(Locale locale, int? ammoId) =>
      _type == WeaponType.shotgun || _type == WeaponType.bow ? getNameAmmo(locale, ammoId) : getName(locale);

  String getNameAmmo(Locale locale, int? ammoId) => ammoId == null ? "" : HelperJSON.getAmmo(ammoId).getName(locale);

  String getTypeAsString() {
    switch (_type) {
      case (WeaponType.rifle):
        return tr("rifle");
      case (WeaponType.shotgun):
        return tr("shotgun");
      case (WeaponType.handgun):
        return tr("handgun");
      case (WeaponType.bow):
        return tr("bow_crossbow");
      default:
        return "";
    }
  }

  factory Weapon.fromJson(Map<String, dynamic> json) {
    return Weapon(
      id: json['ID'],
      en: json['EN'],
      ru: json['RU'],
      cs: json['CS'],
      pl: json['PL'],
      de: json['DE'],
      fr: json['FR'],
      es: json['ES'],
      br: json['BR'],
      ja: json['JA'],
      name: "",
      type: WeaponType.values.elementAt(json['TYPE']),
      mag: json['MAG'],
      accuracy: json['ACCURACY'],
      recoil: json['RECOIL'],
      reload: json['RELOAD'],
      hipshot: json['HIPSHOT'],
      price: json['PRICE'],
      min: 0,
      max: 0,
      ammo: [],
      dlc: json['DLC'],
    );
  }

  Map<String, dynamic> _toMap() {
    return {
      "NAME": _name,
      "TYPE": _type.index,
    };
  }

  dynamic get(String propertyName) {
    Map<String, dynamic> mapRep = _toMap();
    if (mapRep.containsKey(propertyName)) {
      return mapRep[propertyName];
    }
    throw ArgumentError("Could not find filter property. Please, go back or restart the application.");
  }
}
