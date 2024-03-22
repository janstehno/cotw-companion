import 'package:cotwcompanion/helpers/json.dart';

class WeaponAmmo {
  final int _id;
  final int _weaponId;
  final int _ammoId;

  WeaponAmmo({
    required int id,
    required int weaponId,
    required int ammoId,
  })  : _id = id,
        _weaponId = weaponId,
        _ammoId = ammoId;

  int get id => _id;

  int get weaponId => _weaponId;

  int get ammoId => _ammoId;

  factory WeaponAmmo.fromJson(Map<String, dynamic> json) {
    return WeaponAmmo(
      id: json['ID'],
      weaponId: json['WEAPON_ID'],
      ammoId: json['AMMO_ID'],
    );
  }

  @override
  String toString() {
    return id.toString();
  }

  static Comparator<WeaponAmmo> sortByWeaponName =
      (a, b) => HelperJSON.getWeapon(a.weaponId)!.name.compareTo(HelperJSON.getWeapon(b.weaponId)!.name);

  static Comparator<WeaponAmmo> sortByAmmoName =
      (a, b) => HelperJSON.getAmmo(a.ammoId)!.name.compareTo(HelperJSON.getAmmo(b.ammoId)!.name);
}
