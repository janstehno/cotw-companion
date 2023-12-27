// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/model/enumerator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class EntryEnumeratorEntry extends StatefulWidget {
  final int index;
  final Enumerator enumerator;
  final Function callback;
  final BuildContext context;

  final double height = 70;

  const EntryEnumeratorEntry({
    Key? key,
    required this.index,
    required this.enumerator,
    required this.callback,
    required this.context,
  }) : super(key: key);
}

abstract class EntryEnumeratorEntryState extends State<EntryEnumeratorEntry> {
  final double _editIconSize = 20;

  void undo() {}

  void onTap() {}

  void onDoubleTap() {}

  void startToEnd() {}

  void endToStart() {
    Utils.buildSnackBarUndo(
      tr("item_removed"),
      Process.info,
      undo,
      widget.context,
    );
  }

  Widget buildEntry() => Container();

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        child: Dismissible(
          key: Key(widget.key.toString()),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              startToEnd();
            } else {
              endToStart();
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
            child: buildEntry(),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
