// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_loadout.dart';
import 'package:cotwcompanion/helpers/helper_log.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/model/loadout.dart';
import 'package:cotwcompanion/thehunter/model/log.dart';
import 'package:cotwcompanion/thehunter/model/weapon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HelperFilter {
  static List<dynamic> filterListByName(List<dynamic> list, String searchText, BuildContext context) {
    List<dynamic> filtered = [];
    if (searchText.isEmpty) {
      filtered.addAll(list);
    } else {
      for (dynamic r in list) {
        if (r.getName(context.locale).toLowerCase().contains(searchText.toLowerCase())) {
          filtered.add(r);
        }
      }
    }
    return filtered;
  }

  static List<Weapon> filterWeaponsByName(String text, BuildContext context) {
    List<Weapon> filtered = [];
    if (text.isEmpty) {
      filtered.addAll(JSONHelper.weaponsInfo);
    } else {
      for (dynamic r in JSONHelper.weaponsInfo) {
        if (r.getName(context.locale).toLowerCase().contains(text.toLowerCase()) ||
            r.getNameAmmo(context.locale).toLowerCase().contains(text.toLowerCase())) {
          filtered.add(r);
        }
      }
    }
    return filtered;
  }

  static List<Loadout> filterLoadoutsByName(String text, BuildContext context) {
    List<Loadout> filtered = [];
    if (text.isEmpty) {
      filtered.addAll(LoadoutHelper.loadouts);
    } else {
      for (dynamic r in LoadoutHelper.loadouts) {
        if (r.getName.toLowerCase().contains(text.toLowerCase())) {
          filtered.add(r);
        }
      }
    }
    return filtered;
  }

  static List<Log> filterByMultipleCriteria(List<List<dynamic>> compareList, String searchText, BuildContext context) {
    List<Log> filtered = [];
    if (searchText.isEmpty) {
      return LogHelper.logs;
    } else {
      for (int i = 0; i < compareList[1].length; i++) {
        dynamic d = compareList[0][i];
        int c = compareList[1][i];
        for (Log l in LogHelper.logs) {
          Animal a = JSONHelper.getAnimal(l.getAnimalID);
          if (c == 0) {
            if (compareList[1].contains(1)) {
              dynamic d2 = compareList[0][compareList[1].indexOf(1)];
              if (l.getTrophy == d2 && a.getNameBasedOnReserve(context.locale, l.getReserveID).toLowerCase().contains(d) && !filtered.contains(l)) filtered.add(l);
            } else if (compareList[1].contains(2) && compareList[1].contains(3)) {
              dynamic d2 = compareList[0][compareList[1].indexOf(2)];
              dynamic d3 = compareList[0][compareList[1].indexOf(3)];
              if (l.getTrophy >= d2 && l.getTrophy <= d3 && a.getNameBasedOnReserve(context.locale, l.getReserveID).toLowerCase().contains(d) && !filtered.contains(l)) {
                filtered.add(l);
              }
            } else if (compareList[1].contains(3)) {
              dynamic d2 = compareList[0][compareList[1].indexOf(3)];
              if (l.getTrophy <= d2 && a.getNameBasedOnReserve(context.locale, l.getReserveID).toLowerCase().contains(d) && !filtered.contains(l)) filtered.add(l);
            } else if (compareList[1].contains(2)) {
              dynamic d2 = compareList[0][compareList[1].indexOf(2)];
              if (l.getTrophy >= d2 && a.getNameBasedOnReserve(context.locale, l.getReserveID).toLowerCase().contains(d) && !filtered.contains(l)) filtered.add(l);
            } else {
              if (a.getNameBasedOnReserve(context.locale, l.getReserveID).toLowerCase().contains(d) && !filtered.contains(l)) filtered.add(l);
            }
          } else if (c == 1) {
            if (!compareList[1].contains(0)) {
              if (l.getTrophy == d && !filtered.contains(l)) filtered.add(l);
            }
          } else if (c == 2) {
            if (!compareList[1].contains(0)) {
              if (compareList[1].contains(3)) {
                dynamic d2 = compareList[0][compareList[1].indexOf(3)];
                if (l.getTrophy >= d && l.getTrophy <= d2 && !filtered.contains(l)) filtered.add(l);
              } else {
                if (l.getTrophy >= d && !filtered.contains(l)) filtered.add(l);
              }
            }
          } else if (c == 3) {
            if (!compareList[1].contains(0)) {
              if (compareList[1].contains(2)) {
                dynamic d2 = compareList[0][compareList[0].indexOf(2)];
                if (l.getTrophy >= d2 && l.getTrophy <= d && !filtered.contains(l)) filtered.add(l);
              } else {
                if (l.getTrophy <= d && !filtered.contains(l)) filtered.add(l);
              }
            }
          }
        }
      }
    }
    return filtered;
  }
}
