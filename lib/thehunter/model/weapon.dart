// Copyright (c) 2022 Jan Stehno

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';

class WeaponList {
  List<Weapon> weapons;

  WeaponList({required this.weapons});

  factory WeaponList.fromJson(List<dynamic> json) {
    List<Weapon> weapons = <Weapon>[];
    weapons = json.map((i) => Weapon.fromJson(i)).toList();
    return WeaponList(weapons: weapons);
  }
}

class Weapon {
  int id;
  String name;
  String en, ru, cs, pl, de, fr, es, pt, ja;
  int type, mag;
  int ammoId;
  String ammoEn, ammoRu, ammoCs, ammoPl, ammoDe, ammoFr, ammoEs, ammoPt, ammoJa;
  int min, max;
  int penetration;
  int dlc;

  Weapon(
      {required this.id,
      this.name = "",
      required this.en,
      required this.ru,
      required this.cs,
      required this.pl,
      required this.de,
      required this.fr,
      required this.es,
      required this.pt,
      required this.ja,
      required this.ammoId,
      required this.ammoEn,
      required this.ammoRu,
      required this.ammoCs,
      required this.ammoPl,
      required this.ammoDe,
      required this.ammoFr,
      required this.ammoEs,
      required this.ammoPt,
      required this.ammoJa,
      required this.type,
      required this.mag,
      required this.dlc,
      required this.min,
      required this.max,
      required this.penetration});

  int get getID => id;

  int get getAmmoID => ammoId;

  int get getType => type;

  int get getMag => mag;

  int get getMin => min;

  int get getMax => max;

  int get getPenetration => penetration;

  bool get getDlc => dlc == 1;

  void setName(Locale locale) {
    name = getName(locale);
  }

  String getNameForRecommendedWeaponsList(Locale locale) => type == 1 || type == 3 ? getNameAmmo(locale) : getName(locale);

  String getTypeAsString() {
    switch (type) {
      case (1):
        return tr('shotgun');
      case (2):
        return tr('handgun');
      case (3):
        return tr('bow_crossbow');
      default:
        return tr('rifle');
    }
  }

  String getName(Locale locale) {
    switch (locale.languageCode.toString()) {
      case "ru":
        return ru.isEmpty ? en : ru;
      case "cs":
        return cs.isEmpty ? en : cs;
      case "pl":
        return pl.isEmpty ? en : pl;
      case "de":
        return de.isEmpty ? en : de;
      case "fr":
        return fr.isEmpty ? en : fr;
      case "es":
        return es.isEmpty ? en : es;
      case "pt":
        return pt.isEmpty ? en : pt;
      case "ja":
        return ja.isEmpty ? en : ja;
      case "sk":
        return cs.isEmpty ? en : cs;
      default:
        return en;
    }
  }

  String getNameAmmo(Locale locale) {
    switch (locale.languageCode.toString()) {
      case "ru":
        return ammoRu.isEmpty ? ammoEn : ammoRu;
      case "cs":
        return ammoCs.isEmpty ? ammoEn : ammoCs;
      case "pl":
        return ammoPl.isEmpty ? ammoEn : ammoPl;
      case "de":
        return ammoDe.isEmpty ? ammoEn : ammoDe;
      case "fr":
        return ammoFr.isEmpty ? ammoEn : ammoFr;
      case "es":
        return ammoEs.isEmpty ? ammoEn : ammoEs;
      case "pt":
        return ammoPt.isEmpty ? ammoEn : ammoPt;
      case "ja":
        return ammoJa.isEmpty ? ammoEn : ammoJa;
      case "sk":
        return ammoCs.isEmpty ? ammoEn : ammoCs;
      default:
        return ammoEn;
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
        pt: json['PT'],
        ja: json['JA'],
        type: json['TYPE'],
        mag: json['MAG'],
        dlc: json['DLC'],
        ammoId: 0,
        ammoEn: "",
        ammoRu: "",
        ammoCs: "",
        ammoPl: "",
        ammoDe: "",
        ammoFr: "",
        ammoEs: "",
        ammoPt: "",
        ammoJa: "",
        min: 0,
        max: 0,
        penetration: 0);
  }

  factory Weapon.fromJsonWithAdditionalInfo(Map<String, dynamic> json) {
    return Weapon(
        id: json['ID'],
        en: json['EN'],
        ru: json['RU'],
        cs: json['CS'],
        pl: json['PL'],
        de: json['DE'],
        fr: json['FR'],
        es: json['ES'],
        pt: json['PT'],
        ja: json['JA'],
        type: json['TYPE'],
        mag: json['MAG'],
        dlc: json['DLC'],
        ammoId: json['AMMO_ID'],
        ammoEn: json['AMMO_EN'],
        ammoRu: json['AMMO_RU'],
        ammoCs: json['AMMO_CS'],
        ammoPl: json['AMMO_PL'],
        ammoDe: json['AMMO_DE'],
        ammoFr: json['AMMO_FR'],
        ammoEs: json['AMMO_ES'],
        ammoPt: json['AMMO_PT'],
        ammoJa: json['AMMO_JA'],
        min: json['MIN_LEVEL'],
        max: json['MAX_LEVEL'],
        penetration: json['PENETRATION']);
  }

  Map<String, dynamic> _toMap() {
    return {'NAME': name, 'TYPE': type};
  }

  dynamic get(String propertyName) {
    var mapRep = _toMap();
    if (mapRep.containsKey(propertyName)) {
      return mapRep[propertyName];
    }
    throw ArgumentError('Could not find filter property. Please, go back or restart the application.');
  }
}
