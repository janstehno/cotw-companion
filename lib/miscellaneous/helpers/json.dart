// Copyright (c) 2023 Jan Stehno

import 'dart:convert';
import 'dart:io';

import 'package:cotwcompanion/miscellaneous/interface/logger.dart';
import 'package:cotwcompanion/miscellaneous/interface/values.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/animal_fur.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/model/dlc.dart';
import 'package:cotwcompanion/model/fur.dart';
import 'package:cotwcompanion/model/giver.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/model/mission.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/model/weapon.dart';
import 'package:cotwcompanion/model/weapon_ammo.dart';
import 'package:cotwcompanion/model/zone.dart';
import 'package:flutter/services.dart' as root_bundle;

class HelperJSON {
  static final HelperLogger _logger = HelperLogger.loadingApp();

  static final List<Ammo> _ammo = [];
  static final List<Animal> _animals = [];
  static final List<IdtoId> _animalsCallers = [];
  static final List<AnimalFur> _animalsFurs = [];
  static final List<IdtoId> _animalsReserves = [];
  static final List<Zone> _animalsZones = [];
  static final List<Caller> _callers = [];
  static final List<Dlc> _dlcs = [];
  static final List<Fur> _furs = [];
  static final List<Reserve> _reserves = [];
  static final List<Weapon> _weapons = [];
  static final List<WeaponAmmo> _weaponsAmmo = [];
  static final List<Mission> _missions = [];
  static final List<Giver> _missionsGivers = [];

  static void setLists(
    List<Ammo> ammo,
    List<Animal> animals,
    List<IdtoId> animalsCallers,
    List<AnimalFur> animalsFurs,
    List<IdtoId> animalsReserves,
    List<Zone> animalsZones,
    List<Caller> callers,
    List<Dlc> dlcs,
    List<Fur> furs,
    List<Reserve> reserves,
    List<Weapon> weapons,
    List<WeaponAmmo> weaponsAmmo,
    List<Mission> missions,
    List<Giver> missionsGivers,
  ) {
    _logger.i("Initializing lists in HelperJSON...");
    _clearLists();
    _ammo.addAll(ammo);
    _animals.addAll(animals);
    _animalsCallers.addAll(animalsCallers);
    _animalsFurs.addAll(animalsFurs);
    _animalsReserves.addAll(animalsReserves);
    _animalsZones.addAll(animalsZones);
    _callers.addAll(callers);
    _dlcs.addAll(dlcs);
    _furs.addAll(furs);
    _reserves.addAll(reserves);
    _weapons.addAll(weapons);
    _weaponsAmmo.addAll(weaponsAmmo);
    _missions.addAll(missions);
    _missionsGivers.addAll(missionsGivers);
    initializeWeaponAmmo();
    _logger.t("Lists initialized");
  }

  static void _clearLists() {
    _ammo.clear();
    _animals.clear();
    _animalsCallers.clear();
    _animalsFurs.clear();
    _animalsReserves.clear();
    _animalsZones.clear();
    _callers.clear();
    _dlcs.clear();
    _furs.clear();
    _reserves.clear();
    _weapons.clear();
    _weaponsAmmo.clear();
    _missions.clear();
    _missionsGivers.clear();
  }

  static Reserve getReserve(int id) => _reserves.elementAt(id - 1);

  static Animal getAnimal(int id) => _animals.elementAt(id - 1);

  static Caller getCaller(int id) => _callers.elementAt(id - 1);

  static Weapon getWeapon(int id) => _weapons.elementAt(id - 1);

  static Ammo getAmmo(int id) => _ammo.elementAt(id - 1);

  static IdtoId getWeaponsAmmo(int id) => _weaponsAmmo.elementAt(id - 1);

  static Fur getFur(int id) {
    if (id == Values.greatOneId) return _furs.last;
    return _furs.elementAt(id - 1);
  }

  static List<Zone> getAnimalZones(int animalId, int reserveId) {
    List<Zone> zones = [];
    for (Zone zone in _animalsZones) {
      if (zone.animalId == animalId && zone.reserveId == reserveId) zones.add(zone);
    }
    return zones;
  }

