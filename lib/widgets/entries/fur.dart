// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/animal_fur.dart';
import 'package:cotwcompanion/widgets/fur_per_cent.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EntryFur extends StatefulWidget {
  final AnimalFur animalFur;

  final double height = 22;

  const EntryFur({
    Key? key,
    required this.animalFur,
  }) : super(key: key);

  @override
  EntryFurState createState() => EntryFurState();
}

class EntryFurState extends State<EntryFur> {
  final double _genderIconSize = 15;

  late final Animal _animal;
  late final bool _showPerCent;

  @override
  void initState() {
    _animal = HelperJSON.getAnimal(widget.animalFur.animalId);
    _showPerCent = Provider.of<Settings>(context, listen: false).furRarityPerCent;
    super.initState();
  }

  Widget _buildWidgets() {
    return SizedBox(
        height: widget.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(right: 10),
                  child: AutoSizeText(
                    _animal.getNameByLocale(context.locale),
                    maxLines: 1,
                    style: Interface.s16w300n(Interface.dark),
                  )),
            ),
            SizedBox(
              width: _genderIconSize,
              height: _genderIconSize,
              child: widget.animalFur.male
                  ? SvgPicture.asset(
                      "assets/graphics/icons/gender_male.svg",
                      fit: BoxFit.fitWidth,
                      colorFilter: const ColorFilter.mode(
                        Interface.genderMale,
                        BlendMode.srcIn,
                      ),
                    )
                  : widget.animalFur.female
                      ? SvgPicture.asset(
                          "assets/graphics/icons/gender_female.svg",
                          fit: BoxFit.fitWidth,
                          colorFilter: const ColorFilter.mode(
                            Interface.genderFemale,
                            BlendMode.srcIn,
                          ),
                        )
                      : const SizedBox.shrink(),
            ),
            _showPerCent
                ? WidgetFurPerCent(
                    animalFur: widget.animalFur,
                  )
                : const SizedBox.shrink(),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
