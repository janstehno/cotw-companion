// Copyright (c) 2022 Jan Stehno

import 'dart:core';

import 'package:cotwcompanion/helpers/helper_json.dart';

class LoadoutList {
  List<Loadout> loadouts;

  LoadoutList({required this.loadouts});

  factory LoadoutList.fromJson(List<dynamic> json) {
    List<Loadout> loadouts = <Loadout>[];
    loadouts = json.map((i) => Loadout.fromJson(i)).toList();
    return LoadoutList(loadouts: loadouts);
  }
}

class Loadout {
  int id;
  String name;
  List<dynamic> weapons = [], callers = [];

  Loadout({required this.id, required this.name, required this.weapons, required this.callers});

  int get getID => id;

  String get getName => name;

  List<dynamic> get getWeapons => weapons;

  List<dynamic> get getCallers => callers;

  String toJson() => '{"ID":$id,"NAME":"$name","WEAPONS":${JSONHelper.listToJson(weapons)},"CALLERS":${JSONHelper.listToJson(callers)}}';

  setWeapons(List<int> l) {
    weapons.clear();
    weapons.addAll(l);
  }

  setCallers(List<int> l) {
    callers.clear();
    callers.addAll(l);
  }

  setID(int i) {
    id = i;
  }

  factory Loadout.fromJson(Map<String, dynamic> json) {
    return Loadout(id: json['ID'], name: json['NAME'], weapons: json['WEAPONS'], callers: json['CALLERS']);
  }
}
