// Copyright (c) 2023 Jan Stehno

import 'dart:async';

import 'package:cotwcompanion/activities/home.dart';
import 'package:cotwcompanion/miscellaneous/helpers/enumerator.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/helpers/log.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BuilderHome extends StatelessWidget {
  final double indicatorSize = 30;

  BuilderHome({
    Key? key,
  }) : super(key: key);

  final List<Future<dynamic>> _data = [
    HelperJSON.readAmmo(),
    HelperJSON.readAnimals(),
    HelperJSON.readAnimalsCallers(),
    HelperJSON.readAnimalsFurs(),
    HelperJSON.readAnimalsReserves(),
    HelperJSON.readAnimalsZones(),
    HelperJSON.readCallers(),
    HelperJSON.readDlcs(),
    HelperJSON.readFurs(),
    HelperJSON.readReserves(),
    HelperJSON.readWeapons(),
    HelperJSON.readWeaponsAmmo(),
    HelperJSON.readMapObjects(),
    HelperJSON.readMissions(),
    HelperJSON.readMissionsGivers(),
    HelperJSON.readPerks(),
    HelperJSON.readSkills(),
    HelperJSON.readMultimounts(),
    HelperLog.readFile(),
    HelperLoadout.readFile(),
    HelperEnumerator.readFile(),
  ];

  void _initializeJsonData(AsyncSnapshot<List<dynamic>> snapshot) {
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
    Map<String, dynamic> mapObjects = snapshot.data![12] ?? [];
    List<Mission> missions = snapshot.data![13] ?? [];
    List<Giver> missionsGivers = snapshot.data![14] ?? [];
    List<Perk> perks = snapshot.data![15] ?? [];
    List<Skill> skills = snapshot.data![16] ?? [];
    List<Multimount> multimounts = snapshot.data![17] ?? [];
    HelperJSON.setLists(ammo, animals, animalsCallers, animalsFurs, animalsReserves, animalsZones, callers, dlcs, furs, reserves, weapons, weaponsAmmo, mapObjects,
        missions, missionsGivers, perks, skills, multimounts);
  }

  void _initializeFileData(AsyncSnapshot<List<dynamic>> snapshot, BuildContext context) {
    List<Log> logs = snapshot.data![18] ?? [];
    List<Loadout> loadouts = snapshot.data![19] ?? [];
    List<Enumerator> enumerators = snapshot.data![20] ?? [];
    HelperLog.setLogs(logs, context);
    HelperLoadout.setLoadouts(loadouts);
    HelperEnumerator.setEnumerators(enumerators);
  }

  Widget _loadingScreen() {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Container(
          color: Interface.body,
          padding: const EdgeInsets.all(30),
          child: SpinKitThreeBounce(
            size: indicatorSize,
            color: Interface.dark,
          ),
        );
      },
    );
  }

  Widget _buildHome(AsyncSnapshot<List<dynamic>> snapshot, context) {
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
    } else if (snapshot.data!.length != _data.length) {
      return const WidgetError(
        code: "Ex0003",
        error: "Snapshot data length is not correct.",
      );
    } else {
      _initializeJsonData(snapshot);
      _initializeFileData(snapshot, context);
      HelperFilter.initializeFilters();
      return const ActivityHome();
    }
  }

  Widget _buildWidgets(BuildContext context) {
    precacheImage(const AssetImage("assets/graphics/images/cotw.jpg"), context);
    return FutureBuilder(
      future: Future.wait(_data),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return _loadingScreen();
        } else {
          return _buildHome(snapshot, context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
