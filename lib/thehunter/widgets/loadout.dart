// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_loadout.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/activities/add_edit_loadout.dart';
import 'package:cotwcompanion/thehunter/model/caller.dart';
import 'package:cotwcompanion/thehunter/model/loadout.dart';
import 'package:cotwcompanion/thehunter/model/weapon.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_snackbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryLoadout extends StatefulWidget {
  final Loadout loadout;
  final int index;
  final Function callback;
  final BuildContext context;

  const EntryLoadout({Key? key, required this.loadout, required this.index, required this.callback, required this.context}) : super(key: key);

  @override
  EntryLoadoutState createState() => EntryLoadoutState();
}

class EntryLoadoutState extends State<EntryLoadout> {
  final Duration _duration = const Duration(milliseconds: 100);

  List<Weapon> _actualWeapons = [];
  List<Caller> _actualCallers = [];

  bool _detail = false;
  bool _detailText = false;
  bool _detailContainer = false;

  _hideSnackBar() {
    ScaffoldMessenger.of(widget.context).hideCurrentSnackBar();
  }

  _undo() {
    LoadoutHelper.undoRemove();
    _hideSnackBar();
    widget.callback();
  }

  _getLists() {
    _actualWeapons = [];
    _actualCallers = [];
    for (int i in widget.loadout.getWeapons) {
      _actualWeapons.add(findItem(i, true));
    }
    for (int i in widget.loadout.getCallers) {
      _actualCallers.add(findItem(i, false));
    }
    _actualWeapons.sort((a, b) => a.getNameAmmo(context.locale).compareTo(b.getNameAmmo(context.locale)));
    _actualCallers.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
  }

  dynamic findItem(int id, bool ammo) {
    if (ammo) {
      for (Weapon w in JSONHelper.weaponsInfo) {
        if (w.getAmmoID == id) return w;
      }
    } else {
      for (Caller c in JSONHelper.callers) {
        if (c.getID == id) return c;
      }
    }
  }

  Widget _buildName() {
    return Container(
        height: 90,
        padding: const EdgeInsets.only(left: 30, right: 30),
        color: widget.index % 2 == 0 ? Color(Values.colorEven) : Color(Values.colorOdd),
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
              child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            AutoSizeText(widget.loadout.getName, maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize24, fontWeight: FontWeight.w600)),
            Row(children: [
              Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: AutoSizeText("${tr("weapon_ammo")}: ${widget.loadout.getWeapons.length}",
                      style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize14, fontWeight: FontWeight.w400))),
              AutoSizeText("${tr("callers")}: ${widget.loadout.getCallers.length}",
                  style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize14, fontWeight: FontWeight.w400)),
            ])
          ])),
          WidgetSwitch(
              size: 40,
              isActive: LoadoutHelper.isActive(widget.loadout.getID),
              onTap: () {
                setState(() {
                  LoadoutHelper.activeLoadout.getID == widget.loadout.getID ? LoadoutHelper.useLoadout(-1) : LoadoutHelper.useLoadout(widget.loadout.getID);
                  widget.callback();
                });
              }),
        ]));
  }

  Widget _buildDetail() {
    _getLists();
    return AnimatedContainer(
        color: widget.index % 2 == 0 ? Color(Values.colorEven) : Color(Values.colorOdd),
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
        height: _detailContainer
            ? ((20 * _actualWeapons.length) + (20 * _actualCallers.length) + (_actualWeapons.isNotEmpty ? 40 : 0) + (_actualCallers.isNotEmpty ? 40 : 0))
            : 0,
        duration: _duration,
        child: AnimatedOpacity(
            opacity: _detailText ? 1 : 0,
            duration: _duration,
            child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, children: [
              _actualWeapons.isEmpty
                  ? Container()
                  : Container(
                      height: 20,
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(tr("weapon_ammo").toUpperCase(),
                          style: TextStyle(color: Color(Values.colorPrimary), fontSize: Values.fontSize20, fontWeight: FontWeight.w800, fontFamily: 'Title'))),
              _actualWeapons.isEmpty
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _actualWeapons.length,
                      itemBuilder: (context, index) {
                        return Container(
                            height: 20,
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(_actualWeapons[index].getNameAmmo(context.locale),
                                style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize14, fontWeight: FontWeight.w200)));
                      }),
              _actualCallers.isNotEmpty && _actualWeapons.isNotEmpty ? const SizedBox(height: 10) : Container(),
              _actualCallers.isEmpty
                  ? Container()
                  : Container(
                      height: 20,
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(tr("callers").toUpperCase(),
                          style: TextStyle(color: Color(Values.colorPrimary), fontSize: Values.fontSize20, fontWeight: FontWeight.w800, fontFamily: 'Title'))),
              _actualCallers.isEmpty
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _actualCallers.length,
                      itemBuilder: (context, index) {
                        return Container(
                            height: 20,
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(_actualCallers[index].getName(context.locale),
                                style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize14, fontWeight: FontWeight.w200)));
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
            LoadoutHelper.removeLoadoutOnIndex(widget.loadout.getID);
            _hideSnackBar();
            widget.callback();
          });
          ScaffoldMessenger.of(widget.context).showSnackBar(SnackBar(
              duration: const Duration(milliseconds: 5000),
              padding: const EdgeInsets.all(0),
              backgroundColor: Color(Values.colorSearchBackground),
              content: GestureDetector(
                  onTap: () {
                    _hideSnackBar();
                  },
                  child: WidgetSnackBar(
                      text: tr('item_removed'),
                      buttonIcon: "assets/graphics/icons/reload.svg",
                      buttonColor: Values.colorPrimary,
                      onTap: () {
                        _undo();
                      }))));
        },
        child: Dismissible(
            key: Key(widget.loadout.getID.toString()),
            direction: DismissDirection.startToEnd,
            confirmDismiss: (direction) async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ActivityLoadoutsAddEdit(toEdit: {
                            "id": widget.loadout.getID,
                            "name": widget.loadout.getName,
                            "weapons": widget.loadout.getWeapons,
                            "callers": widget.loadout.getCallers
                          }, callback: widget.callback)));
              return false;
            },
            background: Container(
                alignment: Alignment.centerLeft,
                color: const Color(Values.colorSeventh),
                child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: SvgPicture.asset(
                      "assets/graphics/icons/edit.svg",
                      height: 20,
                      width: 20,
                      color: Color(Values.colorAlwaysDark),
                      alignment: Alignment.centerLeft,
                    ))),
            child: Column(children: [_buildName(), _buildDetail()])));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
