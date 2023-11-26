// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/interface/values.dart';
import 'package:cotwcompanion/model/animal_fur.dart';
import 'package:cotwcompanion/widgets/fur_per_cent.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EntryAnimalFur extends StatefulWidget {
  final AnimalFur animalFur;
  final bool isChosen;

  const EntryAnimalFur({
    Key? key,
    required this.animalFur,
    required this.isChosen,
  }) : super(key: key);

  @override
  EntryAnimalFurState createState() => EntryAnimalFurState();
}

class EntryAnimalFurState extends State<EntryAnimalFur> {
  final double _rarityWidth = 20;
  final double _rarityHeight = 10;

  late final bool _showPerCent;

  @override
  void initState() {
    _showPerCent = Provider.of<Settings>(context, listen: false).furRarityPerCent;
    super.initState();
  }

  Widget _buildAnimalFur() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: _rarityWidth,
          height: _rarityHeight,
          alignment: Alignment.center,
          child: AnimatedContainer(
              width: widget.isChosen ? _rarityWidth : _rarityHeight,
              height: _rarityHeight,
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 200),
              decoration: ShapeDecoration(
                color: widget.animalFur.color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.3)),
              ))),
      _showPerCent
          ? WidgetFurPerCent(
              animalFur: widget.animalFur,
            )
          : const SizedBox.shrink(),
      Expanded(
        child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: _showPerCent ? 0 : 20, right: 20),
            child: AutoSizeText(
              widget.animalFur.getName(context.locale),
              maxLines: 1,
              style: Interface.s16w300n(Interface.dark),
            )),
      ),
      Container(
          child: widget.animalFur.male
              ? SvgPicture.asset(
                  "assets/graphics/icons/gender_male.svg",
                  width: 13,
                  height: 13,
                  colorFilter: const ColorFilter.mode(
                    Interface.genderMale,
                    BlendMode.srcIn,
                  ),
                )
              : widget.animalFur.female
                  ? SvgPicture.asset(
                      "assets/graphics/icons/gender_female.svg",
                      width: 14,
                      height: 14,
                      colorFilter: const ColorFilter.mode(
                        Interface.genderFemale,
                        BlendMode.srcIn,
                      ),
                    )
                  : const SizedBox(
                      height: 15,
                      width: 15,
                    ))
    ]);
  }

  Widget _buildWidgets() {
    return widget.animalFur.furId != Values.greatOneId
        ? Container(
            margin: const EdgeInsets.only(bottom: 3),
            child: _buildAnimalFur(),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
