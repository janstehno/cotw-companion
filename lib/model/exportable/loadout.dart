import 'dart:core';

import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/model/connect/weapon_ammo.dart';
import 'package:cotwcompanion/model/exportable/exportable.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';

class Loadout extends Exportable {
  String _name;
  List<dynamic> _ammo;
  List<dynamic> _callers;

  Loadout({
    required String name,
    required List<dynamic> ammo,
    required List<dynamic> callers,
  })  : _name = name,
        _ammo = ammo,
        _callers = callers;

  String get name => _name;

  Set<WeaponAmmo> get ammo {
    return _ammo.map((e) => HelperJSON.getWeaponAmmo(e)!).toSet();
  }

  Set<Caller> get callers {
    return _callers.map((e) => HelperJSON.getCaller(e)!).toSet();
  }

  void setName(String name) => _name = name;

  void setAmmo(List<int> ammo) {
    _ammo.clear();
    _ammo.addAll(ammo);
  }

  void setCallers(List<int> callers) {
    _callers.clear();
    _callers.addAll(callers);
  }

  static Loadout create(String name, Set<WeaponAmmo> ammo, Set<Caller> callers) {
    return Loadout(
      name: name,
      ammo: ammo.map((e) => e.id).toList(),
      callers: callers.map((e) => e.id).toList(),
    );
  }

  factory Loadout.fromJson(Map<String, dynamic> json) {
    return Loadout(
      name: json['NAME'],
      ammo: (json['AMMO'] ?? []).map((e) => e).toList(),
      callers: (json['CALLERS'] ?? []).map((e) => e).toList(),
    );
  }

  @override
  String toString() {
    return '''{
      "NAME":"$_name",
      "AMMO":${HelperJSON.listToJson(_ammo)},
      "CALLERS":${HelperJSON.listToJson(_callers)}
    }''';
  }
}
