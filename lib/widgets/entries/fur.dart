// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/animal_fur.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EntryFur extends StatefulWidget {
  final AnimalFur animalFur;

  const EntryFur({
    Key? key,
    required this.animalFur,
  }) : super(key: key);

  @override
  EntryFurState createState() => EntryFurState();
}

class EntryFurState extends State<EntryFur> {
  late final Animal _animal;
  late final bool _showPerCent;

  @override
  void initState() {
    _animal = HelperJSON.getAnimal(widget.animalFur.animalId);
    _showPerCent = Provider.of<Settings>(context, listen: false).getFurRarityPerCent;
    super.initState();
  }

  Widget _buildPerCentText(String text) {
    return AutoSizeText(
      text,
      maxLines: 1,
      style: Interface.s12w300n(Interface.dark),
    );
  }

  Widget _buildWidgetPerCent() {
    String left, right, point, percent;
    left = right = point = percent = "";
    if (widget.animalFur.furId != Interface.greatOneId) {
      left = widget.animalFur.perCent.toString().split(".")[0];
      right = widget.animalFur.perCent.toString().split(".")[1];
      point = ".";
      percent = "%";
    }
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: 60,
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(left: 10),
          child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
            _buildPerCentText(left),
            _buildPerCentText(point),
            _buildPerCentText(right),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: _buildPerCentText(percent),
            ),
          ]))
    ]);
  }

  Widget _buildWidgets() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Expanded(
        child: Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(right: 10),
            child: AutoSizeText(
              _animal.getName(context.locale),
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
                    )),
      _showPerCent ? _buildWidgetPerCent() : const SizedBox.shrink(),
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
