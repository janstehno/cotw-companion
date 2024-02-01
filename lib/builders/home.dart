// Copyright (c) 2023 Jan Stehno

import 'dart:async';

import 'package:cotwcompanion/activities/home.dart';
import 'package:cotwcompanion/miscellaneous/helpers/enumerator.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/helpers/log.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/values.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/animal_fur.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/model/dlc.dart';
import 'package:cotwcompanion/model/enumerator.dart';
import 'package:cotwcompanion/model/fur.dart';
import 'package:cotwcompanion/model/giver.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/model/loadout.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:cotwcompanion/model/mission.dart';
import 'package:cotwcompanion/model/multimount.dart';
import 'package:cotwcompanion/model/perk.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/model/skill.dart';
import 'package:cotwcompanion/model/weapon.dart';
import 'package:cotwcompanion/model/weapon_ammo.dart';
import 'package:cotwcompanion/model/zone.dart';
import 'package:cotwcompanion/widgets/error.dart';
import 'package:cotwcompanion/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class BuilderHome extends StatefulWidget {
  const BuilderHome({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BuilderHomeState();
}

class BuilderHomeState extends State<BuilderHome> {
  final GlobalKey<ProgressBarState> progressBarKey = GlobalKey<ProgressBarState>();
  final List<dynamic> _loadedData = [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null];

  void _updateProgress(int id, dynamic data) {
    _loadedData[id] = data;
    progressBarKey.currentState?.rebuild(id);
  }

  void _initializeData(AsyncSnapshot<List<dynamic>> snapshot, BuildContext context) {
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
    List<Perk> perks = snapshot.data![14] ?? [];
    List<Skill> skills = snapshot.data![15] ?? [];
    List<Multimount> multimounts = snapshot.data![16] ?? [];
    Map<String, dynamic> mapObjects = snapshot.data![17] ?? {};
    HelperJSON.setLists(ammo, animals, animalsCallers, animalsFurs, animalsReserves, animalsZones, callers, dlcs, furs, reserves, weapons, weaponsAmmo, missions,
        missionsGivers, perks, skills, multimounts);
    HelperJSON.setMapObjects(mapObjects);
    List<Log> logs = snapshot.data![18] ?? [];
    List<Loadout> loadouts = snapshot.data![19] ?? [];
    List<Enumerator> enumerators = snapshot.data![20] ?? [];
    HelperLog.setLogs(logs, context);
    HelperLoadout.setLoadouts(loadouts);
    HelperEnumerator.setEnumerators(enumerators);
    HelperFilter.initializeFilters();
  }

  Future<List<dynamic>> _loadData() async {
    List<Ammo> ammo = await HelperJSON.readAmmo();
    _updateProgress(0, ammo);
    List<Animal> animals = await HelperJSON.readAnimals();
    _updateProgress(1, animals);
    List<IdtoId> animalsCallers = await HelperJSON.readAnimalsCallers();
    _updateProgress(2, animalsCallers);
    List<AnimalFur> animalsFurs = await HelperJSON.readAnimalsFurs();
    _updateProgress(3, animalsFurs);
    List<IdtoId> animalsReserves = await HelperJSON.readAnimalsReserves();
    _updateProgress(4, animalsReserves);
    List<Zone> animalsZones = await HelperJSON.readAnimalsZones();
    _updateProgress(5, animalsZones);
    List<Caller> callers = await HelperJSON.readCallers();
    _updateProgress(6, callers);
    List<Dlc> dlcs = await HelperJSON.readDlcs();
    _updateProgress(7, dlcs);
    List<Fur> furs = await HelperJSON.readFurs();
    _updateProgress(8, furs);
    List<Reserve> reserves = await HelperJSON.readReserves();
    _updateProgress(9, reserves);
    List<Weapon> weapons = await HelperJSON.readWeapons();
    _updateProgress(10, weapons);
    List<WeaponAmmo> weaponsAmmo = await HelperJSON.readWeaponsAmmo();
    _updateProgress(11, weaponsAmmo);
    List<Mission> missions = await HelperJSON.readMissions();
    _updateProgress(12, missions);
    List<Giver> missionsGivers = await HelperJSON.readMissionsGivers();
    _updateProgress(13, missionsGivers);
    List<Perk> perks = await HelperJSON.readPerks();
    _updateProgress(14, perks);
    List<Skill> skills = await HelperJSON.readSkills();
    _updateProgress(15, skills);
    List<Multimount> multimounts = await HelperJSON.readMultimounts();
    _updateProgress(16, multimounts);
    Map<String, dynamic> mapObjects = await HelperJSON.readMapObjects();
    _updateProgress(17, mapObjects);
    List<Log> logs = await HelperLog.readFile();
    _updateProgress(18, logs);
    List<Loadout> loadouts = await HelperLoadout.readFile();
    _updateProgress(19, loadouts);
    List<Enumerator> enumerators = await HelperEnumerator.readFile();
    _updateProgress(20, enumerators);
    return _loadedData;
  }

  Widget _buildHome(AsyncSnapshot<List<dynamic>> snapshot, BuildContext context) {
    if (snapshot.hasError) {
      return WidgetError(
        code: "Ex0001",
        error: "${snapshot.error}",
        stack: "${snapshot.stackTrace}",
      );
    } else if (!snapshot.hasData) {
      return const WidgetError(
        code: "Ex0002",
        error: "Snapshot has no data.",
      );
    } else if (snapshot.data!.length != Values.data) {
      return const WidgetError(
        code: "Ex0003",
        error: "Snapshot data length is not correct.",
      );
    } else {
      _initializeData(snapshot, context);
      return const ActivityHome();
    }
  }

  Widget _buildWidgets(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Interface.body,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30),
          child: ProgressBar(key: progressBarKey),
        ),
        FutureBuilder(
          future: _loadData(),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const SizedBox.shrink();
            } else {
              return _buildHome(snapshot, context);
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
