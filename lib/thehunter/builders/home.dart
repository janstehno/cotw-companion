// Copyright (c) 2022 Jan Stehno

import 'dart:async';

import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_log.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/activities/home.dart';
import 'package:cotwcompanion/thehunter/model/ammo.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/model/animal_fur.dart';
import 'package:cotwcompanion/thehunter/model/caller.dart';
import 'package:cotwcompanion/thehunter/model/dlc.dart';
import 'package:cotwcompanion/thehunter/model/fur.dart';
import 'package:cotwcompanion/thehunter/model/idtoid.dart';
import 'package:cotwcompanion/thehunter/model/log.dart';
import 'package:cotwcompanion/thehunter/model/reserve.dart';
import 'package:cotwcompanion/thehunter/model/weapon.dart';
import 'package:cotwcompanion/thehunter/model/zone.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BuilderHome extends StatelessWidget {
  const BuilderHome({Key? key}) : super(key: key);

  Future<Widget> _forcedDelay() async {
    return await Future.delayed(const Duration(seconds: 2), () => const ActivityHome());
  }

  Widget _buildWidgets() {
    return FutureBuilder(
        future: Future.wait([
          JSONHelper.readAmmo(),
          JSONHelper.readAnimals(),
          JSONHelper.readAnimalsCallers(),
          JSONHelper.readAnimalsFurs(),
          JSONHelper.readAnimalsReserves(),
          JSONHelper.readAnimalsZones(),
          JSONHelper.readCallers(),
          JSONHelper.readDlcs(),
          JSONHelper.readFurs(),
          JSONHelper.readReserves(),
          JSONHelper.readWeapons(),
          JSONHelper.readWeaponsAmmo(),
          JSONHelper.readWeaponsInfo(),
          LogHelper.readLogs(),
          _forcedDelay()
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasError) {
            return WidgetError(text: snapshot.error.toString());
          } else if (snapshot.hasData) {
            var ammo = snapshot.data![0] as List<Ammo>;
            var animals = snapshot.data![1] as List<Animal>;
            var animalsCallers = snapshot.data![2] as List<IDtoID>;
            var animalsFurs = snapshot.data![3] as List<AnimalFur>;
            var animalsReserves = snapshot.data![4] as List<IDtoID>;
            var animalsZones = snapshot.data![5] as List<Zone>;
            var callers = snapshot.data![6] as List<Caller>;
            var dlcs = snapshot.data![7] as List<Dlc>;
            var furs = snapshot.data![8] as List<Fur>;
            var reserves = snapshot.data![9] as List<Reserve>;
            var weapons = snapshot.data![10] as List<Weapon>;
            var weaponsAmmo = snapshot.data![11] as List<IDtoID>;
            var weaponsInfo = snapshot.data![12] as List<Weapon>;
            var logs = snapshot.data![13] as List<Log>;
            var widget = snapshot.data![14] as Widget;
            JSONHelper.setLists(
                ammo, animals, animalsCallers, animalsFurs, animalsReserves, animalsZones, callers, dlcs, furs, reserves, weapons, weaponsAmmo, weaponsInfo);
            LogHelper.setLogs(logs, context);
            return widget;
          } else {
            return Padding(padding: const EdgeInsets.all(30), child: SpinKitThreeBounce(size: 30, color: Color(Values.colorAccent)));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
