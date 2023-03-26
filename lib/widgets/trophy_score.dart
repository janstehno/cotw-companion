// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetTrophyScore extends StatefulWidget {
  final String text, icon;
  final bool isValueKnown, isImperialValue, alignIconLeft;
  final double iconSize;

  const WidgetTrophyScore.withUnknown({
    Key? key,
    required this.text,
    required this.icon,
    required this.isValueKnown,
    this.iconSize = 17,
    this.isImperialValue = false,
    this.alignIconLeft = false,
  }) : super(key: key);

  @override
  WidgetTrophyScoreState createState() => WidgetTrophyScoreState();
}

class WidgetTrophyScoreState extends State<WidgetTrophyScore> {
  Widget _buildTrophyUnknownRight() {
    return Stack(children: [
      widget.isValueKnown
          ? Row(children: [
              Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    color: Interface.maximum,
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: AutoSizeText(widget.text,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.transparent,
                        fontSize: Interface.s24,
                        fontWeight: FontWeight.w600,
                      ))),
              Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        color: Interface.maximumIcon,
                      ),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: SvgPicture.asset(
                        widget.icon,
                        height: widget.iconSize,
                        width: widget.iconSize,
                        color: Interface.dark,
                      ))),
            ])
          : Container(),
      Row(children: [
        Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: Interface.maximum,
            ),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: AutoSizeText(widget.text,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Interface.accent,
                  fontSize: Interface.s24,
                  fontWeight: FontWeight.w600,
                ))),
        widget.isValueKnown
            ? Container(
                alignment: Alignment.centerRight,
                child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.transparent,
                    ),
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
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        color: Interface.maximumIcon,
                      ),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: SvgPicture.asset(
                        widget.icon,
                        height: widget.iconSize,
                        width: widget.iconSize,
                        color: Interface.dark,
                      ))),
              Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.transparent,
                  ),
                  child: AutoSizeText(widget.text,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Interface.accent,
                        fontSize: Interface.s24,
                        fontWeight: FontWeight.w600,
                      ))),
            ])
          : Container(),
      Row(children: [
        widget.isValueKnown
            ? Container(
                alignment: Alignment.centerLeft,
                child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.transparent,
                    ),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: SizedBox(
                      width: widget.iconSize,
                      height: widget.iconSize,
                    )))
            : Container(),
        Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: Interface.maximum,
            ),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: AutoSizeText(widget.text,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Interface.accent,
                  fontSize: Interface.s24,
                  fontWeight: FontWeight.w600,
                ))),
      ])
    ]);
  }

  Widget _buildWidgets() {
    return Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          color: Interface.maximumIcon,
        ),
        margin: const EdgeInsets.only(right: 10),
        child: widget.alignIconLeft ? _buildTrophyUnknownLeft() : _buildTrophyUnknownRight());
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
