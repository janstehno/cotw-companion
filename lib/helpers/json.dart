import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/logger.dart';
import 'package:cotwcompanion/model/connect/animal_fur.dart';
import 'package:cotwcompanion/model/connect/animal_fur_image.dart';
import 'package:cotwcompanion/model/connect/animal_zone.dart';
import 'package:cotwcompanion/model/connect/weapon_ammo.dart';
import 'package:cotwcompanion/model/describable/dlc.dart';
import 'package:cotwcompanion/model/describable/mission.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:cotwcompanion/model/translatable/fur.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:flutter/services.dart' as root_bundle;

class HelperJSON {
  static final HelperLogger _logger = HelperLogger.loadingApp();

  static final List<Ammo> ammo = [];
  static final List<Animal> animals = [];
  static final List<AnimalFur> animalsFurs = [];
  static final List<AnimalFurImage> animalsFursImages = [];
  static final List<AnimalZone> animalsZones = [];
  static final List<Caller> callers = [];
  static final List<Dlc> dlcs = [];
  static final List<Fur> furs = [];
  static final List<Reserve> reserves = [];
  static final List<Weapon> weapons = [];
  static final List<WeaponAmmo> weaponsAmmo = [];
  static final List<Mission> missions = [];

  static void setLists(
    List<Ammo> sAmmo,
    List<Animal> sAnimals,
    List<AnimalFur> sAnimalsFurs,
    List<AnimalFurImage> sAnimalsFursImages,
    List<AnimalZone> sAnimalsZones,
    List<Caller> sCallers,
    List<Dlc> sDlcs,
    List<Fur> sFurs,
    List<Reserve> sReserves,
    List<Weapon> sWeapons,
    List<WeaponAmmo> sWeaponsAmmo,
    List<Mission> sMissions,
  ) {
    _logger.i("Initializing sets in HelperJSON...");
    _clearLists();
    ammo.addAll(sAmmo);
    animals.addAll(sAnimals);
    animalsFurs.addAll(sAnimalsFurs);
    animalsFursImages.addAll(sAnimalsFursImages);
    animalsZones.addAll(sAnimalsZones);
    callers.addAll(sCallers);
    dlcs.addAll(sDlcs);
    furs.addAll(sFurs);
    reserves.addAll(sReserves);
    weapons.addAll(sWeapons);
    weaponsAmmo.addAll(sWeaponsAmmo);
    missions.addAll(sMissions);
    _logger.t("Sets initialized");
  }

  static void _clearLists() {
    ammo.clear();
    animals.clear();
    animalsFurs.clear();
    animalsFursImages.clear();
    animalsZones.clear();
    callers.clear();
    dlcs.clear();
    furs.clear();
    reserves.clear();
    weapons.clear();
    weaponsAmmo.clear();
    missions.clear();
  }

  static Ammo? getAmmo(int ammoId) {
    try {
      return ammo.firstWhereOrNull((e) => e.id == ammoId);
    } catch (e) {
      throw Exception("Ammo with ID: $ammoId does not exist");
    }
  }

  static List<Weapon> getAmmoWeapons(int ammoId) {
    return weapons.where((weapon) {
      return weaponsAmmo.where((weaponAmmo) {
        return weaponAmmo.ammoId == ammoId && weaponAmmo.weaponId == weapon.id;
      }).isNotEmpty;
    }).toList();
  }

  static Animal? getAnimal(int animalId) {
    try {
      return animals.firstWhereOrNull((e) => e.id == animalId);
    } catch (e) {
      throw Exception("Animal with ID: $animalId does not exist");
    }
  }

  static List<Caller> getAnimalCallers(Animal animal) {
    return animal.callers.map((caller) => getCaller(caller)).whereType<Caller>().toList();
  }

  static List<AnimalFur> getAnimalFurs(int animalId) {
    return animalsFurs.where((e) => e.animalId == animalId).toList();
  }

  static List<AnimalFur> getAnimalFursWithGender(int animalId, bool male, bool female) {
    return animalsFurs.where((animalFur) {
      return animalFur.animalId == animalId && (animalFur.male == male || animalFur.female == female);
    }).toList();
  }

