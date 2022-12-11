// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_graphics.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/activities/reserve_info.dart';
import 'package:cotwcompanion/thehunter/builders/map.dart';
import 'package:cotwcompanion/thehunter/model/reserve.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_part_name_image.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_part_tags_button.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_container.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/tag.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EntryReserve extends StatefulWidget {
  final Reserve reserve;
  final int index;
  final Function callback;

  const EntryReserve({Key? key, required this.reserve, required this.index, required this.callback}) : super(key: key);

  @override
  EntryReserveState createState() => EntryReserveState();
}

class EntryReserveState extends State<EntryReserve> {
  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          widget.callback();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ActivityReserveInfo(reserveID: widget.reserve.getID)),
          );
        },
        child: Container(
            color: widget.index % 2 == 0 ? Color(Values.colorEven) : Color(Values.colorOdd),
            child: WidgetContainer(
                child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              EntryPartNameImage(text: widget.reserve.getName(context.locale), icon: Graphics.getReserveIcon(widget.reserve.getID)),
              EntryPartTagsButton(
                  tags: [
                    WidgetTag.medium(
                        margin: const EdgeInsets.only(right: 5),
                        color: Values.colorAccent,
                        background: Values.colorPrimary,
                        icon: "assets/graphics/icons/dlc.svg",
                        size: 20,
                        visible: widget.reserve.getDlc),
                    WidgetTag.medium(
                        text: widget.reserve.getCount.toString(), icon: "assets/graphics/icons/target.svg", color: Values.colorDark, background: Values.colorTag)
                  ],
                  icon: "assets/graphics/icons/map.svg",
                  buttonColor: Values.colorAccent,
                  buttonBackground: Values.colorPrimary,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BuilderMap(reserveID: widget.reserve.getID)));
                  })
            ]))));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
