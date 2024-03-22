import 'package:cotwcompanion/lists/planner/proficiency.dart';
import 'package:cotwcompanion/model/describable/skill.dart';
import 'package:flutter/material.dart';

class ListSkills extends ListProficiency<Skill> {
  const ListSkills(
    super.type, {
    super.key,
    required super.helperPlanner,
    required super.availablePoints,
    required super.rebuild,
    required super.showDetail,
  });

  @override
  State<StatefulWidget> createState() => ListSkillsState();
}

class ListSkillsState extends ListProficiencyState<Skill> {
  @override
  Map<int, List<Skill>> get items => widget.helperPlanner.getSkillsFor(widget.type);
}
