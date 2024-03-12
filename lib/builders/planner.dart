// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/planner.dart';
import 'package:cotwcompanion/builders/builder.dart';
import 'package:cotwcompanion/miscellaneous/helpers/planner.dart';
import 'package:cotwcompanion/model/perk.dart';
import 'package:cotwcompanion/model/skill.dart';
import 'package:flutter/material.dart';

class BuilderPlanner extends BuilderBuilder {
  const BuilderPlanner({
    super.key,
  }) : super(builderId: "P");

  @override
  State<StatefulWidget> createState() => BuilderPlannerState();
}

class BuilderPlannerState extends BuilderBuilderState {
  late final HelperPlanner _helperPlanner;

  @override
  void initState() {
    _helperPlanner = HelperPlanner();
    loadedData = [null, null];
    super.initState();
  }

  @override
  void initializeData(AsyncSnapshot<List<dynamic>> snapshot, BuildContext context) {
    List<Perk> perks = snapshot.data![0] ?? [];
    _helperPlanner.setPerks(perks);
    List<Skill> skills = snapshot.data![1] ?? [];
    _helperPlanner.setSkills(skills);
  }

  @override
  Future<List<dynamic>> loadData(BuildContext context) async {
    List<Perk> perks = await _helperPlanner.readPerks();
    updateProgress(0, perks);
    List<Skill> skills = await _helperPlanner.readSkills();
    updateProgress(1, skills);
    return loadedData;
  }

  @override
  Widget buildFutureWidget(BuildContext context) {
    return ActivityPlanner(helperPlanner: _helperPlanner);
  }
}
