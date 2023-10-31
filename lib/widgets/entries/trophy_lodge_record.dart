// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryTrophyLodgeRecord extends StatefulWidget {
  final int index;
  final Log log;

  const EntryTrophyLodgeRecord({
    Key? key,
    required this.index,
    required this.log,
  }) : super(key: key);

  @override
  EntryTrophyLodgeRecordState createState() => EntryTrophyLodgeRecordState();
}

class EntryTrophyLodgeRecordState extends State<EntryTrophyLodgeRecord> {
  final double _nameHeight = 30;
  final double _genderIconSize = 15;
  final double _furHeight = 15;
  final double _furDotSize = 10;
  final double _trophyWidth = 100;
  final double _trophyHeight = 30;
  final double _trophyIconSize = 20;
  final double _weightWidth = 65;
  final double _weightHeight = 15;

  late Animal _animal;

  Widget _buildName() {
    return Container(
        height: _nameHeight,
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(right: 10),
        child: AutoSizeText(
          _animal.getNameBasedOnReserve(context.locale, widget.log.reserveId),
          maxLines: 2,
          minFontSize: 8,
          textAlign: TextAlign.left,
          style: Interface.s18w300n(Interface.dark),
        ));
  }

  Widget _buildGender() {
    return Container(
        width: _genderIconSize,
        height: _genderIconSize,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.all(0.5),
        child: SvgPicture.asset(
          widget.log.isMale ? "assets/graphics/icons/gender_male.svg" : "assets/graphics/icons/gender_female.svg",
          fit: BoxFit.fitWidth,
          colorFilter: ColorFilter.mode(
            widget.log.isMale ? Interface.genderMale : Interface.genderFemale,
            BlendMode.srcIn,
          ),
        ));
  }

  Widget _buildFur() {
    String furName = widget.log.fur.getName(context.locale);
    return Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: _furHeight,
          height: _furHeight,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 5),
          child: Container(
              width: _furDotSize,
              height: _furDotSize,
              decoration: ShapeDecoration(
                color: widget.log.fur.color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
              ))),
      Expanded(
          child: Container(
              height: _furHeight,
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                furName,
                maxLines: 1,
                minFontSize: 8,
                textAlign: TextAlign.left,
                style: Interface.s14w300n(Interface.dark),
              )))
    ]);
  }

  Widget _buildTrophy() {
    return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: _trophyWidth,
          maxWidth: _trophyWidth,
          minHeight: _trophyHeight,
          maxHeight: _trophyHeight,
        ),
        child: Container(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: _trophyIconSize,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 5),
                        child: SvgPicture.asset(
                          widget.log.getTrophyRatingIcon(),
                          fit: BoxFit.fitWidth,
                          colorFilter: ColorFilter.mode(
                            widget.log.getTrophyColor(),
                            BlendMode.srcIn,
                          ),
                        )),
                    Expanded(
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: AutoSizeText(
                              widget.log.trophy.toString(),
                              maxLines: 1,
                              minFontSize: 8,
                              style: Interface.s18w500n(Interface.dark),
                            )))
                  ],
                ),
              ],
            )));
  }

  Widget _buildWeight() {
    return SizedBox(
        width: _weightWidth,
        height: _weightHeight,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 10),
                child: AutoSizeText(
                  widget.log.usesImperials ? ("${widget.log.weight} ${tr('pounds')}") : ("${widget.log.weight} ${tr('kilograms')}"),
                  maxLines: 1,
                  minFontSize: 8,
                  textAlign: TextAlign.left,
                  style: Interface.s14w300n(Interface.dark),
                ))
          ],
        ));
  }

  Widget _buildWidgets() {
    _animal = HelperJSON.getAnimal(widget.log.animalId);
    return Container(
        color: widget.index % 2 == 0 ? Interface.even : Interface.odd,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Column(children: [
              Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                _buildGender(),
                Expanded(child: _buildName()),
                _buildTrophy(),
              ]),
              Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
                Expanded(
                  child: _buildFur(),
                ),
                widget.log.weight > 0 ? _buildWeight() : const SizedBox.shrink(),
              ])
            ])));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