  static List<AnimalFur> getAnimalFursWithRarity(int furId, FurRarity rarity) {
    return animalsFurs.where((e) => e.furId == furId && e.rarity == rarity).toList();
  }

  static List<Reserve> getAnimalReserves(Animal animal) {
    return animal.reserves.map((reserve) => getReserve(reserve)).whereType<Reserve>().toList();
  }

  static List<AnimalZone> getAnimalZones(int animalId, int reserveId) {
    List<AnimalZone> animalZones = animalsZones.where((animalZone) {
      return animalZone.animalId == animalId && animalZone.reserveId == reserveId;
    }).toList();

    if (animalZones.isEmpty) {
      animalZones.add(AnimalZone(animalId: animalId, reserveId: reserveId, zone: 4, from: 0, to: 24));
    }

    return animalZones;
  }

  static Map<int, List<AnimalZone>> getAnimalZonesFor(Animal animal) {
    Map<int, List<AnimalZone>> allAnimalZones = {};
    List<Reserve> animalReserves = getAnimalReserves(animal);

    animalReserves.map((e) {
      return allAnimalZones.putIfAbsent(e.id, () => getAnimalZones(animal.id, e.id));
    }).toList();

    return allAnimalZones;
  }

  static Caller? getCaller(int callerId) {
    try {
      return callers.firstWhereOrNull((e) => e.id == callerId);
    } catch (e) {
      throw Exception("Caller with ID: $callerId does not exist");
    }
  }

  static List<Animal> getCallerAnimals(int callerId) {
    return animals.where((animal) => animal.callers.contains(callerId)).toList();
  }

  static Dlc? getDlc(int dlcId) {
    try {
      return dlcs.firstWhereOrNull((e) => e.id == dlcId);
    } catch (e) {
      throw Exception("Dlc with ID: $dlcId does not exist");
    }
  }

  static List<Dlc> getDlcs(DlcType type) => dlcs.where((e) => e.type == type).toList();

  static Dlc? getWeaponDlc(int weaponId) => dlcs.firstWhereOrNull((e) => e.weapons.contains(weaponId));

  static Fur? getFur(int furId) {
    try {
      return furs.firstWhereOrNull((e) => e.id == furId);
    } catch (e) {
      throw Exception("Fur with ID: $furId does not exist");
    }
  }

  static AnimalFur? getAnimalFur(int animalFurId) {
    try {
      return animalsFurs.firstWhereOrNull((e) => e.id == animalFurId);
    } catch (e) {
      throw Exception("AnimalFur with ID: $animalFurId does not exist");
    }
  }

  static AnimalFur? getAnimalFurByParameters(int animalId, int furId, bool male, bool female) {
    try {
      return animalsFurs.firstWhereOrNull((animalFur) {
        return animalFur.animalId == animalId &&
            animalFur.furId == furId &&
            ((animalFur.male == animalFur.female) || (animalFur.male == male && animalFur.female == female));
      });
    } catch (e) {
      throw Exception("AnimalFur with animalId: $animalId, furId: $furId, and gender does not exist");
    }
  }

  static List<AnimalFurImage> getAnimalsFursImages(int animalId) =>
      animalsFursImages.where((e) => e.animalId == animalId).toList();

  static Reserve? getReserve(int reserveId) {
    try {
      return reserves.firstWhereOrNull((e) => e.id == reserveId);
    } catch (e) {
      throw Exception("Reserve with ID: $reserveId does not exist");
    }
  }

  static List<Animal> getReserveAnimals(int reserveId) {
    return animals.where((animal) => animal.reserves.contains(reserveId)).toList();
  }

  static Weapon? getWeapon(int weaponId) {
    try {
      return weapons.firstWhereOrNull((e) => e.id == weaponId);
    } catch (e) {
      throw Exception("Weapon with ID: $weaponId does not exist");
    }
  }

  static List<Ammo> getWeaponsAmmo(int weaponId) {
    return ammo.where((ammo) {
      return weaponsAmmo.where((weaponAmmo) {
        return weaponAmmo.weaponId == weaponId && weaponAmmo.ammoId == ammo.id;
      }).isNotEmpty;
    }).toList();
  }