  static AnimalFur getAnimalFur(int animalId, int furId) {
    for (AnimalFur animalFur in _animalsFurs) {
      if (animalId == animalFur.animalId && furId == animalFur.furId) return animalFur;
    }
    return _animalsFurs.elementAt(1);
  }

  static Mission getMission(int id) => _missions.elementAt(id - 1);

  static Giver getMissionGiver(int id) => _missionsGivers.elementAt(id - 1);

  static List<Ammo> get ammo => _ammo;

  static List<Animal> get animals => _animals;

  static List<IdtoId> get animalsCallers => _animalsCallers;

  static List<AnimalFur> get animalsFurs => _animalsFurs;

  static List<IdtoId> get animalsReserves => _animalsReserves;

  static List<Zone> get animalsZones => _animalsZones;

  static List<Caller> get callers => _callers;

  static List<Dlc> get dlcs => _dlcs;

  static List<Fur> get furs => _furs;

  static List<Reserve> get reserves => _reserves;

  static List<Weapon> get weapons => _weapons;

  static List<WeaponAmmo> get weaponsAmmo => _weaponsAmmo;

  static List<Mission> get missions => _missions;

  static List<Giver> get missionsGivers => _missionsGivers;

  static Future<String> getData(String name) async {
    final String content;
    content = await root_bundle.rootBundle.loadString("assets/raw/$name.json");
    return content;
  }

  static Future<List<Ammo>> readAmmo() async {
    try {
      final data = await getData("ammo");
      final list = json.decode(data) as List<dynamic>;
      final List<Ammo> ammo = list.map((e) => Ammo.fromJson(e)).toList();
      _logger.t("${ammo.length} ammo loaded");
      return ammo;
    } catch (e) {
      _logger.w("Ammo not loaded");
      rethrow;
    }
  }

  static Future<List<Animal>> readAnimals() async {
    try {
      final data = await getData("animals");
      final list = json.decode(data) as List<dynamic>;
      final List<Animal> animals = list.map((e) => Animal.fromJson(e)).toList();
      _logger.t("${animals.length} animals loaded");
      return animals;
    } catch (e) {
      _logger.w("Animals not loaded");
      rethrow;
    }
  }

  static Future<List<IdtoId>> readAnimalsCallers() async {
    try {
      final data = await getData("animalscallers");
      final list = json.decode(data) as List<dynamic>;
      final List<IdtoId> animalsCallers = list.map((e) => IdtoId.fromJson(e, "ANIMAL_ID", "CALLER_ID")).toList();
      _logger.t("${list.length} animal's callers loaded");
      return animalsCallers;
    } catch (e) {
      _logger.w("Animal's callers not loaded");
      rethrow;
    }
  }

  static Future<List<AnimalFur>> readAnimalsFurs() async {
    try {
      final data = await getData("animalsfurs");
      final list = json.decode(data) as List<dynamic>;
      final List<AnimalFur> animalsFurs = list.map((e) => AnimalFur.fromJson(e)).toList();
      _logger.t("${animalsFurs.length} animal's furs loaded");
      return animalsFurs;
    } catch (e) {
      _logger.w("Animal's furs not loaded");
      rethrow;
    }
  }

  static Future<List<IdtoId>> readAnimalsReserves() async {
    try {
      final data = await getData("animalsreserves");
      final list = json.decode(data) as List<dynamic>;
      final List<IdtoId> animalsReserves = list.map((e) => IdtoId.fromJson(e, "ANIMAL_ID", "RESERVE_ID")).toList();
      _logger.t("${animalsReserves.length} animal's reserves loaded");
      return animalsReserves;
    } catch (e) {
      _logger.w("Animal's reserves not loaded");
      rethrow;
    }
  }

  static Future<List<Zone>> readAnimalsZones() async {
    try {
      final data = await getData("animalszones");
      final list = json.decode(data) as List<dynamic>;
      final List<Zone> animalsZones = list.map((e) => Zone.fromJson(e)).toList();
      _logger.t("${animalsZones.length} animal's zones loaded");
      return animalsZones;
    } catch (e) {
      _logger.w("Animal's zones not loaded");
      rethrow;
    }
  }

