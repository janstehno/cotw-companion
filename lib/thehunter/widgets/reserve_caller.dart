// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/model/caller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EntryReserveCaller extends StatefulWidget {
  final int callerID;
  final double height;
  final int? color;
  final int? background;
  final Function onTap;

  const EntryReserveCaller({Key? key, required this.callerID, this.height = 60, this.color, this.background, required this.onTap}) : super(key: key);

  @override
  State<StatefulWidget> createState() => EntryReserveCallerState();
}

class EntryReserveCallerState extends State<EntryReserveCaller> {
  late final Caller _caller;

  @override
  void initState() {
    _caller = JSONHelper.getCaller(widget.callerID);
    super.initState();
  }

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          widget.onTap();
        },
        child: Container(
            height: widget.height,
            color: Color(widget.background ?? Values.colorLight),
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(right: 30),
                      child: AutoSizeText(_caller.getName(context.locale),
                          maxLines: 1, style: TextStyle(color: Color(widget.color ?? Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)))),
              Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: _caller.getDlc
                      ? Container(
                          height: 9,
                          width: 9,
                          decoration: BoxDecoration(
                              color: Color(Values.colorPrimary),
                              border: Border.all(color: Color(Values.colorAccentBorder), width: Values.widthAccentBorder),
                              borderRadius: BorderRadius.circular(5)))
                      : Container(width: 9))
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
