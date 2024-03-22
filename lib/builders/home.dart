import 'dart:async';

import 'package:cotwcompanion/activities/home.dart';
import 'package:cotwcompanion/builders/builder.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/helpers/loadout.dart';
import 'package:cotwcompanion/helpers/log.dart';
import 'package:cotwcompanion/model/connect/animal_caller.dart';
import 'package:cotwcompanion/model/connect/animal_fur.dart';
import 'package:cotwcompanion/model/connect/animal_reserve.dart';
import 'package:cotwcompanion/model/connect/animal_zone.dart';
import 'package:cotwcompanion/model/connect/weapon_ammo.dart';
import 'package:cotwcompanion/model/describable/dlc.dart';
import 'package:cotwcompanion/model/describable/mission.dart';
import 'package:cotwcompanion/model/exportable/loadout.dart';
import 'package:cotwcompanion/model/exportable/log.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:cotwcompanion/model/translatable/fur.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:flutter/material.dart';

class BuilderHome extends BuilderBuilder {
  const BuilderHome({
    super.key,
  }) : super("H");

  @override
  State<StatefulWidget> createState() => BuilderHomeState();
}

class BuilderHomeState extends BuilderBuilderState {
  @override
  void initializeData(AsyncSnapshot<Map<String, dynamic>> snapshot, BuildContext context) {
    List<Ammo> ammo = snapshot.data!["ammo"] ?? [];
    List<Animal> animals = snapshot.data!["animals"] ?? [];
    List<AnimalCaller> animalsCallers = snapshot.data!["animalsCallers"] ?? [];
    List<AnimalFur> animalsFurs = snapshot.data!["animalsFurs"] ?? [];
    List<AnimalReserve> animalsReserves = snapshot.data!["animalsReserves"] ?? [];
    List<AnimalZone> animalsZones = snapshot.data!["animalsZones"] ?? [];
    List<Caller> callers = snapshot.data!["callers"] ?? [];
    List<Dlc> dlcs = snapshot.data!["dlcs"] ?? [];
    List<Fur> furs = snapshot.data!["furs"] ?? [];
    List<Reserve> reserves = snapshot.data!["reserves"] ?? [];
    List<Weapon> weapons = snapshot.data!["weapons"] ?? [];
    List<WeaponAmmo> weaponsAmmo = snapshot.data!["weaponsAmmo"] ?? [];
    List<Mission> missions = snapshot.data!["missions"] ?? [];
    HelperJSON.setLists(ammo, animals, animalsCallers, animalsFurs, animalsReserves, animalsZones, callers, dlcs, furs,
        reserves, weapons, weaponsAmmo, missions);
    List<Log> logs = snapshot.data!["logs"] ?? [];
    List<Loadout> loadouts = snapshot.data!["loadouts"] ?? [];
    HelperLog.setLogs(logs);
    HelperLoadout.setLoadouts(loadouts);
    HelperFilter.initializeFilters();
  }

  @override
  Future<Map<String, dynamic>> loadData() async {
    List<Ammo> ammo = await HelperJSON.readAmmo();
    updateProgress("ammo", ammo);
    List<Animal> animals = await HelperJSON.readAnimals();
    updateProgress("animals", animals);
    List<AnimalCaller> animalsCallers = await HelperJSON.readAnimalsCallers();
    updateProgress("animalsCallers", animalsCallers);
    List<AnimalFur> animalsFurs = await HelperJSON.readAnimalsFurs();
    updateProgress("animalsFurs", animalsFurs);
    List<AnimalReserve> animalsReserves = await HelperJSON.readAnimalsReserves();
    updateProgress("animalsReserves", animalsReserves);
    List<AnimalZone> animalsZones = await HelperJSON.readAnimalsZones();
    updateProgress("animalsZones", animalsZones);
    List<Caller> callers = await HelperJSON.readCallers();
    updateProgress("callers", callers);
    List<Dlc> dlcs = await HelperJSON.readDlcs();
    updateProgress("dlcs", dlcs);
    List<Fur> furs = await HelperJSON.readFurs();
    updateProgress("furs", furs);
    List<Reserve> reserves = await HelperJSON.readReserves();
    updateProgress("reserves", reserves);
    List<Weapon> weapons = await HelperJSON.readWeapons();
    updateProgress("weapons", weapons);
    List<WeaponAmmo> weaponsAmmo = await HelperJSON.readWeaponsAmmo();
    updateProgress("weaponsAmmo", weaponsAmmo);
    List<Mission> missions = await HelperJSON.readMissions();
    updateProgress("missions", missions);
    List<Log> logs = await HelperLog.readFile();
    updateProgress("logs", logs);
    List<Loadout> loadouts = await HelperLoadout.readFile();
    updateProgress("loadouts", loadouts);

    await Future.delayed(const Duration(seconds: 1), () {});
    return loadedData;
  }

  @override
  buildFutureWidget(BuildContext context) => const ActivityHome();
}
