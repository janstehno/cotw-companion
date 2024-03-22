import 'package:cotwcompanion/activities/planner.dart';
import 'package:cotwcompanion/builders/builder.dart';
import 'package:cotwcompanion/helpers/planner.dart';
import 'package:cotwcompanion/model/describable/perk.dart';
import 'package:cotwcompanion/model/describable/skill.dart';
import 'package:flutter/material.dart';

class BuilderPlanner extends BuilderBuilder {
  const BuilderPlanner({
    super.key,
  }) : super("P");

  @override
  State<StatefulWidget> createState() => BuilderPlannerState();
}

class BuilderPlannerState extends BuilderBuilderState {
  final HelperPlanner _helperPlanner = HelperPlanner();

  @override
  void initializeData(AsyncSnapshot<Map<String, dynamic>> snapshot, BuildContext context) {
    List<Perk> perks = snapshot.data!["perks"] ?? [];
    _helperPlanner.setPerks(perks);
    List<Skill> skills = snapshot.data!["skills"] ?? [];
    _helperPlanner.setSkills(skills);
  }

  @override
  Future<Map<String, dynamic>> loadData() async {
    List<Perk> perks = await _helperPlanner.readPerks();
    updateProgress("perks", perks);
    List<Skill> skills = await _helperPlanner.readSkills();
    updateProgress("skills", skills);
    await Future.delayed(const Duration(seconds: 1), () {});
    return loadedData;
  }

  @override
  Widget buildFutureWidget(BuildContext context) => ActivityPlanner(_helperPlanner);
}
