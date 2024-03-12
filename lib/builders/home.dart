// Copyright (c) 2023 Jan Stehno

import 'dart:async';

import 'package:cotwcompanion/activities/home.dart';
import 'package:cotwcompanion/builders/builder.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/helpers/log.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/animal_fur.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/model/dlc.dart';
import 'package:cotwcompanion/model/fur.dart';
import 'package:cotwcompanion/model/giver.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/model/loadout.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:cotwcompanion/model/mission.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/model/weapon.dart';
import 'package:cotwcompanion/model/weapon_ammo.dart';
import 'package:cotwcompanion/model/zone.dart';
import 'package:flutter/material.dart';

class BuilderHome extends BuilderBuilder {
  const BuilderHome({
    super.key,
  }) : super(builderId: "H");

  @override
  State<StatefulWidget> createState() => BuilderHomeState();
}

class BuilderHomeState extends BuilderBuilderState {
  @override
  void initState() {
    loadedData = [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null];
    super.initState();
  }

  @override
  void initializeData(AsyncSnapshot<List<dynamic>> snapshot, BuildContext context) {
    List<Ammo> ammo = snapshot.data![0] ?? [];
    List<Animal> animals = snapshot.data![1] ?? [];
    List<IdtoId> animalsCallers = snapshot.data![2] ?? [];
    List<AnimalFur> animalsFurs = snapshot.data![3] ?? [];
    List<IdtoId> animalsReserves = snapshot.data![4] ?? [];
    List<Zone> animalsZones = snapshot.data![5] ?? [];
    List<Caller> callers = snapshot.data![6] ?? [];
    List<Dlc> dlcs = snapshot.data![7] ?? [];
    List<Fur> furs = snapshot.data![8] ?? [];
    List<Reserve> reserves = snapshot.data![9] ?? [];
    List<Weapon> weapons = snapshot.data![10] ?? [];
    List<WeaponAmmo> weaponsAmmo = snapshot.data![11] ?? [];
    List<Mission> missions = snapshot.data![12] ?? [];
    List<Giver> missionsGivers = snapshot.data![13] ?? [];
    HelperJSON.setLists(
        ammo, animals, animalsCallers, animalsFurs, animalsReserves, animalsZones, callers, dlcs, furs, reserves, weapons, weaponsAmmo, missions, missionsGivers);
    List<Log> logs = snapshot.data![14] ?? [];
    List<Loadout> loadouts = snapshot.data![15] ?? [];
    HelperLog.setLogs(logs, context);
    HelperLoadout.setLoadouts(loadouts);
    HelperFilter.initializeFilters();
  }

  @override
  Future<List<dynamic>> loadData(BuildContext context) async {
    List<Ammo> ammo = await HelperJSON.readAmmo();
    updateProgress(0, ammo);
    List<Animal> animals = await HelperJSON.readAnimals();
    updateProgress(1, animals);
    List<IdtoId> animalsCallers = await HelperJSON.readAnimalsCallers();
    updateProgress(2, animalsCallers);
    List<AnimalFur> animalsFurs = await HelperJSON.readAnimalsFurs();
    updateProgress(3, animalsFurs);
    List<IdtoId> animalsReserves = await HelperJSON.readAnimalsReserves();
    updateProgress(4, animalsReserves);
    List<Zone> animalsZones = await HelperJSON.readAnimalsZones();
    updateProgress(5, animalsZones);
    List<Caller> callers = await HelperJSON.readCallers();
    updateProgress(6, callers);
    List<Dlc> dlcs = await HelperJSON.readDlcs();
    updateProgress(7, dlcs);
    List<Fur> furs = await HelperJSON.readFurs();
    updateProgress(8, furs);
    List<Reserve> reserves = await HelperJSON.readReserves();
    updateProgress(9, reserves);
    List<Weapon> weapons = await HelperJSON.readWeapons();
    updateProgress(10, weapons);
    List<WeaponAmmo> weaponsAmmo = await HelperJSON.readWeaponsAmmo();
    updateProgress(11, weaponsAmmo);
    List<Mission> missions = await HelperJSON.readMissions();
    updateProgress(12, missions);
    List<Giver> missionsGivers = await HelperJSON.readMissionsGivers();
    updateProgress(13, missionsGivers);
    List<Log> logs = await HelperLog.readFile();
    updateProgress(14, logs);
    List<Loadout> loadouts = await HelperLoadout.readFile();
    updateProgress(15, loadouts);
    return loadedData;
  }

  @override
  buildFutureWidget(BuildContext context) {
    return const ActivityHome();
  }
}
