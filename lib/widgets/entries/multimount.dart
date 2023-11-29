// Copyright (c) 2023 Jan Stehno';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/model/multimount.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EntryMultimount extends StatefulWidget {
  final int index;
  final Multimount multimount;

  const EntryMultimount({
    Key? key,
    required this.index,
    required this.multimount,
  }) : super(key: key);

  @override
  EntryMultimountState createState() => EntryMultimountState();
}

class EntryMultimountState extends State<EntryMultimount> {
  final List<int> _usedLogs = [];

  Widget _buildOwned(bool owned) {
    return Container(
      width: 20,
      height: 20,
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.only(right: 10),
      child: SvgPicture.asset(
        "assets/graphics/icons/${owned ? "todo" : "optional"}.svg",
        colorFilter: ColorFilter.mode(
          owned ? Interface.green : Interface.disabled,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget _buildGender(bool isMale) {
    return Container(
        margin: const EdgeInsets.only(right: 5),
        child: isMale
            ? SvgPicture.asset(
                "assets/graphics/icons/gender_male.svg",
                width: 13,
                height: 13,
                colorFilter: const ColorFilter.mode(
                  Interface.genderMale,
                  BlendMode.srcIn,
                ),
              )
            : SvgPicture.asset(
                "assets/graphics/icons/gender_female.svg",
                width: 14,
                height: 14,
                colorFilter: const ColorFilter.mode(
                  Interface.genderFemale,
                  BlendMode.srcIn,
                ),
              ));
  }

  Widget _buildAnimal(MultimountAnimal multimountAnimal) {
    bool owned = _isInTrophyLodge(multimountAnimal);
    String name = HelperJSON.getAnimal(multimountAnimal.id).getName(context.locale);
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildOwned(owned),
          _buildGender(multimountAnimal.isMale),
          Expanded(
            child: AutoSizeText(
              name,
              style: Interface.s16w300n(Interface.dark),
            ),
          )
        ],
      ),
    );
  }

  bool _isInTrophyLodge(MultimountAnimal multimountAnimal) {
    int? logId = Utils.isMultimountAnimalInTrophyLodge(multimountAnimal, _usedLogs);
    if (logId == null) {
      return false;
    }
    _usedLogs.add(logId);
    return true;
  }

  Widget _buildAnimals(MultimountAnimal multimountAnimal) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: multimountAnimal.count,
      itemBuilder: (context, index) {
        return _buildAnimal(multimountAnimal);
      },
    );
  }

  Widget _buildMultimountAnimals() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.multimount.animals.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            _buildAnimals(widget.multimount.animals.elementAt(index)),
          ],
        );
      },
    );
  }

  Widget _buildWidgets() {
    return Container(
        padding: const EdgeInsets.all(30),
        color: Utils.background(widget.index),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(right: 30),
                        alignment: Alignment.topLeft,
                        child: AutoSizeText(
                          widget.multimount.getName(context.locale),
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: Interface.s18w300n(Interface.dark),
                        ))),
              ],
            ),
            Container(
                margin: const EdgeInsets.only(top: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMultimountAnimals(),
                  ],
                ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
