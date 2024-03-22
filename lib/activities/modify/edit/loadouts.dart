import 'package:collection/collection.dart';
import 'package:cotwcompanion/activities/modify/add/loadouts.dart';
import 'package:cotwcompanion/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/connect/weapon_ammo.dart';
import 'package:cotwcompanion/model/exportable/loadout.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:flutter/material.dart';

class ActivityEditLoadouts extends ActivityAddLoadouts {
  final Loadout _loadout;

  const ActivityEditLoadouts(
    Loadout loadout, {
    super.key,
    required super.onSuccess,
  })  : _loadout = loadout,
        super(type: ModifyType.edit);

  Loadout get loadout => _loadout;

  @override
  State<StatefulWidget> createState() => ActivityEditLoadoutsState();
}

class ActivityEditLoadoutsState extends ActivityAddLoadoutsState {
  late final Loadout _loadout;

  @override
  void initState() {
    _loadout = (widget as ActivityEditLoadouts).loadout;
    textController.text = _loadout.name;
    selectedAmmo.addAll(_loadout.ammo.sorted(WeaponAmmo.sortByAmmoName));
    selectedCallers.addAll(_loadout.callers.sorted(Caller.sortByName));
    errorMessage = "";
    super.initState();
  }

  @override
  void onSuccess() {
    _loadout.setName(textController.text);
    _loadout.setAmmo(selectedAmmo.map((e) => e.id).toList());
    _loadout.setCallers(selectedCallers.map((e) => e.id).toList());
    HelperLoadout.save();
  }
}
