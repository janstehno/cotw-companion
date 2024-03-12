// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/lists/planner/proficiency.dart';
import 'package:cotwcompanion/widgets/entries/planner/skill.dart';
import 'package:flutter/material.dart';

class ListSkills extends ListProficiency {
  const ListSkills({
    super.key,
    required super.helperPlanner,
    required super.type,
    required super.availablePoints,
    required super.refresh,
    required super.showDetail,
  });

  @override
  State<StatefulWidget> createState() => ListSkillsState();
}

class ListSkillsState extends ListProficiencyState {
  @override
  void getList() {
    items.clear();
    items.addAll(widget.helperPlanner.getSkillsFor(widget.type));
  }

  @override
  Widget buildProficiency(int tier, int index) {
    return EntrySkill(
      helperPlanner: widget.helperPlanner,
      size: squareSize,
      availablePoints: widget.availablePoints,
      proficiency: items[tier]!.elementAt(index),
      refresh: widget.refresh,
      showDetail: widget.showDetail,
    );
  }
}
