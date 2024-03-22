import 'package:cotwcompanion/lists/planner/proficiency.dart';
import 'package:cotwcompanion/model/describable/perk.dart';
import 'package:flutter/material.dart';

class ListPerks extends ListProficiency<Perk> {
  const ListPerks(
    super.type, {
    super.key,
    required super.helperPlanner,
    required super.availablePoints,
    required super.rebuild,
    required super.showDetail,
  });

  @override
  State<StatefulWidget> createState() => ListPerksState();
}

class ListPerksState extends ListProficiencyState<Perk> {
  @override
  Map<int, List<Perk>> get items => widget.helperPlanner.getPerksFor(widget.type);
}
