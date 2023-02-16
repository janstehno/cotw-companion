// Copyright (c) 2022 Jan Stehno

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_settings.dart';
import 'package:cotwcompanion/thehunter/model/animal_fur.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';

class EntryAnimalFur extends StatefulWidget {
  final AnimalFur fur;

  const EntryAnimalFur({Key? key, required this.fur}) : super(key: key);

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
    String left = widget.fur.getPerCent.toString().split(".")[0];
    String right = widget.fur.getPerCent.toString().split(".")[1];
    String point = ".";
    String percent = "%";
    Alignment alignment = Alignment.centerLeft;
    if (right.length == 1) {
      right += "00";
    } else if (right.length == 2) {
      right += "0";
    }
    if (widget.fur.getPerCent == 0) {
      left = "";
      right = "...";
      point = "";
      alignment = Alignment.centerRight;
    }
    if (widget.fur.getRarity == 0) {
      left = "";
      right = "";
      point = "";
      percent = "";
      alignment = Alignment.centerRight;
    }
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: 15,
          height: Values.fontSize26,
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(left: 10),
          child: AutoSizeText(left, maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize14, fontWeight: FontWeight.w400))),
      Container(
          width: 5,
          height: Values.fontSize26,
          alignment: Alignment.centerLeft,
          child: AutoSizeText(point, maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize14, fontWeight: FontWeight.w400))),
      Container(
          width: 25,
          height: Values.fontSize26,
          alignment: alignment,
          child: AutoSizeText(right, maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize14, fontWeight: FontWeight.w400))),
      Container(
          width: 15,
          height: Values.fontSize26,
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(right: 10),
          child: AutoSizeText(percent, maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize14, fontWeight: FontWeight.w400)))
    ]);
  }

  Widget _buildWidgets() {
    return widget.fur.getFurID == Values.greatOneID
        ? Container()
        : Row(mainAxisAlignment: MainAxisAlignment.spaceAround, mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
                width: 20,
                height: 10,
                alignment: Alignment.center,
                child: AnimatedContainer(
                    width: widget.fur.getChosen ? 20 : 10,
                    height: 10,
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 300),
                    decoration: ShapeDecoration(
                      color: Color(widget.fur.getColor()),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
                    ))),
            _showPerCent ? _buildWidgetPerCent() : Container(),
            Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: _showPerCent ? 0 : 20, right: 20),
                  child: AutoSizeText(widget.fur.getName(context.locale),
                      maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400))),
            ),
            Container(
                child: widget.fur.getMale
                    ? SvgPicture.asset(
                        "assets/graphics/icons/male.svg",
                        width: 15,
                        height: 15,
                        color: Color(Values.colorMale),
                      )
                    : widget.fur.getFemale
                        ? SvgPicture.asset(
                            "assets/graphics/icons/female.svg",
                            width: 15,
                            height: 15,
                            color: Color(Values.colorFemale),
                          )
                        : const SizedBox(height: 15, width: 15))
          ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