  static WeaponAmmo? getWeaponAmmo(int weaponAmmoId) {
    try {
      return weaponsAmmo.firstWhereOrNull((e) => e.id == weaponAmmoId);
    } catch (e) {
      throw Exception("WeaponAmmo with ID: $weaponAmmoId does not exist");
    }
  }

  static Mission? getMission(int missionId) {
    try {
      return missions.firstWhereOrNull((e) => e.id == missionId);
    } catch (e) {
      throw Exception("Mission with ID: $missionId does not exist");
    }
  }

  static List<Mission> getReserveMissions(int reserveId) => missions.where((e) => e.reserveId == reserveId).toList();

  static Future<String> getData(String name) async {
    final String content;
    content = await root_bundle.rootBundle.loadString(name);
    return content;
  }

  static Future<List<Ammo>> readAmmo() async {
    try {
      final data = await getData(Assets.raw.ammo);
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
      final data = await getData(Assets.raw.animals);
      final list = json.decode(data) as List<dynamic>;
      final List<Animal> animals = list.map((e) => Animal.fromJson(e)).toList();
      _logger.t("${animals.length} animals loaded");
      return animals;
    } catch (e) {
      _logger.w("Animals not loaded");
      rethrow;
    }
  }

  static Future<List<AnimalFur>> readAnimalsFurs() async {
    try {
      final data = await getData(Assets.raw.animalsfurs);
      final list = json.decode(data) as List<dynamic>;
      final List<AnimalFur> animalsFurs = list.map((e) => AnimalFur.fromJson(e)).toList();
      _logger.t("${animalsFurs.length} animal's furs loaded");
      return animalsFurs;
    } catch (e) {
      _logger.w("Animal's furs not loaded");
      rethrow;
    }
  }

  static Future<List<AnimalFurImage>> readAnimalsFursImages() async {
    try {
      final data = await getData(Assets.raw.animalsfursimages);
      final list = json.decode(data) as List<dynamic>;
      final List<AnimalFurImage> animalsFursImages = list.map((e) => AnimalFurImage.fromJson(e)).toList();
      _logger.t("${animalsFursImages.length} animal's fur's images loaded");
      return animalsFursImages;
    } catch (e) {
      _logger.w("Animal's fur's images not loaded");
      rethrow;
    }
  }

  static Future<List<AnimalZone>> readAnimalsZones() async {
    try {
      final data = await getData(Assets.raw.animalszones);
      final list = json.decode(data) as List<dynamic>;
      final List<AnimalZone> animalsZones = list.map((e) => AnimalZone.fromJson(e)).toList();
      _logger.t("${animalsZones.length} animal's zones loaded");
      return animalsZones;
    } catch (e) {
      _logger.w("Animal's zones not loaded");
      rethrow;
    }
  }

  static Future<List<Caller>> readCallers() async {
    try {
      final data = await getData(Assets.raw.callers);
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
      final data = await getData(Assets.raw.dlcs);
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
      final data = await getData(Assets.raw.furs);
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
      final data = await getData(Assets.raw.reserves);
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
      final data = await getData(Assets.raw.weapons);
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
      final data = await getData(Assets.raw.weaponsammo);
      final list = json.decode(data) as List<dynamic>;
      final List<WeaponAmmo> weaponsAmmo = list.map((e) => WeaponAmmo.fromJson(e)).toList();
      _logger.t("${weaponsAmmo.length} weapon's ammo loaded");
      return weaponsAmmo;
    } catch (e) {
      _logger.w("Weapon's ammo not loaded");
      rethrow;
    }
  }

  static Future<List<Mission>> readMissions() async {
    try {
      final data = await getData(Assets.raw.missions);
      final list = json.decode(data) as List<dynamic>;
      final List<Mission> missions = list.map((e) => Mission.fromJson(e)).toList();
      _logger.t("${missions.length} missions loaded");
      return missions;
    } catch (e) {
      _logger.w("Missions not loaded");
      rethrow;
    }
  }

  static String listToJson(List<dynamic> list) {
    String parsed = "[";
    int i = 0;
    for (dynamic item in list) {
      parsed += item.toString();
      if (i != list.length - 1) {
        parsed += ",";
      }
      i++;
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
