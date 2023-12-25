// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/detail/animal.dart';
import 'package:cotwcompanion/miscellaneous/interface/graphics.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/widgets/entries/item.dart';
import 'package:cotwcompanion/widgets/tag.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EntryAnimal extends StatefulWidget {
  final int index;
  final Animal animal;
  final Function callback;

  const EntryAnimal({
    Key? key,
    required this.index,
    required this.animal,
    required this.callback,
  }) : super(key: key);

  @override
  EntryAnimalState createState() => EntryAnimalState();
}

class EntryAnimalState extends State<EntryAnimal> {
  List<WidgetTag> _buildTags() {
    List<WidgetTag> tags = [];
    if (widget.animal.isFromDlc) {
      tags.add(WidgetTag.big(
        icon: "assets/graphics/icons/dlc.svg",
        color: Interface.accent,
        background: Interface.primary,
      ));
    }
    if (widget.animal.hasGO) {
      tags.add(WidgetTag.big(
        icon: "assets/graphics/icons/trophy_great_one.svg",
        color: Interface.light,
        background: Interface.trophyGreatOne,
      ));
    }
    tags.addAll([
      WidgetTag.big(
        icon: "assets/graphics/icons/level.svg",
        value: widget.animal.level.toString(),
        color: Interface.dark,
        background: Interface.tag,
      ),
      WidgetTag.big(
        icon: "assets/graphics/icons/stats.svg",
        value: widget.animal.difficulty.toString(),
        color: Interface.dark,
        background: Interface.tag,
      ),
      WidgetTag.big(
        icon: "assets/graphics/icons/trophy_diamond.svg",
        value: widget.animal.trophyAsString(widget.animal.diamond),
        color: Interface.alwaysDark,
        background: Interface.trophyDiamond,
      ),
    ]);

    if (widget.animal.grounded) {
      tags.add(WidgetTag.big(
        icon: "assets/graphics/icons/grounded.svg",
        color: Interface.dark,
        background: Interface.tag,
      ));
    }
    if (widget.animal.femaleDiamond) {
      tags.add(WidgetTag.big(
        icon: "assets/graphics/icons/gender_female.svg",
        color: Interface.dark,
        background: Interface.tag,
      ));
    }
    return tags;
  }

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          widget.callback();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ActivityDetailAnimal(animalId: widget.animal.id)),
          );
        },
        child: Container(
            padding: const EdgeInsets.all(30),
            color: Utils.background(widget.index),
            child: EntryItem(
              text: widget.animal.getNameByLocale(context.locale),
              itemIcon: Graphics.getAnimalIcon(widget.animal.id),
              tags: _buildTags(),
            )));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
