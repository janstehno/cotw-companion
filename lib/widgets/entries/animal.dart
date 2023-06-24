// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/graphics.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/activities/info_animal.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/widgets/item.dart';
import 'package:cotwcompanion/widgets/tag.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EntryAnimal extends StatefulWidget {
  final Animal animal;
  final int index;
  final Function callback;

  const EntryAnimal({
    Key? key,
    required this.animal,
    required this.index,
    required this.callback,
  }) : super(key: key);

  @override
  EntryAnimalState createState() => EntryAnimalState();
}

class EntryAnimalState extends State<EntryAnimal> {
  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          widget.callback();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ActivityAnimalInfo(animalId: widget.animal.id)),
          );
        },
        child: Container(
            padding: const EdgeInsets.all(30),
            color: widget.index % 2 == 0 ? Interface.even : Interface.odd,
            child: WidgetItem(
                text: widget.animal.getName(context.locale),
                textColor: Interface.dark,
                itemIcon: Graphics.getAnimalIcon(widget.animal.id),
                iconColor: Interface.dark,
                tags: [
                  WidgetTag.medium(
                    iconSize: 20,
                    icon: "assets/graphics/icons/dlc.svg",
                    color: Interface.accent,
                    background: Interface.primary,
                    margin: const EdgeInsets.only(right: 5),
                    isVisible: widget.animal.isFromDlc,
                  ),
                  WidgetTag.medium(
                    text: widget.animal.level.toString(),
                    icon: "assets/graphics/icons/level.svg",
                    color: Interface.dark,
                    background: Interface.tag,
                    margin: const EdgeInsets.only(right: 5),
                  ),
                  WidgetTag.medium(
                    iconSize: 17,
                    icon: "assets/graphics/icons/grounded.svg",
                    color: Interface.dark,
                    background: Interface.tag,
                    isVisible: widget.animal.grounded,
                    margin: const EdgeInsets.only(right: 5),
                  ),
                  WidgetTag.medium(
                    iconSize: 18,
                    text: widget.animal.removePointZero(widget.animal.diamond.toString()),
                    icon: "assets/graphics/icons/trophy_diamond.svg",
                    color: Interface.alwaysDark,
                    background: Interface.trophyDiamond,
                    margin: const EdgeInsets.only(right: 5),
                  ),
                  WidgetTag.medium(
                    iconSize: 20,
                    icon: "assets/graphics/icons/trophy_great_one.svg",
                    color: Interface.light,
                    background: Interface.dark,
                    isVisible: widget.animal.hasGO,
                  ),
                  WidgetTag.medium(
                    iconSize: 15,
                    icon: "assets/graphics/icons/female.svg",
                    color: Interface.dark,
                    background: Interface.tag,
                    isVisible: widget.animal.femaleDiamond,
                    margin: const EdgeInsets.only(right: 5),
                  ),
                ])));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
