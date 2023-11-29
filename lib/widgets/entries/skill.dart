// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/graphics.dart';
import 'package:cotwcompanion/model/skill.dart';
import 'package:cotwcompanion/widgets/entries/proficiency.dart';
import 'package:flutter/material.dart';

class EntrySkill extends EntryProficiency {
  const EntrySkill({
    super.key,
    required super.size,
    required super.availablePoints,
    required super.proficiency,
    required super.refresh,
    required super.showDetail,
  });

  @override
  State<StatefulWidget> createState() => EntrySkillState();
}

class EntrySkillState extends EntryProficiencyState {
  late Skill _skill;

  @override
  void initState() {
    _skill = widget.proficiency as Skill;
    super.initState();
  }

  @override
  bool isUnlocked() {
    return _skill.isUnlocked;
  }

  @override
  bool isUsable() {
    return _skill.isUsable(widget.availablePoints);
  }

  @override
  String getIcon() {
    return Graphics.getSkillIcon(widget.proficiency.id);
  }
}
