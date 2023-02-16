// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryTrophyWithUnknown extends StatefulWidget {
  final String text;
  final String icon;
  final double iconSize;
  final bool imperialUnits;
  final bool isValueKnown;
  final bool alignIconLeft;

  const EntryTrophyWithUnknown(
      {Key? key, required this.text, required this.icon, this.iconSize = 17, this.imperialUnits = false, required this.isValueKnown, this.alignIconLeft = false})
      : super(key: key);

  @override
  EntryTrophyWithUnknownState createState() => EntryTrophyWithUnknownState();
}

class EntryTrophyWithUnknownState extends State<EntryTrophyWithUnknown> {
  Widget _buildTrophyUnknownRight() {
    return Stack(children: [
      widget.isValueKnown
          ? Row(children: [
              Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10.0)), color: Color(Values.colorMaximum)),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: AutoSizeText(widget.text,
                      maxLines: 1, textAlign: TextAlign.center, style: TextStyle(color: Colors.transparent, fontSize: Values.fontSize24, fontWeight: FontWeight.w600))),
              Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10.0)), color: Color(Values.colorMaximumIcon)),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: SvgPicture.asset(
                        widget.icon,
                        height: widget.iconSize,
                        width: widget.iconSize,
                        color: Color(Values.colorDark),
                      ))),
            ])
          : Container(),
      Row(children: [
        Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10.0)), color: Color(Values.colorMaximum)),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: AutoSizeText(widget.text,
                maxLines: 1, textAlign: TextAlign.center, style: TextStyle(color: Color(Values.colorAccent), fontSize: Values.fontSize24, fontWeight: FontWeight.w600))),
        widget.isValueKnown
            ? Container(
                alignment: Alignment.centerRight,
                child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0)), color: Colors.transparent),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: SizedBox(
                      width: widget.iconSize,
                      height: widget.iconSize,
                    )))
            : Container()
      ])
    ]);
  }

  Widget _buildTrophyUnknownLeft() {
    return Stack(children: [
      widget.isValueKnown
          ? Row(children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10.0)), color: Color(Values.colorMaximumIcon)),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: SvgPicture.asset(
                        widget.icon,
                        height: widget.iconSize,
                        width: widget.iconSize,
                        color: Color(Values.colorDark),
                      ))),
              Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0)), color: Colors.transparent),
                  child: AutoSizeText(widget.text,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(Values.colorAccent), fontSize: Values.fontSize24, fontWeight: FontWeight.w600))),
            ])
          : Container(),
      Row(children: [
        widget.isValueKnown
            ? Container(
                alignment: Alignment.centerLeft,
                child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0)), color: Colors.transparent),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: SizedBox(
                      width: widget.iconSize,
                      height: widget.iconSize,
                    )))
            : Container(),
        Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10.0)), color: Color(Values.colorMaximum)),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: AutoSizeText(widget.text,
                maxLines: 1, textAlign: TextAlign.center, style: TextStyle(color: Color(Values.colorAccent), fontSize: Values.fontSize24, fontWeight: FontWeight.w600))),
      ])
    ]);
  }

  Widget _buildWidgets() {
    return Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10.0)), color: Color(Values.colorMaximumIcon)),
        margin: const EdgeInsets.only(right: 10),
        child: widget.alignIconLeft ? _buildTrophyUnknownLeft() : _buildTrophyUnknownRight());
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
