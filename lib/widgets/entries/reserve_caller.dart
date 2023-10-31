// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EntryReserveCaller extends StatefulWidget {
  final int callerId;
  final Color color, background;
  final Function onTap;
  final double height = 60;

  const EntryReserveCaller({
    Key? key,
    required this.callerId,
    required this.color,
    required this.background,
    required this.onTap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EntryReserveCallerState();
}

class EntryReserveCallerState extends State<EntryReserveCaller> {
  final double _dotSize = 10;

  late final Caller _caller;

  @override
  void initState() {
    _caller = HelperJSON.getCaller(widget.callerId);
    super.initState();
  }

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          widget.onTap();
        },
        child: Container(
            height: widget.height,
            color: widget.background,
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(right: 30),
                      child: AutoSizeText(
                        _caller.getName(context.locale),
                        maxLines: 1,
                        style: Interface.s16w300n(Interface.dark),
                      ))),
              Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: _caller.isFromDlc
                      ? Container(
                          height: _dotSize,
                          width: _dotSize,
                          decoration: BoxDecoration(
                            color: Interface.primary,
                            border: Border.all(
                              color: Interface.accentBorder,
                              width: Interface.accentBorderWidth,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ))
                      : Container(
                          width: _dotSize,
                        ))
            ])));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
