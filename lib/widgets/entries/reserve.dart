// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/graphics.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/activities/info_reserve.dart';
import 'package:cotwcompanion/builders/map.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/widgets/item.dart';
import 'package:cotwcompanion/widgets/tag.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EntryReserve extends StatefulWidget {
  final Reserve reserve;
  final int index;
  final Function callback;

  const EntryReserve({
    Key? key,
    required this.reserve,
    required this.index,
    required this.callback,
  }) : super(key: key);

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
            MaterialPageRoute(builder: (context) => ActivityReserveInfo(reserveId: widget.reserve.id)),
          );
        },
        child: Container(
            padding: const EdgeInsets.all(30),
            color: widget.index % 2 == 0 ? Interface.even : Interface.odd,
            child: WidgetItem(
              text: widget.reserve.getName(context.locale),
              textColor: Interface.dark,
              itemIcon: Graphics.getReserveIcon(widget.reserve.id),
              iconColor: Interface.dark,
              buttonIcon: "assets/graphics/icons/map.svg",
              buttonColor: Interface.accent,
              buttonBackground: Interface.primary,
              tags: [
                WidgetTag.medium(
                  icon: "assets/graphics/icons/dlc.svg",
                  iconSize: 20,
                  color: Interface.accent,
                  background: Interface.primary,
                  margin: const EdgeInsets.only(right: 5),
                  isVisible: widget.reserve.isFromDlc,
                ),
                WidgetTag.medium(
                  text: widget.reserve.count.toString(),
                  icon: "assets/graphics/icons/target.svg",
                  color: Interface.dark,
                  background: Interface.tag,
                ),
              ],
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BuilderMap(reserveId: widget.reserve.id)));
              },
            )));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
