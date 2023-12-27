// Copyright (c) 2023 Jan Stehno

import 'dart:convert';
import 'dart:io';

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
import 'package:cotwcompanion/model/multimount.dart';
import 'package:cotwcompanion/model/perk.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/model/skill.dart';
import 'package:cotwcompanion/model/weapon.dart';
import 'package:cotwcompanion/model/weapon_ammo.dart';
import 'package:cotwcompanion/model/zone.dart';
import 'package:flutter/services.dart' as root_bundle;

class HelperJSON {
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
  static final List<Perk> _perks = [];
  static final List<Skill> _skills = [];
  static final List<Multimount> _multimounts = [];
  static final Map<String, dynamic> _mapObjects = {};

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
    Map<String, dynamic> mapObjects,
    List<Mission> missions,
    List<Giver> missionsGivers,
    List<Perk> perks,
    List<Skill> skills,
    List<Multimount> multimounts,
  ) {
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
    _perks.addAll(perks);
    _skills.addAll(skills);
    _multimounts.addAll(multimounts);
    _mapObjects.addAll(mapObjects);
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
    _perks.clear();
    _skills.clear();
    _multimounts.clear();
    _mapObjects.clear();
  }

  static Reserve getReserve(int id) {
    return _reserves.elementAt(id - 1);
  }

  static Animal getAnimal(int id) {
    return _animals.elementAt(id - 1);
  }

  static Caller getCaller(int id) {
    return _callers.elementAt(id - 1);
  }

  static Weapon getWeapon(int id) {
    return _weapons.elementAt(id - 1);
  }

  static Ammo getAmmo(int id) {
    return _ammo.elementAt(id - 1);
  }

  static IdtoId getWeaponsAmmo(int id) {
    return _weaponsAmmo.elementAt(id - 1);
  }

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

  static dynamic getMapObjects(int reserveId) {
    return _mapObjects[reserveId.toString()];
  }

  static Mission getMission(int id) {
    return _missions.elementAt(id - 1);
  }

  static Giver getMissionGiver(int id) {
    return _missionsGivers.elementAt(id - 1);
  }

  static Perk getPerk(int id) {
    return _perks.elementAt(id - 1);
  }

  static Skill getSkill(int id) {
    return _skills.elementAt(id - 1);
  }

  static Multimount getMultimount(int id) {
    return _multimounts.elementAt(id - 1);
  }

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

  static List<Skill> get skills => _skills;

  static List<Perk> get perks => _perks;

  static List<Multimount> get multimounts => _multimounts;

  static Future<String> _getData(String name) async {
    final String content;
    content = await root_bundle.rootBundle.loadString("assets/raw/$name.json");
    return content;
  }

  static Future<List<Ammo>> readAmmo() async {
    final data = await _getData("ammo");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Ammo.fromJson(e)).toList();
  }

  static Future<List<Animal>> readAnimals() async {
    final data = await _getData("animals");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Animal.fromJson(e)).toList();
  }

  static Future<List<IdtoId>> readAnimalsCallers() async {
    final data = await _getData("animalscallers");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => IdtoId.fromJson(e, "ANIMAL_ID", "CALLER_ID")).toList();
  }

  static Future<List<AnimalFur>> readAnimalsFurs() async {
    final data = await _getData("animalsfurs");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => AnimalFur.fromJson(e)).toList();
  }

  static Future<List<IdtoId>> readAnimalsReserves() async {
    final data = await _getData("animalsreserves");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => IdtoId.fromJson(e, "ANIMAL_ID", "RESERVE_ID")).toList();
  }

  static Future<List<Zone>> readAnimalsZones() async {
    final data = await _getData("animalszones");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Zone.fromJson(e)).toList();
  }

  static Future<List<Caller>> readCallers() async {
    final data = await _getData("callers");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Caller.fromJson(e)).toList();
  }

  static Future<List<Dlc>> readDlcs() async {
    final data = await _getData("dlcs");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Dlc.fromJson(e)).toList();
  }

  static Future<List<Fur>> readFurs() async {
    final data = await _getData("furs");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Fur.fromJson(e)).toList();
  }

  static Future<List<Reserve>> readReserves() async {
    final data = await _getData("reserves");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Reserve.fromJson(e)).toList();
  }

  static Future<List<Weapon>> readWeapons() async {
    final data = await _getData("weapons");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Weapon.fromJson(e)).toList();
  }

  static Future<List<WeaponAmmo>> readWeaponsAmmo() async {
    final data = await _getData("weaponsammo");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => WeaponAmmo.fromJson(e, "WEAPON_ID", "AMMO_ID")).toList();
  }

  static Future<Map<String, dynamic>> readMapObjects() async {
    final data = await _getData("mapobjects");
    Map<String, dynamic> result = Map.castFrom(json.decode(data));
    return result;
  }

  static Future<List<Mission>> readMissions() async {
    final data = await _getData("missions");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Mission.fromJson(e)).toList();
  }

  static Future<List<Giver>> readMissionsGivers() async {
    final data = await _getData("missionsgivers");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Giver.fromJson(e)).toList();
  }

  static Future<List<Perk>> readPerks() async {
    final data = await _getData("perks");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Perk.fromJson(e)).toList();
  }

  static Future<List<Skill>> readSkills() async {
    final data = await _getData("skills");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Skill.fromJson(e)).toList();
  }

  static Future<List<Multimount>> readMultimounts() async {
    final data = await _getData("multimounts");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Multimount.fromJson(e)).toList();
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
