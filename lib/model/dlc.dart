// Copyright (c) 2022 Jan Stehno

import 'dart:ui';

class Dlc {
  final int _id;
  final int _type;
  final String _name, _date;
  List<dynamic> _en, _ru, _cs, _pl, _de, _fr, _es, _pt, _ja, _hu;
  List<dynamic> _reserve, _animals, _weapons, _callers;

  Dlc({
    required id,
    required type,
    required name,
    required date,
    required en,
    required ru,
    required cs,
    required pl,
    required de,
    required fr,
    required es,
    required pt,
    required ja,
    required hu,
    required reserve,
    required animals,
    required weapons,
    required callers,
  })  : _id = id,
        _type = type,
        _name = name,
        _date = date,
        _en = en,
        _ru = ru,
        _cs = cs,
        _pl = pl,
        _de = de,
        _fr = fr,
        _es = es,
        _pt = pt,
        _ja = ja,
        _hu = hu,
        _reserve = reserve,
        _animals = animals,
        _weapons = weapons,
        _callers = callers;

  int get id => _id;

  String get name => _name;

  String get date => _date;

  int get type => _type;

  List<dynamic> get reserve => _reserve;

  List<dynamic> get animals => _animals;

  List<dynamic> get weapons => _weapons;

  List<dynamic> get callers => _callers;

  set setEn(List<dynamic> en) => _en = en;

  set setRu(List<dynamic> ru) => _ru = ru;

  set setCs(List<dynamic> cs) => _cs = cs;

  set setPl(List<dynamic> pl) => _pl = pl;

  set setDe(List<dynamic> de) => _de = de;

  set setFr(List<dynamic> fr) => _fr = fr;

  set setEs(List<dynamic> es) => _es = es;

  set setPt(List<dynamic> pt) => _pt = pt;

  set setJa(List<dynamic> ja) => _ja = ja;

  set setHu(List<dynamic> hu) => _hu = hu;

  set setReserve(List<dynamic> reserve) => _reserve = reserve;

  set setAnimals(List<dynamic> animals) => _animals = animals;

  set setWeapons(List<dynamic> weapons) => _weapons = weapons;

  set setCallers(List<dynamic> callers) => _callers = callers;

  List<dynamic> getDescription(Locale locale) {
    switch (locale.languageCode.toString()) {
      case "ru":
        return _ru.isEmpty ? _en : _ru;
      case "cs":
        return _cs.isEmpty ? _en : _cs;
      case "pl":
        return _pl.isEmpty ? _en : _pl;
      case "de":
        return _de.isEmpty ? _en : _de;
      case "fr":
        return _fr.isEmpty ? _en : _fr;
      case "es":
        return _es.isEmpty ? _en : _es;
      case "pt":
        return _pt.isEmpty ? _en : _pt;
      case "ja":
        return _ja.isEmpty ? _en : _ja;
      case "hu":
        return _hu.isEmpty ? _en : _hu;
      case "sk":
        return _cs.isEmpty ? _en : _cs;
      default:
        return _en;
    }
  }

  factory Dlc.fromJson(Map<String, dynamic> json) {
    Dlc dlc = Dlc(
      id: json['ID'],
      name: json['NAME'],
      date: json['DATE'],
      type: json['TYPE'],
      en: [],
      ru: [],
      cs: [],
      pl: [],
      de: [],
      fr: [],
      es: [],
      pt: [],
      ja: [],
      hu: [],
      reserve: [],
      animals: [],
      weapons: [],
      callers: [],
    );
    int type = json['TYPE'];
    if (type >= 0) {
      dlc.setEn = json['DESCRIPTION']['EN'];
      dlc.setRu = json['DESCRIPTION']['RU'];
      dlc.setCs = json['DESCRIPTION']['CS'];
      dlc.setPl = json['DESCRIPTION']['PL'];
      dlc.setDe = json['DESCRIPTION']['DE'];
      dlc.setFr = json['DESCRIPTION']['FR'];
      dlc.setEs = json['DESCRIPTION']['ES'];
      dlc.setPt = json['DESCRIPTION']['PT'];
      dlc.setJa = json['DESCRIPTION']['JA'];
      dlc.setHu = json['DESCRIPTION']['HU'];
    }
    if (type == 1) {
      dlc.setReserve = json['MAP']['RESERVE'];
      dlc.setAnimals = json['MAP']['ANIMALS'];
      dlc.setWeapons = json['MAP']['WEAPONS'];
      dlc.setCallers = json['MAP']['CALLERS'];
    }
    if (type == 2) {
      dlc.setWeapons = json['WEAPONS'];
    }
    if (type == 3) {
      dlc.setAnimals = json['ANIMALS'];
      dlc.setCallers = json['CALLERS'];
    }
    return dlc;
  }
}
