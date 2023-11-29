// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/detail/mission.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/model/mission.dart';
import 'package:cotwcompanion/widgets/entries/item.dart';
import 'package:cotwcompanion/widgets/tag.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EntryMission extends StatefulWidget {
  final int index;
  final Mission mission;
  final Function callback;

  const EntryMission({
    Key? key,
    required this.index,
    required this.mission,
    required this.callback,
  }) : super(key: key);

  @override
  EntryMissionState createState() => EntryMissionState();
}

class EntryMissionState extends State<EntryMission> {
  List<WidgetTag> _buildTags() {
    List<WidgetTag> tags = [];
    tags.addAll([
      WidgetTag.small(
        value: widget.mission.getTypeAsString(),
        color: Interface.dark,
        background: Interface.tag,
      ),
      WidgetTag.small(
        value: widget.mission.getDifficultyAsString(),
        color: Interface.alwaysDark,
        background: widget.mission.getDifficultyColor(),
      ),
    ]);
    return tags;
  }

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          widget.callback();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ActivityDetailMission(mission: widget.mission)),
          );
        },
        child: Container(
            padding: const EdgeInsets.all(30),
            color: Utils.background(widget.index),
            child: EntryItem(
              text: widget.mission.getName(context.locale),
              tags: _buildTags(),
            )));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
