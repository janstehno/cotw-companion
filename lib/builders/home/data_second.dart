// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/home.dart';
import 'package:cotwcompanion/builders/home/data.dart';
import 'package:cotwcompanion/miscellaneous/helpers/enumerator.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/helpers/log.dart';
import 'package:cotwcompanion/model/enumerator.dart';
import 'package:cotwcompanion/model/loadout.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:flutter/material.dart';

class BuilderDataSecond extends BuilderData {
  BuilderDataSecond({
    super.key,
  }) : super(
          toLoad: [
            HelperLog.readFile(),
            HelperLoadout.readFile(),
            HelperEnumerator.readFile(),
          ],
          nextWidget: const ActivityHome(),
        );

  @override
  void initializeData(AsyncSnapshot<List<dynamic>> snapshot, BuildContext context) {
    List<Log> logs = snapshot.data![0] ?? [];
    List<Loadout> loadouts = snapshot.data![1] ?? [];
    List<Enumerator> enumerators = snapshot.data![2] ?? [];
    HelperLog.setLogs(logs, context);
    HelperLoadout.setLoadouts(loadouts);
    HelperEnumerator.setEnumerators(enumerators);
    HelperFilter.initializeFilters();
  }
}
