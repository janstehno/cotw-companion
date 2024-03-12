// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/animal_fur.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

abstract class EntryLogsEntry extends StatefulWidget {
  final int index;
  final Log log;

  const EntryLogsEntry({
    Key? key,
    required this.index,
    required this.log,
  }) : super(key: key);
}

abstract class EntryLogsEntryState extends State<EntryLogsEntry> {
  final double dateHeight = 15;
  final double dateIconSize = 9;
  final double nameHeight = 30;
  final double genderIconSize = 15;
  final double furHeight = 15;
  final double furDotSize = 9;
  final double trophyWidth = 100;
  final double trophyHeight = 30;
  final double trophyIconSize = 20;
  final double weightWidth = 65;
  final double weightHeight = 15;

  late final Settings settings;

  late bool entryDate;
  late Reserve reserve;
  late Animal animal;
  late AnimalFur fur;

  @override
  void initState() {
    settings = Provider.of<Settings>(context, listen: false);
    super.initState();
  }

  void getData() {
    entryDate = settings.entryDate;
    reserve = widget.log.reserve;
    animal = widget.log.animal;
    fur = widget.log.fur;
  }

  Widget buildName() {
    return Container(
      height: nameHeight,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(right: 30),
      child: AutoSizeText(
        animal.getNameBasedOnReserve(context.locale, widget.log.reserveId),
        maxLines: 2,
        textAlign: TextAlign.left,
        style: Interface.s18w300n(Interface.dark),
      ),
    );
  }

  Widget buildGender() {
    return Container(
        width: genderIconSize,
        height: genderIconSize,
        alignment: Alignment.centerRight,
        child: SvgPicture.asset(
          widget.log.isMale ? "assets/graphics/icons/gender_male.svg" : "assets/graphics/icons/gender_female.svg",
          fit: BoxFit.fitWidth,
          colorFilter: ColorFilter.mode(
            widget.log.isMale ? Interface.genderMale : Interface.genderFemale,
            BlendMode.srcIn,
          ),
        ));
  }

  Widget buildFur() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: furHeight,
            height: furHeight,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 5),
            child: Container(
                width: furDotSize,
                height: furDotSize,
                decoration: ShapeDecoration(
                  color: fur.color,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                ))),
        Expanded(
            child: Container(
                height: furHeight,
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(right: 30),
                child: AutoSizeText(
                  fur.getName(context.locale),
                  maxLines: 1,
                  minFontSize: 4,
                  textAlign: TextAlign.left,
                  style: Interface.s14w300n(Interface.dark.withOpacity(0.75)),
                )))
      ],
    );
  }

  Widget buildTrophy() {
    return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: trophyWidth,
          maxWidth: trophyWidth,
          minHeight: trophyHeight,
          maxHeight: trophyHeight,
        ),
        child: Container(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: trophyIconSize,
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
                    height: trophyHeight,
                    alignment: Alignment.centerRight,
                    child: AutoSizeText(
                      Utils.removePointZero(widget.log.trophy),
                      maxLines: 1,
                      minFontSize: 4,
                      style: Interface.s18w500n(Interface.dark),
                    )),
              )
            ],
          ),
        ));
  }

  Widget buildWeight() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: weightWidth,
        maxWidth: weightWidth,
        minHeight: weightHeight,
        maxHeight: weightHeight,
      ),
      child: Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(left: 10),
          child: AutoSizeText(
            "${Utils.removePointZero(widget.log.weight)} ${widget.log.usesImperials ? tr("pounds") : tr("kilograms")}",
            maxLines: 1,
            minFontSize: 4,
            textAlign: TextAlign.right,
            style: Interface.s14w300n(Interface.dark),
          )),
    );
  }

  Widget buildEntry() => Container();

  Widget _buildWidgets() {
    getData();
    return Container(
      color: Utils.background(widget.index),
      child: buildEntry(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
