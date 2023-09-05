// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/graphics.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/activities/info_caller.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/widgets/entries/item.dart';
import 'package:cotwcompanion/widgets/tag.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntryCaller extends StatefulWidget {
  final int index;
  final Caller caller;
  final Function callback;

  const EntryCaller({
    Key? key,
    required this.index,
    required this.caller,
    required this.callback,
  }) : super(key: key);

  @override
  EntryCallerState createState() => EntryCallerState();
}

class EntryCallerState extends State<EntryCaller> {
  late final bool _imperialUnits;

  @override
  void initState() {
    _imperialUnits = Provider.of<Settings>(context, listen: false).getImperialUnits;
    super.initState();
  }

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          widget.callback();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ActivityCallerInfo(callerId: widget.caller.id)),
          );
        },
        child: Container(
            padding: const EdgeInsets.all(30),
            color: widget.index % 2 == 0 ? Interface.even : Interface.odd,
            child: EntryItem(
                text: widget.caller.getName(context.locale),
                itemIcon: Graphics.getCallerIcon(widget.caller.id),
                tags: [
                  WidgetTag.medium(
                    icon: "assets/graphics/icons/dlc.svg",
                    color: Interface.accent,
                    background: Interface.primary,
                    margin: const EdgeInsets.only(right: 5),
                    isVisible: widget.caller.isFromDlc,
                  ),
                  WidgetTag.medium(
                    text: widget.caller.getRange(_imperialUnits),
                    icon: "assets/graphics/icons/range.svg",
                    color: Interface.dark,
                    background: Interface.tag,
                  )
                ])));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
