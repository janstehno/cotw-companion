// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/model/animal_fur.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
    if (widget.fur.perCent != 0 && widget.fur.rarity != 4) {
      left = widget.fur.perCent.toString().split(".")[0];
      right = widget.fur.perCent.toString().split(".")[1];
      point = ".";
      percent = "%";
    }
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: 58,
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(left: 5, right: 10),
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

  Widget _buildAnimalFur() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: 20,
          height: 10,
          alignment: Alignment.center,
          child: AnimatedContainer(
              width: widget.fur.isChosen ? 20 : 10,
              height: 10,
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 200),
              decoration: ShapeDecoration(
                color: widget.fur.color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.3)),
              ))),
      _showPerCent ? _buildWidgetPerCent() : const SizedBox.shrink(),
      Expanded(
        child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: _showPerCent ? 0 : 20, right: 20),
            child: AutoSizeText(
              widget.fur.getName(context.locale),
              maxLines: 1,
              style: Interface.s16w300n(Interface.dark),
            )),
      ),
      Container(
          child: widget.fur.male
              ? SvgPicture.asset(
                  "assets/graphics/icons/gender_male.svg",
                  width: 13,
                  height: 13,
                  colorFilter: const ColorFilter.mode(
                    Interface.male,
                    BlendMode.srcIn,
                  ),
                )
              : widget.fur.female
                  ? SvgPicture.asset(
                      "assets/graphics/icons/gender_female.svg",
                      width: 14,
                      height: 14,
                      colorFilter: const ColorFilter.mode(
                        Interface.female,
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
    return widget.fur.furId != Interface.greatOneId
        ? Container(
            margin: const EdgeInsets.only(bottom: 3),
            child: _buildAnimalFur(),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
