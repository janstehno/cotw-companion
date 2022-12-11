// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_graphics.dart';
import 'package:cotwcompanion/helpers/helper_settings.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/activities/caller_info.dart';
import 'package:cotwcompanion/thehunter/model/caller.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_part_name_image.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_part_tags_button.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_container.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/tag.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntryCaller extends StatefulWidget {
  final Caller caller;
  final int index;
  final Function callback;

  const EntryCaller({Key? key, required this.caller, required this.index, required this.callback}) : super(key: key);

  @override
  EntryCallerState createState() => EntryCallerState();
}

class EntryCallerState extends State<EntryCaller> {
  late Settings _settings;

  @override
  void initState() {
    _settings = Provider.of<Settings>(context, listen: false);
    super.initState();
  }

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          widget.callback();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ActivityCallerInfo(callerID: widget.caller.getID)),
          );
        },
        child: Container(
            color: widget.index % 2 == 0 ? Color(Values.colorEven) : Color(Values.colorOdd),
            child: WidgetContainer(
                child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  EntryPartNameImage(text: widget.caller.getName(context.locale), icon: Graphics.getCallerIcon(widget.caller.getID)),
                  EntryPartTagsButton(tags: [
                    WidgetTag.medium(
                    margin: const EdgeInsets.only(right: 5),
                    color: Values.colorAccent,
                    background: Values.colorPrimary,
                    icon: "assets/graphics/icons/dlc.svg",
                    size: 20,
                    visible: widget.caller.getDlc),
                    WidgetTag.medium(
                    text: widget.caller.getRange(_settings.getImperialUnits),
                    icon: "assets/graphics/icons/range.svg",
                    color: Values.colorDark,
                    background: Values.colorTag)
              ])
                ]))));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
