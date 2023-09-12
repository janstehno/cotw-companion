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
  late Animal _animal;

  Widget _buildName() {
    return Container(
        height: 30,
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(right: 10),
        child: AutoSizeText(
          _animal.getNameBasedOnReserve(context.locale, widget.log.reserveId),
          maxLines: 2,
          minFontSize: 10,
          textAlign: TextAlign.left,
          style: Interface.s18w300n(Interface.dark),
        ));
  }

  Widget _buildGender() {
    return Container(
        width: 15,
        height: 15,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 5),
        child: SvgPicture.asset(
          widget.log.isMale ? "assets/graphics/icons/gender_male.svg" : "assets/graphics/icons/gender_female.svg",
          width: 14,
          height: 14,
          colorFilter: ColorFilter.mode(
            widget.log.isMale ? Interface.male : Interface.female,
            BlendMode.srcIn,
          ),
        ));
  }

  Widget _buildFur() {
    String furName = widget.log.fur.getName(context.locale);
    return Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: 15,
          height: 15,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 5),
          child: Container(
              width: 9,
              height: 9,
              decoration: ShapeDecoration(
                color: widget.log.fur.color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
              ))),
      Expanded(
          child: Container(
              height: 15,
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                furName,
                maxLines: 1,
                minFontSize: 10,
                textAlign: TextAlign.left,
                style: Interface.s14w300n(Interface.dark),
              )))
    ]);
  }

  Widget _buildTrophy() {
    return ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: 100,
          minHeight: 30,
          maxHeight: 30,
        ),
        child: Container(
            alignment: Alignment.centerRight,
            child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
              Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                    width: 20,
                    height: 30,
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
                          minFontSize: 10,
                          style: Interface.s18w500n(Interface.dark),
                        )))
              ]),
            ])));
  }

  Widget _buildWeight() {
    return SizedBox(
        width: 65,
        height: 15,
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 10),
              child: AutoSizeText(
                widget.log.usesImperials ? ("${widget.log.weight} ${tr('pounds')}") : ("${widget.log.weight} ${tr('kilograms')}"),
                maxLines: 1,
                minFontSize: 10,
                textAlign: TextAlign.left,
                style: Interface.s14w300n(Interface.dark),
              ))
        ]));
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
                Expanded(child: widget.log.isGreatOne() ? const SizedBox.shrink() : _buildFur()),
                widget.log.weight > 0 ? _buildWeight() : const SizedBox.shrink(),
              ])
            ])));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
