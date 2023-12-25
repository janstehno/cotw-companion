// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/widgets/entries/logs/entry.dart';
import 'package:flutter/material.dart';

class EntryTrophyLodge extends EntryLogsEntry {
  const EntryTrophyLodge({
    super.key,
    required super.index,
    required super.log,
  });

  @override
  EntryTrophyLodgeState createState() => EntryTrophyLodgeState();
}

class EntryTrophyLodgeState extends EntryLogsEntryState {
  @override
  Widget buildEntry() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 5),
                child: buildGender(),
              ),
              Expanded(
                child: buildName(),
              ),
              buildTrophy(),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: buildFur(),
              ),
              widget.log.weight > 0 ? buildWeight() : const SizedBox.shrink(),
            ],
          )
        ],
      ),
    );
  }
}
