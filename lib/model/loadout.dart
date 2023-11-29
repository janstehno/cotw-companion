// Copyright (c) 2023 Jan Stehno

import 'dart:core';

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';

class Loadout {
  int _id;
  String _name;
  final List<dynamic> _ammo;
  final List<dynamic> _callers;

  Loadout({
    id,
    name,
    ammo,
    callers,
  })  : _id = id ?? -1,
        _name = name ?? "Default",
        _ammo = ammo ?? [],
        _callers = callers ?? [];

  int get id => _id;

  String get name => _name;

  List<int> get ammo => _ammo.cast();

  List<int> get callers => _callers.cast();

  set setAmmo(List<dynamic> ammo) {
    _ammo.clear();
    _ammo.addAll(ammo);
  }

  set setCallers(List<dynamic> callers) {
    _callers.clear();
    _callers.addAll(callers);
  }

  set setId(int id) => _id = id;

  @override
  String toString() => '{"ID":$_id,"NAME":"$_name","AMMO":${HelperJSON.listToJson(_ammo)},"CALLERS":${HelperJSON.listToJson(_callers)}}';

  factory Loadout.fromJson(Map<String, dynamic> json) {
    return Loadout(
      id: json['ID'],
      name: json['NAME'],
      ammo: json['AMMO'],
      callers: json['CALLERS'],
    );
  }
}
