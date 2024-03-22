import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/helpers/loadout.dart';
import 'package:cotwcompanion/helpers/log.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/logger.dart';
import 'package:cotwcompanion/miscellaneous/multi_sort.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/model/connect/weapon_ammo.dart';
import 'package:cotwcompanion/model/describable/mission.dart';
import 'package:cotwcompanion/model/exportable/enumerator.dart';
import 'package:cotwcompanion/model/exportable/loadout.dart';
import 'package:cotwcompanion/model/exportable/log.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:cotwcompanion/model/translatable/fur.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HelperFilter {
  static final HelperLogger _logger = HelperLogger.loadingFilter();

  static const Map<FilterKey, dynamic> _defaultFilters = {
    FilterKey.reservesCountMin: 8,
    FilterKey.reservesCountMax: 19,
    FilterKey.animalsClass: {1: true, 2: true, 3: true, 4: true, 5: true, 6: true, 7: true, 8: true, 9: true},
    FilterKey.animalsDifficulty: {3: true, 5: true, 9: true},
    FilterKey.weaponsAnimalClass: {1: true, 2: true, 3: true, 4: true, 5: true, 6: true, 7: true, 8: true, 9: true},
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
    FilterKey.missionType: {0: true, 1: true},
    FilterKey.missionDifficulty: {1: true, 2: true, 3: true, 4: true},
  };
  static Map<FilterKey, dynamic> _filters = {};

  static void initializeFilters() {
    _logger.i("Initializing filters in HelperFilter...");
    _filters = deepCopyFilters(_defaultFilters);
    _logger.t("Filters initialized");
  }

  static Map<K, V> deepCopyFilters<K, V>(Map<K, V> original) {
    return Map.from(original.map((key, value) {
      if (value is Map) return MapEntry(key, deepCopyFilters(value));
      return MapEntry(key, value);
    }));
  }

  static bool reserveFiltersChanged() {
    return !(_defaultFilters[FilterKey.reservesCountMin] == _filters[FilterKey.reservesCountMin] &&
        _defaultFilters[FilterKey.reservesCountMax] == _filters[FilterKey.reservesCountMax]);
  }

  static bool animalFiltersChanged() {
    return !(const DeepCollectionEquality()
            .equals(_defaultFilters[FilterKey.animalsClass], _filters[FilterKey.animalsClass]) &&
        const DeepCollectionEquality()
            .equals(_defaultFilters[FilterKey.animalsDifficulty], _filters[FilterKey.animalsDifficulty]));
  }

  static bool weaponFiltersChanged() {
    return !(_defaultFilters[FilterKey.weaponsRifles] == _filters[FilterKey.weaponsRifles] &&
        _defaultFilters[FilterKey.weaponsShotguns] == _filters[FilterKey.weaponsShotguns] &&
        _defaultFilters[FilterKey.weaponsHandguns] == _filters[FilterKey.weaponsHandguns] &&
        _defaultFilters[FilterKey.weaponsBows] == _filters[FilterKey.weaponsBows] &&
        _defaultFilters[FilterKey.weaponsMagMin] == _filters[FilterKey.weaponsMagMin] &&
        _defaultFilters[FilterKey.weaponsMagMax] == _filters[FilterKey.weaponsMagMax] &&
        const DeepCollectionEquality()
            .equals(_defaultFilters[FilterKey.weaponsAnimalClass], _filters[FilterKey.weaponsAnimalClass]));
  }

  static bool callerFiltersChanged() {
    return !(const DeepCollectionEquality()
        .equals(_defaultFilters[FilterKey.callersEffectiveRange], _filters[FilterKey.callersEffectiveRange]));
  }

  static bool logFiltersChanged() {
    return !(const DeepCollectionEquality()
            .equals(_defaultFilters[FilterKey.logsGender], _filters[FilterKey.logsGender]) &&
        const DeepCollectionEquality()
            .equals(_defaultFilters[FilterKey.logsFurRarity], _filters[FilterKey.logsFurRarity]) &&
        const DeepCollectionEquality()
            .equals(_defaultFilters[FilterKey.logsTrophyRating], _filters[FilterKey.logsTrophyRating]) &&
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

  static bool missionFiltersChanged() {
    return !(const DeepCollectionEquality()
            .equals(_defaultFilters[FilterKey.missionType], _filters[FilterKey.missionType]) &&
        const DeepCollectionEquality()
            .equals(_defaultFilters[FilterKey.missionDifficulty], _filters[FilterKey.missionDifficulty]));
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

  static bool getBoolValueList(FilterKey filterKey, dynamic listKey) {
    return _filters[filterKey][listKey];
  }

  static bool getBoolValue(FilterKey filterKey) {
    return _filters[filterKey];
  }

  static int getIntValue(FilterKey filterKey) {
    return _filters[filterKey].toInt();
  }

  static double getDoubleValue(FilterKey filterKey) {
    return _filters[filterKey].toDouble();
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

  static void changeNumValue(FilterKey filterKey, num value) {
    _filters.update(filterKey, (v) => value);
  }

  static List<Reserve> filterReserves(String searchText) {
    List<Reserve> reserves = [];
    reserves.addAll(HelperJSON.reserves);
    if (searchText.isNotEmpty || reserveFiltersChanged()) {
      reserves = reserves
          .where((e) =>
              (searchText.isNotEmpty ? e.name.toLowerCase().contains(searchText.toLowerCase()) : true) &&
              e.count >= getIntValue(FilterKey.reservesCountMin) &&
              e.count <= getIntValue(FilterKey.reservesCountMax))
          .toList();
    }
    return reserves.sorted(Reserve.sortById);
  }

  static List<Animal> filterAnimals(String searchText, BuildContext context) {
    List<Animal> animals = [];
    animals.addAll(HelperJSON.animals);
    if (searchText.isNotEmpty || animalFiltersChanged()) {
      animals = animals
          .where((e) =>
              (searchText.isNotEmpty
                  ? e
                      .getNameByLocale(context.locale)
                      .toLowerCase()
                      .replaceFirst(" & ", " ")
                      .contains(searchText.toLowerCase())
                  : true) &&
              getBoolValueList(FilterKey.animalsClass, e.level) &&
              getBoolValueList(FilterKey.animalsDifficulty, e.difficulty))
          .toList();
    }
    return animals.sorted(Animal.sortByNameByLocale(context));
  }

  static List<Fur> filterFurs(String searchText) {
    List<Fur> animalFurs = [];
    animalFurs.addAll(HelperJSON.furs);
    if (searchText.isNotEmpty) {
      animalFurs = animalFurs.where((e) => (e.name.toLowerCase().contains(searchText.toLowerCase()))).toList();
    }
    return animalFurs.sorted(Fur.sortByName);
  }

  static List<Weapon> filterWeapons(String searchText) {
    List<Weapon> weapons = [];
    weapons.addAll(HelperJSON.weapons);
    if (searchText.isNotEmpty || weaponFiltersChanged()) {
      weapons = weapons
          .where((e) =>
              (searchText.isNotEmpty ? e.name.toLowerCase().contains(searchText.toLowerCase()) : true) &&
              (e.levels.any((e) => getBoolValueList(FilterKey.weaponsAnimalClass, e))) &&
              e.mag >= getIntValue(FilterKey.weaponsMagMin) &&
              e.mag <= getIntValue(FilterKey.weaponsMagMax) &&
              getBoolValue(e.typeToFilterKey()))
          .toList();
    }
    return weapons.sorted(Weapon.sortByTypeName);
  }

  static List<Ammo> filterAmmo(String searchText) {
    List<Ammo> ammo = [];
    ammo.addAll(HelperJSON.ammo);
    if (searchText.isNotEmpty) {
      ammo = ammo.where((e) => (e.name.toLowerCase().contains(searchText.toLowerCase()))).toList();
    }
    return ammo.sorted(Ammo.sortByName);
  }

  static List<Caller> filterCallers(String searchText) {
    List<Caller> callers = [];
    callers.addAll(HelperJSON.callers);
    if (searchText.isNotEmpty || callerFiltersChanged()) {
      callers = callers
          .where((e) =>
              (searchText.isNotEmpty ? e.name.toLowerCase().contains(searchText.toLowerCase()) : true) &&
              getBoolValueList(FilterKey.callersEffectiveRange, e.rangeM))
          .toList();
    }
    return callers.sorted(Caller.sortByName);
  }

  static List<Log> filterLogs(String searchText, BuildContext context) {
    List<Log> logs = [];
    logs.addAll(HelperLog.logs);
    if (searchText.isNotEmpty) {
      for (Log log in HelperLog.logs) {
        bool add = false;
        for (String search in searchText.split("|")) {
          if (search.isNotEmpty &&
              log.animal!.getNameByReserve(context.locale, log.reserve).toLowerCase().contains(search.toLowerCase())) {
            add = true;
            break;
          }
        }
        if (!add) logs.remove(log);
      }
    }
    if (logFiltersChanged()) {
      logs = logs
          .where((e) =>
              getBoolValueList(FilterKey.logsGender, e.isMale ? 1 : 0) &&
              getBoolValueList(FilterKey.logsTrophyRating, e.trophyRatingWithGO) &&
              getBoolValueList(FilterKey.logsFurRarity, e.animalFur!.rarity) &&
              e.trophy >= getDoubleValue(FilterKey.logsTrophyScoreMin) &&
              e.trophy <= getDoubleValue(FilterKey.logsTrophyScoreMax))
          .toList();
    }
    logs.sort((a, b) => Utils.dateTimeAs(DateStructure.compare, b.dateTime)
        .compareTo(Utils.dateTimeAs(DateStructure.compare, a.dateTime)));
    logs.multiSort(context, getSortCriteria(FilterKey.logsSort), getSortPreferences(FilterKey.logsSort));
    return logs;
  }

  static List<Loadout> filterLoadouts(String searchText) {
    List<Loadout> loadouts = [];
    loadouts.addAll(HelperLoadout.loadouts);
    if (searchText.isNotEmpty || loadoutFiltersChanged()) {
      loadouts = loadouts
          .where((e) =>
              (searchText.isNotEmpty ? e.name.toLowerCase().contains(searchText.toLowerCase()) : true) &&
              (e.ammo.isNotEmpty
                  ? (e.ammo.length >= getIntValue(FilterKey.loadoutsAmmoMin) &&
                      e.ammo.length <= getIntValue(FilterKey.loadoutsAmmoMax))
                  : true) &&
              (e.callers.isNotEmpty
                  ? (e.callers.length >= getIntValue(FilterKey.loadoutsCallersMin) &&
                      e.callers.length <= getIntValue(FilterKey.loadoutsCallersMax))
                  : true))
          .toList();
    }
    return loadouts;
  }

  static List<WeaponAmmo> filterLoadoutAmmo(String searchText) {
    List<WeaponAmmo> filtered = [];
    for (WeaponAmmo weaponAmmo in HelperJSON.weaponsAmmo) {
      Weapon weapon = HelperJSON.getWeapon(weaponAmmo.weaponId)!;
      Ammo ammo = HelperJSON.getAmmo(weaponAmmo.ammoId)!;
      if ((weapon.name.toLowerCase().contains(searchText.toLowerCase())) ||
          (ammo.name.toLowerCase().contains(searchText.toLowerCase()))) {
        filtered.add(weaponAmmo);
      }
    }
    return filtered.sorted(WeaponAmmo.sortByAmmoName);
  }

  static List<Caller> filterLoadoutCallers(String searchText) {
    List<Caller> callers = [];
    for (Caller caller in HelperJSON.callers) {
      if (caller.name.toLowerCase().contains(searchText.toLowerCase())) {
        callers.add(caller);
      }
    }
    return callers.sorted(Caller.sortByName);
  }

  static List<Mission> filterMissions(String searchText) {
    List<Mission> missions = [];
    missions.addAll(HelperJSON.missions);
    if (searchText.isNotEmpty || missionFiltersChanged()) {
      missions = missions
          .where((e) =>
              (searchText.isNotEmpty ? e.name.toLowerCase().contains(searchText.toLowerCase()) : true) &&
              getBoolValueList(FilterKey.missionType, MissionType.values.indexOf(e.type)) &&
              getBoolValueList(FilterKey.missionDifficulty, e.difficulty))
          .toList();
    }
    return missions.sorted(Mission.sortByReserveName);
  }

  static List<Enumerator> filterEnumerators(String searchText, List<Enumerator> allEnumerators) {
    List<Enumerator> enumerators = [];
    enumerators.addAll(allEnumerators);
    if (searchText.isNotEmpty) {
      enumerators = enumerators.where((e) => (e.name.toLowerCase().contains(searchText.toLowerCase()))).toList();
    }
    return enumerators.sorted(Enumerator.sortByOrder);
  }
}
