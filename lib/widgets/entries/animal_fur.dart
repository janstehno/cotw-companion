// Copyright (c) 2022 Jan Stehno

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/model/animal_fur.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';

class EntryAnimalFur extends StatefulWidget {
  final AnimalFur fur;

  const EntryAnimalFur({
    Key? key,
    required this.fur,
  }) : super(key: key);

  @override
  EntryAnimalFurState createState() => EntryAnimalFurState();
}

class EntryAnimalFurState extends State<EntryAnimalFur> {
  late final bool _showPerCent;

  @override
  void initState() {
    _showPerCent = Provider.of<Settings>(context, listen: false).getFurRarityPerCent;
    super.initState();
  }

  Widget _buildWidgetPerCent() {
    String left = widget.fur.perCent.toString().split(".")[0];
    String right = widget.fur.perCent.toString().split(".")[1];
    String point = ".";
    String percent = "%";
    Alignment alignment = Alignment.centerLeft;
    if (right.length == 1) {
      right += "00";
    } else if (right.length == 2) {
      right += "0";
    }
    if (widget.fur.perCent == 0) {
      left = "";
      right = "...";
      point = "";
      alignment = Alignment.centerRight;
    }
    if (widget.fur.rarity == 0) {
      left = "";
      right = "";
      point = "";
      percent = "";
      alignment = Alignment.centerRight;
    }
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: 15,
          height: Interface.s26,
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(left: 10),
          child: AutoSizeText(left,
              maxLines: 1,
              style: TextStyle(
                color: Interface.dark,
                fontSize: Interface.s14,
                fontWeight: FontWeight.w400,
              ))),
      Container(
          width: 5,
          height: Interface.s26,
          alignment: Alignment.centerLeft,
          child: AutoSizeText(point,
              maxLines: 1,
              style: TextStyle(
                color: Interface.dark,
                fontSize: Interface.s14,
                fontWeight: FontWeight.w400,
              ))),
      Container(
          width: 25,
          height: Interface.s26,
          alignment: alignment,
          child: AutoSizeText(right,
              maxLines: 1,
              style: TextStyle(
                color: Interface.dark,
                fontSize: Interface.s14,
                fontWeight: FontWeight.w400,
              ))),
      Container(
          width: 15,
          height: Interface.s26,
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(right: 10),
          child: AutoSizeText(percent,
              maxLines: 1,
              style: TextStyle(
                color: Interface.dark,
                fontSize: Interface.s14,
                fontWeight: FontWeight.w400,
              )))
    ]);
  }

  Widget _buildWidgets() {
    return widget.fur.furId == Interface.greatOneId
        ? Container()
        : Row(mainAxisAlignment: MainAxisAlignment.spaceAround, mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
                width: 20,
                height: 10,
                alignment: Alignment.center,
                child: AnimatedContainer(
                    width: widget.fur.isChosen ? 20 : 10,
                    height: 10,
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 300),
                    decoration: ShapeDecoration(
                      color: widget.fur.color,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
                    ))),
            _showPerCent ? _buildWidgetPerCent() : Container(),
            Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: _showPerCent ? 0 : 20, right: 20),
                  child: AutoSizeText(widget.fur.getName(context.locale),
                      maxLines: 1,
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s20,
                        fontWeight: FontWeight.w400,
                      ))),
            ),
            Container(
                child: widget.fur.male
                    ? SvgPicture.asset(
                        "assets/graphics/icons/male.svg",
                        width: 15,
                        height: 15,
                        color: Interface.male,
                      )
                    : widget.fur.female
                        ? SvgPicture.asset(
                            "assets/graphics/icons/female.svg",
                            width: 15,
                            height: 15,
                            color: Interface.female,
                          )
                        : const SizedBox(
                            height: 15,
                            width: 15,
                          ))
          ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
