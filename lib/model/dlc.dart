// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/model/describable.dart';

class Dlc extends Describable {
  final int _type;
  final String _date;
  List<dynamic> _reserve, _animals, _weapons, _callers;

  Dlc({
    required id,
    required en,
    required type,
    required date,
  })  : _type = type,
        _date = date,
        _reserve = [],
        _animals = [],
        _weapons = [],
        _callers = [],
        super(
          id: id,
          en: en,
          dEn: [],
          dRu: [],
          dCs: [],
          dPl: [],
          dDe: [],
          dFr: [],
          dEs: [],
          dBr: [],
          dJa: [],
          dHu: [],
        );

  String get date => _date;

  int get type => _type;

  List<dynamic> get reserve => _reserve;

  List<dynamic> get animals => _animals;

  List<dynamic> get weapons => _weapons;

  List<dynamic> get callers => _callers;

  set setReserve(List<dynamic> reserve) => _reserve = reserve;

  set setAnimals(List<dynamic> animals) => _animals = animals;

  set setWeapons(List<dynamic> weapons) => _weapons = weapons;

  set setCallers(List<dynamic> callers) => _callers = callers;

  factory Dlc.fromJson(Map<String, dynamic> json) {
    Dlc dlc = Dlc(
      id: json['ID'],
      en: json['NAME'],
      date: json['DATE'],
      type: json['TYPE'],
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
      dlc.setBr = json['DESCRIPTION']['BR'];
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
