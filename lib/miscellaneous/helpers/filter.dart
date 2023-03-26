// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/helpers/log.dart';
import 'package:cotwcompanion/miscellaneous/types.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/model/loadout.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:cotwcompanion/model/weapon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HelperFilter {
  static List<dynamic> filterListByName(List<dynamic> list, String text, BuildContext context) {
    List<dynamic> filtered = [];
    if (text.isEmpty) {
      filtered.addAll(list);
    } else {
      for (dynamic item in list) {
        if (item.getName(context.locale).toLowerCase().contains(text.toLowerCase())) {
          filtered.add(item);
        }
      }
    }
    return filtered;
  }

  static List<Weapon> filterWeapons(List<Weapon> list, String text, BuildContext context) {
    List<Weapon> filtered = [];
    if (text.isEmpty) {
      filtered.addAll(list);
    } else {
      for (Weapon item in list) {
        if (item.getName(context.locale).toLowerCase().contains(text.toLowerCase()) || item.getTypeAsString().toLowerCase().contains(text.toLowerCase())) {
          filtered.add(item);
        }
      }
    }
    return filtered;
  }

  static List<int> filterLoadoutItemsByName(ObjectType type, String text, BuildContext context) {
    Ammo ammo;
    Weapon weapon;
    List<int> filtered = [];
    if (type == ObjectType.ammo) {
      if (text.isEmpty) {
        for (IdtoId iti in HelperJSON.weaponsAmmo) {
          filtered.add(iti.id);
        }
      } else {
        for (IdtoId iti in HelperJSON.weaponsAmmo) {
          ammo = HelperJSON.getAmmo(iti.secondId);
          weapon = HelperJSON.getWeapon(iti.firstId);
          if (ammo.getName(context.locale).toLowerCase().contains(text.toLowerCase()) || weapon.getName(context.locale).toLowerCase().contains(text.toLowerCase())) {
            filtered.add(iti.id);
          }
        }
      }
    } else if (type == ObjectType.caller) {
      if (text.isEmpty) {
        for (Caller caller in HelperJSON.callers) {
          filtered.add(caller.id);
        }
      } else {
        for (Caller caller in HelperJSON.callers) {
          if (caller.getName(context.locale).toLowerCase().contains(text.toLowerCase())) {
            filtered.add(caller.id);
          }
        }
      }
    }
    return filtered;
  }

  static List<Loadout> filterLoadoutsByName(String text, BuildContext context) {
    List<Loadout> filtered = [];
    if (text.isEmpty) {
      filtered.addAll(HelperLoadout.loadouts);
    } else {
      for (dynamic item in HelperLoadout.loadouts) {
        if (item.getName.toLowerCase().contains(text.toLowerCase())) {
          filtered.add(item);
        }
      }
    }
    return filtered;
  }

  static List<Log> filterByMultipleCriteria(List<List<dynamic>> compareList, String searchText, BuildContext context) {
    List<Log> filtered = [];
    if (searchText.isEmpty) {
      return HelperLog.logs;
    } else {
      for (int i = 0; i < compareList[1].length; i++) {
        dynamic d = compareList[0][i];
        int c = compareList[1][i];
        for (Log l in HelperLog.logs) {
          Animal a = HelperJSON.getAnimal(l.animalId);
          if (c == 0) {
            if (compareList[1].contains(1)) {
              dynamic d2 = compareList[0][compareList[1].indexOf(1)];
              if (l.trophy == d2 && a.getNameBasedOnReserve(context.locale, l.reserveId).toLowerCase().contains(d) && !filtered.contains(l)) filtered.add(l);
            } else if (compareList[1].contains(2) && compareList[1].contains(3)) {
              dynamic d2 = compareList[0][compareList[1].indexOf(2)];
              dynamic d3 = compareList[0][compareList[1].indexOf(3)];
              if (l.trophy >= d2 && l.trophy <= d3 && a.getNameBasedOnReserve(context.locale, l.reserveId).toLowerCase().contains(d) && !filtered.contains(l)) {
                filtered.add(l);
              }
            } else if (compareList[1].contains(3)) {
              dynamic d2 = compareList[0][compareList[1].indexOf(3)];
              if (l.trophy <= d2 && a.getNameBasedOnReserve(context.locale, l.reserveId).toLowerCase().contains(d) && !filtered.contains(l)) filtered.add(l);
            } else if (compareList[1].contains(2)) {
              dynamic d2 = compareList[0][compareList[1].indexOf(2)];
              if (l.trophy >= d2 && a.getNameBasedOnReserve(context.locale, l.reserveId).toLowerCase().contains(d) && !filtered.contains(l)) filtered.add(l);
            } else {
              if (a.getNameBasedOnReserve(context.locale, l.reserveId).toLowerCase().contains(d) && !filtered.contains(l)) filtered.add(l);
            }
          } else if (c == 1) {
            if (!compareList[1].contains(0)) {
              if (l.trophy == d && !filtered.contains(l)) filtered.add(l);
            }
          } else if (c == 2) {
            if (!compareList[1].contains(0)) {
              if (compareList[1].contains(3)) {
                dynamic d2 = compareList[0][compareList[1].indexOf(3)];
                if (l.trophy >= d && l.trophy <= d2 && !filtered.contains(l)) filtered.add(l);
              } else {
                if (l.trophy >= d && !filtered.contains(l)) filtered.add(l);
              }
            }
          } else if (c == 3) {
            if (!compareList[1].contains(0)) {
              if (compareList[1].contains(2)) {
                dynamic d2 = compareList[0][compareList[0].indexOf(2)];
                if (l.trophy >= d2 && l.trophy <= d && !filtered.contains(l)) filtered.add(l);
              } else {
                if (l.trophy <= d && !filtered.contains(l)) filtered.add(l);
              }
            }
          }
        }
      }
    }
    return filtered;
  }
}
