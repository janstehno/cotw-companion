// Copyright (c) 2022 Jan Stehno

import 'dart:core';

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';

class Loadout {
  int _id;
  String _name;
  final List<dynamic> _ammo = [];
  final List<dynamic> _callers = [];

  Loadout({
    required id,
    required name,
  })  : _id = id,
        _name = name;

  int get id => _id;

  String get name => _name;

  List<dynamic> get ammo => _ammo;

  List<dynamic> get callers => _callers;

  String toJson() => '{"ID":$_id,"NAME":"$_name","AMMO":${HelperJSON.listToJson(_ammo)},"CALLERS":${HelperJSON.listToJson(_callers)}}';

  set setAmmo(List<dynamic> ammo) {
    _ammo.clear();
    _ammo.addAll(ammo);
  }

  set setCallers(List<dynamic> callers) {
    _callers.clear();
    _callers.addAll(callers);
  }

  set setId(int i) => _id = i;

  factory Loadout.fromJson(Map<String, dynamic> json) {
    Loadout loadout = Loadout(
      id: json['ID'],
      name: json['NAME'],
    );
    loadout.setAmmo = json['AMMO'] ?? [];
    loadout.setCallers = json['CALLERS'] ?? [];
    return loadout;
  }
}
