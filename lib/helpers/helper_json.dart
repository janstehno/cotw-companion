// Copyright (c) 2022 Jan Stehno

import 'dart:convert';

import 'package:cotwcompanion/thehunter/model/ammo.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/model/animal_fur.dart';
import 'package:cotwcompanion/thehunter/model/caller.dart';
import 'package:cotwcompanion/thehunter/model/dlc.dart';
import 'package:cotwcompanion/thehunter/model/fur.dart';
import 'package:cotwcompanion/thehunter/model/idtoid.dart';
import 'package:cotwcompanion/thehunter/model/reserve.dart';
import 'package:cotwcompanion/thehunter/model/weapon.dart';
import 'package:cotwcompanion/thehunter/model/zone.dart';
import 'package:flutter/services.dart' as root_bundle;

class JSONHelper {
  static final List<Ammo> _ammo = [];
  static final List<Animal> _animals = [];
  static final List<IDtoID> _animalsCallers = [];
  static final List<AnimalFur> _animalsFurs = [];
  static final List<IDtoID> _animalsReserves = [];
  static final List<Zone> _animalsZones = [];
  static final List<Caller> _callers = [];
  static final List<Dlc> _dlcs = [];
  static final List<Fur> _furs = [];
  static final List<Reserve> _reserves = [];
  static final List<Weapon> _weapons = [];
  static final List<IDtoID> _weaponsAmmo = [];
  static final List<Weapon> _weaponsInfo = [];

  static setLists(List<Ammo> ammo, List<Animal> animals, List<IDtoID> animalsCallers, List<AnimalFur> animalsFurs, List<IDtoID> animalsReserves, List<Zone> animalsZones,
      List<Caller> callers, List<Dlc> dlcs, List<Fur> furs, List<Reserve> reserves, List<Weapon> weapons, List<IDtoID> weaponsAmmo, List<Weapon> weaponsInfo) {
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
    _weaponsInfo.clear();
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
    _weaponsInfo.addAll(weaponsInfo);
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

  static Fur getFur(int id) {
    return _furs.elementAt(id - 1);
  }

  static AnimalFur getAnimalFur(int id) {
    return _animalsFurs.elementAt(id - 1);
  }

  static List<Ammo> get ammo => _ammo;

  static List<Animal> get animals => _animals;

  static List<IDtoID> get animalsCallers => _animalsCallers;

  static List<AnimalFur> get animalsFurs => _animalsFurs;

  static List<IDtoID> get animalsReserves => _animalsReserves;

  static List<Zone> get animalsZones => _animalsZones;

  static List<Caller> get callers => _callers;

  static List<Dlc> get dlcs => _dlcs;

  static List<Fur> get furs => _furs;

  static List<Reserve> get reserves => _reserves;

  static List<Weapon> get weapons => _weapons;

  static List<IDtoID> get weaponsAmmo => _weaponsAmmo;

  static List<Weapon> get weaponsInfo => _weaponsInfo;

  static _getData(String name) async {
    final String content;
    content = await root_bundle.rootBundle.loadString('assets/raw/$name.json');
    return content;
  }

  static Future<List<Ammo>> readAmmo() async {
    final data = await _getData('ammo');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Ammo.fromJson(e)).toList();
  }

  static Future<List<Animal>> readAnimals() async {
    final data = await _getData('animals');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Animal.fromJson(e)).toList();
  }

  static Future<List<IDtoID>> readAnimalsCallers() async {
    final data = await _getData('animalscallers');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => IDtoID.fromJson(e, "ANIMAL_ID", "CALLER_ID")).toList();
  }

  static Future<List<AnimalFur>> readAnimalsFurs() async {
    final data = await _getData('animalsfurs');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => AnimalFur.fromJson(e)).toList();
  }

  static Future<List<IDtoID>> readAnimalsReserves() async {
    final data = await _getData('animalsreserves');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => IDtoID.fromJson(e, "ANIMAL_ID", "RESERVE_ID")).toList();
  }

  static Future<List<Zone>> readAnimalsZones() async {
    final data = await _getData('animalszones');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Zone.fromJson(e)).toList();
  }

  static Future<List<Caller>> readCallers() async {
    final data = await _getData('callers');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Caller.fromJson(e)).toList();
  }

  static Future<List<Dlc>> readDlcs() async {
    final data = await _getData('dlcs');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Dlc.fromJson(e)).toList();
  }

  static Future<List<Fur>> readFurs() async {
    final data = await _getData('furs');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Fur.fromJson(e)).toList();
  }

  static Future<List<Reserve>> readReserves() async {
    final data = await _getData('reserves');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Reserve.fromJson(e)).toList();
  }

  static Future<List<Weapon>> readWeapons() async {
    final data = await _getData('weapons');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Weapon.fromJson(e)).toList();
  }

  static Future<List<IDtoID>> readWeaponsAmmo() async {
    final data = await _getData('weaponsammo');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => IDtoID.fromJson(e, "WEAPON_ID", "AMMO_ID")).toList();
  }

  static Future<List<Weapon>> readWeaponsInfo() async {
    final data = await _getData('weaponsinfo');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Weapon.fromJsonWithAdditionalInfo(e)).toList();
  }

  static String listToJson(List<dynamic> list) {
    String parsed = "[";
    for (int i = 0; i < list.length; i++) {
      parsed += list[i].toString();
      if (i != list.length - 1) {
        parsed += ",";
      }
    }
    parsed += "]";
    return parsed;
  }
}
