// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_graphics.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/activities/animal_info.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_part_name_image.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_part_tags_button.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_container.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/tag.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EntryAnimal extends StatefulWidget {
  final Animal animal;
  final int index;
  final Function callback;

  const EntryAnimal({Key? key, required this.animal, required this.index, required this.callback}) : super(key: key);

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
            MaterialPageRoute(builder: (context) => ActivityAnimalInfo(animalID: widget.animal.getID)),
          );
        },
        child: Container(
            color: widget.index % 2 == 0 ? Color(Values.colorEven) : Color(Values.colorOdd),
            child: WidgetContainer(
                child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  EntryPartNameImage(text: widget.animal.getName(context.locale), icon: Graphics.getAnimalIcon(widget.animal.getID)),
                  EntryPartTagsButton(tags: [
                    WidgetTag.medium(
                    margin: const EdgeInsets.only(right: 5),
                    color: Values.colorAccent,
                    background: Values.colorPrimary,
                    icon: "assets/graphics/icons/dlc.svg",
                    size: 20,
                    visible: widget.animal.getDlc),
                    WidgetTag.medium(
                    margin: const EdgeInsets.only(right: 5),
                    text: widget.animal.getLevel.toString(),
                    color: Values.colorDark,
                    background: Values.colorTag,
                    icon: "assets/graphics/icons/level.svg"),
                    WidgetTag.medium(
                    margin: const EdgeInsets.only(right: 5),
                    color: Values.colorAlwaysDark,
                    background: Values.colorDiamond,
                    icon: "assets/graphics/icons/trophy_diamond.svg",
                    size: 18,
                    text: widget.animal.removePointZero(widget.animal.getDiamond.toString())),
                    WidgetTag.medium(
                    color: Values.colorLight, background: Values.colorDark, icon: "assets/graphics/icons/trophy_great_one.svg", size: 20, visible: widget.animal.getGO)
              ])
                ]))));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
