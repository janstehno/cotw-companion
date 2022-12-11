// Copyright (c) 2022 Jan Stehno

import 'dart:ui';

class ContentList {
  List<Dlc> content;

  ContentList({required this.content});

  factory ContentList.fromJson(List<dynamic> json) {
    List<Dlc> ammo = <Dlc>[];
    ammo = json.map((i) => Dlc.fromJson(i)).toList();
    return ContentList(content: ammo);
  }
}

class Dlc {
  int id;
  int type;
  String name, date;
  late List<dynamic> en, ru, cs, pl, de, fr, es, pt, ja;
  List<dynamic> reserve = [], animals = [], callers = [], weapons = [];

  Dlc({required this.id, required this.type, required this.name, required this.date});

  setEN(List<dynamic> s) {
    en = s;
  }

  setRU(List<dynamic> s) {
    ru = s;
  }

  setCS(List<dynamic> s) {
    cs = s;
  }

  setPL(List<dynamic> s) {
    pl = s;
  }

  setDE(List<dynamic> s) {
    de = s;
  }

  setFR(List<dynamic> s) {
    fr = s;
  }

  setES(List<dynamic> s) {
    es = s;
  }

  setPT(List<dynamic> s) {
    pt = s;
  }

  setJA(List<dynamic> s) {
    ja = s;
  }

  setReserve(List<dynamic> l) {
    reserve = l;
  }

  setAnimals(List<dynamic> l) {
    animals = l;
  }

  setCallers(List<dynamic> l) {
    callers = l;
  }

  setWeapons(List<dynamic> l) {
    weapons = l;
  }

  String get getName => name;

  String get getDate => date;

  int get getType => type;

  List<dynamic> get getReserves => reserve;

  List<dynamic> get getAnimals => animals;

  List<dynamic> get getWeapons => weapons;

  List<dynamic> get getCallers => callers;

  factory Dlc.fromJson(Map<String, dynamic> json) {
    int contentType = json['TYPE'];
    Dlc c = Dlc(id: json['ID'], name: json['NAME'], date: json['DATE'], type: json['TYPE']);
    if (contentType >= 0) {
      c.setEN(json['DESCRIPTION']['EN']);
      c.setRU(json['DESCRIPTION']['RU']);
      c.setCS(json['DESCRIPTION']['CS']);
      c.setPL(json['DESCRIPTION']['PL']);
      c.setDE(json['DESCRIPTION']['DE']);
      c.setFR(json['DESCRIPTION']['FR']);
      c.setES(json['DESCRIPTION']['ES']);
      c.setPT(json['DESCRIPTION']['PT']);
      c.setJA(json['DESCRIPTION']['JA']);
    }
    if (contentType == 1) {
      c.setReserve(json['MAP']['MAP']);
      c.setAnimals(json['MAP']['ANIMALS']);
      c.setWeapons(json['MAP']['WEAPONS']);
      c.setCallers(json['MAP']['CALLERS']);
    }
    if (contentType == 2) {
      c.setWeapons(json['WEAPONS']);
    }
    if (contentType == 3) {
      c.setAnimals(json['ANIMALS']);
      c.setCallers(json['CALLERS']);
    }
    return c;
  }

  List<dynamic> getDescription(Locale locale) {
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
}
