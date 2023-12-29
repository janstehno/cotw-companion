// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/builders/home/data.dart';
import 'package:cotwcompanion/builders/home/data_second.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/animal_fur.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/model/dlc.dart';
import 'package:cotwcompanion/model/fur.dart';
import 'package:cotwcompanion/model/giver.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/model/mission.dart';
import 'package:cotwcompanion/model/multimount.dart';
import 'package:cotwcompanion/model/perk.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/model/skill.dart';
import 'package:cotwcompanion/model/weapon.dart';
import 'package:cotwcompanion/model/weapon_ammo.dart';
import 'package:cotwcompanion/model/zone.dart';
import 'package:flutter/material.dart';

class BuilderDataFirst extends BuilderData {
  BuilderDataFirst({
    super.key,
  }) : super(
          toLoad: [
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
          ],
          nextWidget: BuilderDataSecond(),
        );

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
    Map<String, dynamic> mapObjects = snapshot.data![12] ?? [];
    List<Mission> missions = snapshot.data![13] ?? [];
    List<Giver> missionsGivers = snapshot.data![14] ?? [];
    List<Perk> perks = snapshot.data![15] ?? [];
    List<Skill> skills = snapshot.data![16] ?? [];
    List<Multimount> multimounts = snapshot.data![17] ?? [];
    HelperJSON.setLists(ammo, animals, animalsCallers, animalsFurs, animalsReserves, animalsZones, callers, dlcs, furs, reserves, weapons, weaponsAmmo, mapObjects,
        missions, missionsGivers, perks, skills, multimounts);
  }
}
