// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/activities/loadouts_add_edit.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/model/loadout.dart';
import 'package:cotwcompanion/widgets/snackbar.dart';
import 'package:cotwcompanion/widgets/switch_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryLoadout extends StatefulWidget {
  final int index;
  final Loadout loadout;
  final Function callback;
  final BuildContext context;

  const EntryLoadout({
    Key? key,
    required this.index,
    required this.loadout,
    required this.callback,
    required this.context,
  }) : super(key: key);

  @override
  EntryLoadoutState createState() => EntryLoadoutState();
}

class EntryLoadoutState extends State<EntryLoadout> {
  final Duration _duration = const Duration(milliseconds: 200);

  List<Ammo> _ammo = [];
  List<Caller> _callers = [];

  bool _detail = false;
  bool _detailText = false;
  bool _detailContainer = false;

  _hideSnackBar() {
    ScaffoldMessenger.of(widget.context).hideCurrentSnackBar();
  }

  _undo() {
    HelperLoadout.undoRemove();
    _hideSnackBar();
    widget.callback();
  }

  _getLists() {
    _ammo = [];
    _callers = [];
    for (int index in widget.loadout.ammo) {
      _ammo.add(HelperJSON.getAmmo(index));
    }
    for (int index in widget.loadout.callers) {
      _callers.add(HelperJSON.getCaller(index));
    }
    _ammo.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
    _callers.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
  }

  Widget _buildName() {
    return Container(
        height: 70,
        color: widget.index % 2 == 0 ? Interface.even : Interface.odd,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Row(children: [
          Expanded(
              child: Container(
                  margin: const EdgeInsets.only(right: 30),
                  child: AutoSizeText(
                    widget.loadout.name,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: Interface.s18w300n(Interface.dark),
                  ))),
          WidgetSwitchIcon(
            isActive: HelperLoadout.isActive(widget.loadout.id),
            onTap: () {
              setState(() {
                HelperLoadout.activeLoadout.id == widget.loadout.id ? HelperLoadout.useLoadout(-1) : HelperLoadout.useLoadout(widget.loadout.id);
                widget.callback();
              });
            },
          )
        ]));
  }

  Widget _buildDetail() {
    _getLists();
    return AnimatedContainer(
        color: widget.index % 2 == 0 ? Interface.even : Interface.odd,
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
        height: _detailContainer ? ((20 * _ammo.length) + (20 * _callers.length) + (_ammo.isNotEmpty ? 40 : 0) + (_callers.isNotEmpty ? 40 : 0)) : 0,
        duration: _duration,
        child: AnimatedOpacity(
            opacity: _detailText ? 1 : 0,
            duration: _duration,
            child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, children: [
              _ammo.isEmpty
                  ? const SizedBox.shrink()
                  : Container(
                      height: 20,
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        tr("weapon_ammo"),
                        style: Interface.s14w300n(Interface.dark),
                      )),
              _ammo.isEmpty
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _ammo.length,
                      itemBuilder: (context, index) {
                        return Container(
                            height: 20,
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              _ammo[index].getName(context.locale),
                              style: Interface.s12w300n(Interface.dark.withOpacity(0.75)),
                            ));
                      }),
              _callers.isNotEmpty && _ammo.isNotEmpty ? const SizedBox(height: 10) : const SizedBox.shrink(),
              _callers.isEmpty
                  ? const SizedBox.shrink()
                  : Container(
                      height: 20,
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        tr("callers"),
                        style: Interface.s14w300n(Interface.dark),
                      )),
              _callers.isEmpty
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _callers.length,
                      itemBuilder: (context, index) {
                        return Container(
                            height: 20,
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              _callers[index].getName(context.locale),
                              style: Interface.s12w300n(Interface.dark.withOpacity(0.75)),
                            ));
                      }),
            ])));
  }

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          setState(() {
            if (_detail) {
              _detailText = false;
              Future.delayed(_duration, () {
                setState(() {
                  _detailContainer = false;
                });
              });
            } else {
              _detailContainer = true;
              Future.delayed(_duration, () {
                setState(() {
                  _detailText = true;
                });
              });
            }
            _detail = !_detail;
            widget.callback();
          });
        },
        onDoubleTap: () {
          setState(() {
            HelperLoadout.removeLoadoutOnIndex(widget.loadout.id);
            _hideSnackBar();
            widget.callback();
          });
          ScaffoldMessenger.of(widget.context).showSnackBar(SnackBar(
              duration: const Duration(milliseconds: 5000),
              padding: const EdgeInsets.all(0),
              backgroundColor: Interface.search,
              content: GestureDetector(
                  onTap: () {
                    _hideSnackBar();
                  },
                  child: WidgetSnackBar(
                    text: tr('item_removed'),
                    icon: "assets/graphics/icons/reload.svg",
                    process: Process.info,
                    onSnackBarTap: () {
                      _undo();
                    },
                  ))));
        },
        child: Dismissible(
            key: Key(widget.loadout.id.toString()),
            direction: DismissDirection.startToEnd,
            confirmDismiss: (direction) async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ActivityLoadoutsAddEdit(
                            loadout: widget.loadout,
                            callback: widget.callback,
                          )));
              return false;
            },
            background: Container(
                alignment: Alignment.centerLeft,
                color: Interface.green,
                child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: SvgPicture.asset(
                      "assets/graphics/icons/edit.svg",
                      height: 20,
                      width: 20,
                      alignment: Alignment.centerLeft,
                      colorFilter: const ColorFilter.mode(
                        Interface.alwaysDark,
                        BlendMode.srcIn,
                      ),
                    ))),
            child: Column(children: [
              _buildName(),
              _buildDetail(),
            ])));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
