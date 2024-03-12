// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/graphics.dart';
import 'package:cotwcompanion/model/perk.dart';
import 'package:cotwcompanion/widgets/entries/planner/proficiency.dart';
import 'package:flutter/material.dart';

class EntryPerk extends EntryProficiency {
  const EntryPerk({
    super.key,
    required super.helperPlanner,
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
  late final Perk _perk;

  @override
  void initState() {
    _perk = widget.proficiency as Perk;
    super.initState();
  }

  @override
  bool isUnlocked() {
    return _perk.isParentLeveled(widget.helperPlanner);
  }

  @override
  bool isUsable() {
    return _perk.isUsable(widget.helperPlanner, widget.availablePoints);
  }

  @override
  String getIcon() {
    return Graphics.getPerkIcon(widget.proficiency.id);
  }
}
