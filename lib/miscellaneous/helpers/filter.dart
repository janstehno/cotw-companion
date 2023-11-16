// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:collection/collection.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/helpers/log.dart';
import 'package:cotwcompanion/miscellaneous/multi_sort.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/model/fur.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/model/loadout.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/model/weapon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HelperFilter {
  static const Map<FilterKey, dynamic> _defaultFilters = {
    FilterKey.reservesCountMin: 8,
    FilterKey.reservesCountMax: 19,
    FilterKey.animalsClass: {1: true, 2: true, 3: true, 4: true, 5: true, 6: true, 7: true, 8: true, 9: true},
    FilterKey.animalsDifficulty: {3: true, 5: true, 9: true},
    FilterKey.weaponsAnimalClass: 0,
    FilterKey.weaponsClassMin: 1,
    FilterKey.weaponsClassMax: 9,
    FilterKey.weaponsMagMin: 1,
    FilterKey.weaponsMagMax: 15,
    FilterKey.weaponsRifles: true,
    FilterKey.weaponsShotguns: true,
    FilterKey.weaponsHandguns: true,
    FilterKey.weaponsBows: true,
    FilterKey.callersEffectiveRange: {150: true, 200: true, 250: true, 500: true},
    FilterKey.logsGender: {1: true, 0: true},
    FilterKey.logsTrophyRating: {0: true, 1: true, 2: true, 3: true, 4: true, 5: true},
    FilterKey.logsFurRarity: {0: true, 1: true, 2: true, 3: true, 4: true, 5: true},
    FilterKey.logsTrophyScoreMin: 0.0,
    FilterKey.logsTrophyScoreMax: 9999.999,
    FilterKey.logsSort: {
      1: {"order": 0, "active": false, "ascended": true, "key": ""},
      2: {"order": 0, "active": false, "ascended": true, "key": ""},
      3: {"order": 0, "active": false, "ascended": true, "key": ""},
      4: {"order": 0, "active": false, "ascended": true, "key": ""},
      5: {"order": 0, "active": false, "ascended": true, "key": ""},
      6: {"order": 0, "active": false, "ascended": true, "key": ""},
    },
    FilterKey.loadoutsAmmoMin: 1,
    FilterKey.loadoutsAmmoMax: 120,
    FilterKey.loadoutsCallersMin: 1,
    FilterKey.loadoutsCallersMax: 30,
  };
  static Map<FilterKey, dynamic> _filters = {};

  static void initializeFilters() {
    _filters = {
      FilterKey.reservesCountMin: 8,
      FilterKey.reservesCountMax: 19,
      FilterKey.animalsClass: {1: true, 2: true, 3: true, 4: true, 5: true, 6: true, 7: true, 8: true, 9: true},
      FilterKey.animalsDifficulty: {3: true, 5: true, 9: true},
      FilterKey.weaponsAnimalClass: 0,
      FilterKey.weaponsClassMin: 1,
      FilterKey.weaponsClassMax: 9,
      FilterKey.weaponsMagMin: 1,
      FilterKey.weaponsMagMax: 15,
      FilterKey.weaponsRifles: true,
      FilterKey.weaponsShotguns: true,
      FilterKey.weaponsHandguns: true,
      FilterKey.weaponsBows: true,
      FilterKey.callersEffectiveRange: {150: true, 200: true, 250: true, 500: true},
      FilterKey.logsGender: {1: true, 0: true},
      FilterKey.logsTrophyRating: {0: true, 1: true, 2: true, 3: true, 4: true, 5: true},
      FilterKey.logsFurRarity: {0: true, 1: true, 2: true, 3: true, 4: true, 5: true},
      FilterKey.logsTrophyScoreMin: 0.0,
      FilterKey.logsTrophyScoreMax: 9999.999,
      FilterKey.logsSort: {
        1: {"order": 0, "active": false, "ascended": true, "key": ""},
        2: {"order": 0, "active": false, "ascended": true, "key": ""},
        3: {"order": 0, "active": false, "ascended": true, "key": ""},
        4: {"order": 0, "active": false, "ascended": true, "key": ""},
        5: {"order": 0, "active": false, "ascended": true, "key": ""},
        6: {"order": 0, "active": false, "ascended": true, "key": ""},
      },
      FilterKey.loadoutsAmmoMin: 1,
      FilterKey.loadoutsAmmoMax: 120,
      FilterKey.loadoutsCallersMin: 1,
      FilterKey.loadoutsCallersMax: 30,
    };
  }

  static bool reserveFiltersChanged() {
    return !(_defaultFilters[FilterKey.reservesCountMin] == _filters[FilterKey.reservesCountMin] &&
        _defaultFilters[FilterKey.reservesCountMax] == _filters[FilterKey.reservesCountMax]);
  }

  static bool animalFiltersChanged() {
    return !(const DeepCollectionEquality().equals(_defaultFilters[FilterKey.animalsClass], _filters[FilterKey.animalsClass]) &&
        const DeepCollectionEquality().equals(_defaultFilters[FilterKey.animalsDifficulty], _filters[FilterKey.animalsDifficulty]));
  }

  static bool weaponFiltersChanged() {
    return !(_defaultFilters[FilterKey.weaponsRifles] == _filters[FilterKey.weaponsRifles] &&
        _defaultFilters[FilterKey.weaponsShotguns] == _filters[FilterKey.weaponsShotguns] &&
        _defaultFilters[FilterKey.weaponsHandguns] == _filters[FilterKey.weaponsHandguns] &&
        _defaultFilters[FilterKey.weaponsBows] == _filters[FilterKey.weaponsBows] &&
        _defaultFilters[FilterKey.weaponsMagMin] == _filters[FilterKey.weaponsMagMin] &&
        _defaultFilters[FilterKey.weaponsMagMax] == _filters[FilterKey.weaponsMagMax] &&
        _defaultFilters[FilterKey.weaponsClassMin] == _filters[FilterKey.weaponsClassMin] &&
        _defaultFilters[FilterKey.weaponsClassMax] == _filters[FilterKey.weaponsClassMax] &&
        const DeepCollectionEquality().equals(_defaultFilters[FilterKey.weaponsAnimalClass], _filters[FilterKey.weaponsAnimalClass]));
  }

  static bool callerFiltersChanged() {
    return !(const DeepCollectionEquality().equals(_defaultFilters[FilterKey.callersEffectiveRange], _filters[FilterKey.callersEffectiveRange]));
  }

  static bool logFiltersChanged() {
    return !(const DeepCollectionEquality().equals(_defaultFilters[FilterKey.logsGender], _filters[FilterKey.logsGender]) &&
        const DeepCollectionEquality().equals(_defaultFilters[FilterKey.logsFurRarity], _filters[FilterKey.logsFurRarity]) &&
        const DeepCollectionEquality().equals(_defaultFilters[FilterKey.logsTrophyRating], _filters[FilterKey.logsTrophyRating]) &&
        _defaultFilters[FilterKey.logsTrophyScoreMin] == _filters[FilterKey.logsTrophyScoreMin] &&
        _defaultFilters[FilterKey.logsTrophyScoreMax] == _filters[FilterKey.logsTrophyScoreMax] &&
        const DeepCollectionEquality().equals(_defaultFilters[FilterKey.logsSort], _filters[FilterKey.logsSort]));
  }

  static bool loadoutFiltersChanged() {
    return !(_defaultFilters[FilterKey.loadoutsAmmoMin] == _filters[FilterKey.loadoutsAmmoMin] &&
        _defaultFilters[FilterKey.loadoutsAmmoMax] == _filters[FilterKey.loadoutsAmmoMax] &&
        _defaultFilters[FilterKey.loadoutsCallersMin] == _filters[FilterKey.loadoutsCallersMin] &&
        _defaultFilters[FilterKey.loadoutsCallersMax] == _filters[FilterKey.loadoutsCallersMax]);
  }

  static num getDefaultValue(FilterKey filterKey) {
    return _defaultFilters[filterKey];
  }

  static List<int> getDefaultListKeys(FilterKey filterKey) {
    return _defaultFilters[filterKey].keys.toList();
  }

  static dynamic getSortValue(FilterKey filterKey, int listKey, String key) {
    return _filters[filterKey][listKey][key];
  }

  static bool getBoolValueList(FilterKey filterKey, int listKey) {
    return _filters[filterKey][listKey];
  }

  static bool getBoolValue(FilterKey filterKey) {
    return _filters[filterKey];
  }

  static int getIntValue(FilterKey filterKey) {
    return _filters[filterKey];
  }

  static double getDoubleValue(FilterKey filterKey) {
    return _filters[filterKey];
  }

  static int anySortActive(FilterKey filterKey) {
    int active = 0;
    _filters[filterKey].forEach((key, value) {
      value.forEach((key, value) {
        if (key == "order" && value > 0) active++;
      });
    });
    return active;
  }

  static void useSort(FilterKey filterKey, int listKey, bool ascended, String key) {
    if (_filters[filterKey][listKey]["active"]) {
      _filters[filterKey][listKey].update("ascended", (v) => !v);
    } else {
      _filters[filterKey][listKey].update("order", (v) => anySortActive(filterKey) + 1);
      _filters[filterKey][listKey].update("active", (v) => true);
      _filters[filterKey][listKey].update("ascended", (v) => ascended);
      _filters[filterKey][listKey].update("key", (v) => key);
    }
  }

  static void resetSort(FilterKey filterKey) {
    for (int key in _filters[filterKey].keys) {
      _filters[filterKey][key].update("order", (v) => 0);
      _filters[filterKey][key].update("active", (v) => false);
      _filters[filterKey][key].update("ascended", (v) => true);
      _filters[filterKey][key].update("key", (v) => "");
    }
  }

  static List<bool> getSortCriteria(FilterKey filterKey) {
    List<bool> criteria = [];
    for (int i = 1; i <= _filters[filterKey].length; i++) {
      _filters[filterKey].forEach((key, value) => {if (value["order"] == i) criteria.add(value["ascended"])});
    }
    return criteria;
  }

  static List<String> getSortPreferences(FilterKey filterKey) {
    List<String> preferences = [];
    for (int i = 1; i <= _filters[filterKey].length; i++) {
      _filters[filterKey].forEach((key, value) => {if (value["order"] == i) preferences.add(value["key"])});
    }
    return preferences;
  }

  static void switchListValue(FilterKey filterKey, int listKey) {
    _filters[filterKey].update(listKey, (v) => !v);
  }

  static void switchValue(FilterKey filterKey) {
    _filters.update(filterKey, (v) => !v);
  }

  static void changeBoolValue(FilterKey filterKey, bool value) {
    _filters.update(filterKey, (v) => value);
  }

  static void changeIntValue(FilterKey filterKey, int value) {
    _filters.update(filterKey, (v) => value);
  }

  static void changeDoubleValue(FilterKey filterKey, double value) {
    _filters.update(filterKey, (v) => value);
  }

  static List<Reserve> filterReserves(String searchText, BuildContext context) {
    List<Reserve> reserves = [];
    reserves.addAll(HelperJSON.reserves);
    reserves = reserves
        .where((reserve) =>
            (searchText.isNotEmpty ? reserve.getName(context.locale).toLowerCase().contains(searchText.toLowerCase()) : true) &&
            reserve.count >= getIntValue(FilterKey.reservesCountMin) &&
            reserve.count <= getIntValue(FilterKey.reservesCountMax))
        .toList();
    reserves.sort((a, b) => a.id.compareTo(b.id));
    return reserves;
  }

  static List<Animal> filterAnimals(String searchText, BuildContext context) {
    List<Animal> animals = [];
    animals.addAll(HelperJSON.animals);
    animals = animals
        .where((animal) =>
            (searchText.isNotEmpty ? animal.getName(context.locale).toLowerCase().replaceFirst("&", "").contains(searchText.toLowerCase()) : true) &&
            getBoolValueList(FilterKey.animalsClass, animal.level) &&
            getBoolValueList(FilterKey.animalsDifficulty, animal.difficulty))
        .toList();
    animals.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
    return animals;
  }

  static List<Fur> filterFurs(String searchText, BuildContext context) {
    List<Fur> animalFurs = [];
    animalFurs.addAll(HelperJSON.furs);
    animalFurs = animalFurs.where((fur) => (searchText.isNotEmpty ? fur.getName(context.locale).toLowerCase().contains(searchText.toLowerCase()) : true)).toList();
    return animalFurs;
  }

  static List<Weapon> filterWeapons(String searchText, BuildContext context) {
    List<Weapon> weapons = [];
    weapons.addAll(HelperJSON.weapons);
    weapons = weapons
        .where((weapon) =>
            (searchText.isNotEmpty ? weapon.getName(context.locale).toLowerCase().contains(searchText.toLowerCase()) : true) &&
            (getIntValue(FilterKey.weaponsAnimalClass) != 0
                ? (weapon.min <= getIntValue(FilterKey.weaponsAnimalClass) && weapon.max >= getIntValue(FilterKey.weaponsAnimalClass))
                : true) &&
            weapon.min >= getIntValue(FilterKey.weaponsClassMin) &&
            weapon.max <= getIntValue(FilterKey.weaponsClassMax) &&
            weapon.mag >= getIntValue(FilterKey.weaponsMagMin) &&
            weapon.mag <= getIntValue(FilterKey.weaponsMagMax) &&
            getBoolValue(weapon.typeToFilterKey()))
        .toList();
    for (Weapon weapon in weapons) {
      weapon.setName(context.locale);
    }
    weapons.multiSort([true, true], ["TYPE", "NAME"]);
    return weapons;
  }

  static List<Ammo> filterAmmo(String searchText, BuildContext context) {
    List<Ammo> ammo = [];
    ammo.addAll(HelperJSON.ammo);
    ammo = ammo.where((ammo) => (searchText.isNotEmpty ? ammo.getName(context.locale).toLowerCase().contains(searchText.toLowerCase()) : true)).toList();
    return ammo;
  }

  static List<Caller> filterCallers(String searchText, BuildContext context) {
    List<Caller> callers = [];
    callers.addAll(HelperJSON.callers);
    callers = callers
        .where((caller) =>
            (searchText.isNotEmpty ? caller.getName(context.locale).toLowerCase().contains(searchText.toLowerCase()) : true) &&
            getBoolValueList(FilterKey.callersEffectiveRange, caller.rangeM))
        .toList();
    callers.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
    return callers;
  }

  static List<Log> filterLogs(String searchText, BuildContext context) {
    List<Log> logs = [];
    logs.addAll(HelperLog.logs);
    if (searchText.isNotEmpty) {
      for (Log log in HelperLog.logs) {
        bool add = false;
        for (String search in searchText.split("|")) {
          if (search.isNotEmpty && log.animalName.toLowerCase().contains(search.toLowerCase())) {
            add = true;
            break;
          }
        }
        if (!add) logs.remove(log);
      }
    }
    logs = logs
        .where((log) =>
            getBoolValueList(FilterKey.logsGender, log.gender) &&
            getBoolValueList(FilterKey.logsTrophyRating, log.trophyRatingWithGO) &&
            getBoolValueList(FilterKey.logsFurRarity, log.fur.rarity) &&
            log.trophy >= getDoubleValue(FilterKey.logsTrophyScoreMin) &&
            log.trophy <= getDoubleValue(FilterKey.logsTrophyScoreMax))
        .toList();
    logs.sort((a, b) => b.dateForCompare.compareTo(a.dateForCompare));
    logs.multiSort(getSortCriteria(FilterKey.logsSort), getSortPreferences(FilterKey.logsSort));
    return logs;
  }

  static List<Loadout> filterLoadouts(String searchText, BuildContext context) {
    List<Loadout> loadouts = [];
    loadouts.addAll(HelperLoadout.loadouts);
    loadouts = loadouts
        .where((loadout) =>
            (searchText.isNotEmpty ? loadout.name.toLowerCase().contains(searchText.toLowerCase()) : true) &&
            (loadout.ammo.isNotEmpty
                ? (loadout.ammo.length >= getIntValue(FilterKey.loadoutsAmmoMin) && loadout.ammo.length <= getIntValue(FilterKey.loadoutsAmmoMax))
                : true) &&
            (loadout.callers.isNotEmpty
                ? (loadout.callers.length >= getIntValue(FilterKey.loadoutsCallersMin) && loadout.callers.length <= getIntValue(FilterKey.loadoutsCallersMax))
                : true))
        .toList();
    return loadouts;
  }

  static List<int> filterLoadoutAmmo(String searchText, BuildContext context) {
    List<int> weaponAmmo = [];
    for (IdtoId iti in HelperJSON.weaponsAmmo) {
      if (HelperJSON.getWeapon(iti.firstId).getName(context.locale).toLowerCase().contains(searchText.toLowerCase()) ||
          HelperJSON.getAmmo(iti.secondId).getName(context.locale).toLowerCase().contains(searchText.toLowerCase())) {
        weaponAmmo.add(iti.id);
      }
    }
    return weaponAmmo;
  }

  static List<int> filterLoadoutCallers(String searchText, BuildContext context) {
    List<int> callers = [];
    for (Caller caller in HelperJSON.callers) {
      if (caller.getName(context.locale).toLowerCase().contains(searchText.toLowerCase())) {
        callers.add(caller.id);
      }
    }
    return callers;
  }
}
