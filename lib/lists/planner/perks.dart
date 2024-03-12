// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/lists/planner/proficiency.dart';
import 'package:cotwcompanion/widgets/entries/planner/perk.dart';
import 'package:flutter/material.dart';

class ListPerks extends ListProficiency {
  const ListPerks({
    super.key,
    required super.type,
    required super.helperPlanner,
    required super.availablePoints,
    required super.refresh,
    required super.showDetail,
  });

  @override
  State<StatefulWidget> createState() => ListPerksState();
}

class ListPerksState extends ListProficiencyState {
  @override
  void getList() {
    items.clear();
    items.addAll(widget.helperPlanner.getPerksFor(widget.type));
  }

  @override
  Widget buildProficiency(int tier, int index) {
    return EntryPerk(
      helperPlanner: widget.helperPlanner,
      size: squareSize,
      availablePoints: widget.availablePoints,
      proficiency: items[tier]!.elementAt(index),
      refresh: widget.refresh,
      showDetail: widget.showDetail,
    );
  }
}