  static Future<List<Caller>> readCallers() async {
    try {
      final data = await getData("callers");
      final list = json.decode(data) as List<dynamic>;
      final List<Caller> callers = list.map((e) => Caller.fromJson(e)).toList();
      _logger.t("${callers.length} callers loaded");
      return callers;
    } catch (e) {
      _logger.w("Callers not loaded");
      rethrow;
    }
  }

  static Future<List<Dlc>> readDlcs() async {
    try {
      final data = await getData("dlcs");
      final list = json.decode(data) as List<dynamic>;
      final List<Dlc> dlcs = list.map((e) => Dlc.fromJson(e)).toList();
      _logger.t("${dlcs.length} dlcs loaded");
      return dlcs;
    } catch (e) {
      _logger.w("Dlcs not loaded");
      rethrow;
    }
  }

  static Future<List<Fur>> readFurs() async {
    try {
      final data = await getData("furs");
      final list = json.decode(data) as List<dynamic>;
      final List<Fur> furs = list.map((e) => Fur.fromJson(e)).toList();
      _logger.t("${furs.length} furs loaded");
      return furs;
    } catch (e) {
      _logger.w("Furs not loaded");
      rethrow;
    }
  }

  static Future<List<Reserve>> readReserves() async {
    try {
      final data = await getData("reserves");
      final list = json.decode(data) as List<dynamic>;
      final List<Reserve> reserves = list.map((e) => Reserve.fromJson(e)).toList();
      _logger.t("${reserves.length} reserves loaded");
      return reserves;
    } catch (e) {
      _logger.w("Reserves not loaded");
      rethrow;
    }
  }

  static Future<List<Weapon>> readWeapons() async {
    try {
      final data = await getData("weapons");
      final list = json.decode(data) as List<dynamic>;
      final List<Weapon> weapons = list.map((e) => Weapon.fromJson(e)).toList();
      _logger.t("${weapons.length} weapons loaded");
      return weapons;
    } catch (e) {
      _logger.w("Weapons not loaded");
      rethrow;
    }
  }

  static Future<List<WeaponAmmo>> readWeaponsAmmo() async {
    try {
      final data = await getData("weaponsammo");
      final list = json.decode(data) as List<dynamic>;
      final List<WeaponAmmo> weaponsAmmo = list.map((e) => WeaponAmmo.fromJson(e, "WEAPON_ID", "AMMO_ID")).toList();
      _logger.t("${weaponsAmmo.length} weapon's ammo loaded");
      return weaponsAmmo;
    } catch (e) {
      _logger.w("Weapon's ammo not loaded");
      rethrow;
    }
  }

  static Future<List<Mission>> readMissions() async {
    try {
      final data = await getData("missions");
      final list = json.decode(data) as List<dynamic>;
      final List<Mission> missions = list.map((e) => Mission.fromJson(e)).toList();
      _logger.t("${missions.length} missions loaded");
      return missions;
    } catch (e) {
      _logger.w("Missions not loaded");
      rethrow;
    }
  }

  static Future<List<Giver>> readMissionsGivers() async {
    try {
      final data = await getData("missionsgivers");
      final list = json.decode(data) as List<dynamic>;
      final List<Giver> missionsGivers = list.map((e) => Giver.fromJson(e)).toList();
      _logger.t("${missionsGivers.length} mission's givers loaded");
      return missionsGivers;
    } catch (e) {
      _logger.w("Mission's givers not loaded");
      rethrow;
    }
  }

  static void initializeWeaponAmmo() {
    final List<int> ammo = [];
    for (Weapon weapon in _weapons) {
      ammo.clear();
      for (IdtoId iti in _weaponsAmmo) {
        if (weapon.id == iti.firstId) {
          ammo.add(iti.secondId);
        }
      }
      weapon.setAmmo = ammo;
    }
  }

  static String listToJson(List<dynamic> list) {
    String parsed = "[";
    for (int index = 0; index < list.length; index++) {
      parsed += list.elementAt(index).toString();
      if (index != list.length - 1) {
        parsed += ",";
      }
    }
    parsed += "]";
    return parsed;
  }

  static Future<String> fileToJson(File file) async {
    try {
      final String contents;
      await file.exists() ? contents = await file.readAsString() : contents = "[]";
      if (contents.startsWith("[") && contents.endsWith("]")) return contents;
      return "[]";
    } catch (e) {
      return e.toString();
    }
  }
}
