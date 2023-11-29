// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/activities/edit/counters.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/enumerator.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/model/enumerator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryCounter extends StatefulWidget {
  final int index;
  final Enumerator enumerator;
  final Counter counter;
  final Function callback;
  final BuildContext context;

  final double height = 70;

  const EntryCounter({
    Key? key,
    required this.index,
    required this.enumerator,
    required this.counter,
    required this.callback,
    required this.context,
    dismissible = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EntryCounterState();
}

class EntryCounterState extends State<EntryCounter> {
  final double _editIconSize = 20;

  void _buildSnackBar(String message, Process process) {
    ScaffoldMessenger.of(context).showSnackBar(
      Utils.snackBarUndo(
        _hideSnackBar,
        message,
        process,
        _undo,
      ),
    );
  }

  void _hideSnackBar() {
    ScaffoldMessenger.of(widget.context).hideCurrentSnackBar();
  }

  void _startToEnd() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ActivityEditCounters(enumerator: widget.enumerator, counter: widget.counter, callback: widget.callback)));
  }

  void _endToStart() {
    setState(() {
      HelperEnumerator.removeCounterOnIndex(widget.enumerator.id, widget.index);
      _hideSnackBar();
      widget.callback();
    });
    _buildSnackBar(
      tr("item_removed"),
      Process.info,
    );
  }

  void _undo() {
    HelperEnumerator.undoRemoveCounter(widget.enumerator.id);
    _hideSnackBar();
    widget.callback();
  }

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          setState(() {
            widget.counter.add();
            widget.callback();
          });
        },
        onDoubleTap: () {
          setState(() {
            widget.counter.subtract();
            widget.callback();
          });
        },
        child: Dismissible(
          key: Key(widget.key.toString()),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              _startToEnd();
            } else {
              _endToStart();
            }
            return false;
          },
          background: Container(
              alignment: Alignment.centerLeft,
              color: Interface.dark,
              child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SvgPicture.asset(
                    "assets/graphics/icons/edit.svg",
                    width: _editIconSize,
                    height: _editIconSize,
                    alignment: Alignment.centerLeft,
                    colorFilter: ColorFilter.mode(
                      Interface.light,
                      BlendMode.srcIn,
                    ),
                  ))),
          secondaryBackground: Container(
              alignment: Alignment.centerRight,
              color: Interface.red,
              child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SvgPicture.asset(
                    "assets/graphics/icons/remove_bin.svg",
                    width: _editIconSize,
                    height: _editIconSize,
                    alignment: Alignment.centerRight,
                    colorFilter: const ColorFilter.mode(
                      Interface.alwaysDark,
                      BlendMode.srcIn,
                    ),
                  ))),
          child: Container(
              height: widget.height,
              color: Utils.background(widget.index),
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                children: [
                  Expanded(
                    child: AutoSizeText(
                      widget.counter.name,
                      maxLines: 1,
                      style: Interface.s18w500n(Interface.dark),
                    ),
                  ),
                  AutoSizeText(
                    widget.counter.value.toString(),
                    maxLines: 1,
                    style: Interface.s16w300n(Interface.dark),
                  )
                ],
              )),
        ));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
