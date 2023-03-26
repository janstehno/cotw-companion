// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/graphics.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/activities/info_caller.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/widgets/item.dart';
import 'package:cotwcompanion/widgets/tag.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntryCaller extends StatefulWidget {
  final Caller caller;
  final int index;
  final Function callback;

  const EntryCaller({
    Key? key,
    required this.caller,
    required this.index,
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
            child: WidgetItem(
                text: widget.caller.getName(context.locale),
                textColor: Interface.dark,
                itemIcon: Graphics.getCallerIcon(widget.caller.id),
                iconColor: Interface.dark,
                tags: [
                  WidgetTag.medium(
                    icon: "assets/graphics/icons/dlc.svg",
                    iconSize: 20,
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
