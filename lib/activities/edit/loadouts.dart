// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/activities/edit/edit.dart';
import 'package:cotwcompanion/lists/add_edit_loadout/loadouts_items.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/model/loadout.dart';
import 'package:cotwcompanion/widgets/title_big_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityEditLoadouts extends ActivityEdit {
  final Loadout? loadout;

  const ActivityEditLoadouts({
    super.key,
    required super.callback,
    this.loadout,
  });

  @override
  ActivityEditLoadoutsState createState() => ActivityEditLoadoutsState();
}

class ActivityEditLoadoutsState extends ActivityEditState {
  final List<int> _selectedAmmo = [];
  final List<int> _selectedCallers = [];

  @override
  void getData() {
    _selectedAmmo.clear();
    _selectedCallers.clear();
    if ((widget as ActivityEditLoadouts).loadout != null) {
      //WHEN EDITING
      editing = true;
      controller.text = (widget as ActivityEditLoadouts).loadout!.name;
      _selectedAmmo.addAll((widget as ActivityEditLoadouts).loadout!.ammo);
      _selectedCallers.addAll((widget as ActivityEditLoadouts).loadout!.callers);
    }
  }

  @override
  void checkData() {
    if (controller.text.isEmpty) {
      errorMessage = tr("error_no_name");
    } else if (!correctName) {
      errorMessage = tr("error_wrong_name");
    } else if (_selectedAmmo.isEmpty && _selectedCallers.isEmpty) {
      errorMessage = tr("error_no_chosen_item");
    } else {
      errorMessage = "";
    }
  }

  void _setItems(Item type, List<int> list) {
    setState(() {
      if (type == Item.ammo) {
        _selectedAmmo.clear();
        _selectedAmmo.addAll(list);
      } else {
        _selectedCallers.clear();
        _selectedCallers.addAll(list);
      }
    });
  }

  Widget _listOfAmmo() {
    Ammo ammo;
    _selectedAmmo.sort((a, b) {
      String nameA = HelperJSON.getAmmo(a).getName(context.locale);
      String nameB = HelperJSON.getAmmo(b).getName(context.locale);
      return (nameA.compareTo(nameB));
    });
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _selectedAmmo.length,
        itemBuilder: (context, index) {
          ammo = HelperJSON.getAmmo(_selectedAmmo[index]);
          return Container(
            padding: EdgeInsets.only(top: index == 0 ? 25 : 2, bottom: index == _selectedAmmo.length - 1 ? 25 : 2),
            child: Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: AutoSizeText(
                  ammo.getName(context.locale),
                  style: Interface.s16w300n(Interface.dark),
                )),
          );
        });
  }

  Widget _listOfCallers() {
    Caller caller;
    _selectedCallers.sort((a, b) {
      String nameA = HelperJSON.getCaller(a).getName(context.locale);
      String nameB = HelperJSON.getCaller(b).getName(context.locale);
      return (nameA.compareTo(nameB));
    });
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _selectedCallers.length,
        itemBuilder: (context, index) {
          caller = HelperJSON.getCaller(_selectedCallers[index]);
          return Container(
            padding: EdgeInsets.only(top: index == 0 ? 25 : 2, bottom: index == _selectedCallers.length - 1 ? 25 : 2),
            child: Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: AutoSizeText(
                  caller.getName(context.locale),
                  style: Interface.s16w300n(Interface.dark),
                )),
          );
        });
  }

  Loadout _createLoadout() {
    Loadout? loadout = (widget as ActivityEditLoadouts).loadout;
    int loadoutId = editing ? loadout!.id : HelperLoadout.loadouts.length;
    loadout = Loadout(id: loadoutId, name: controller.text, ammo: _selectedAmmo, callers: _selectedCallers);
    return loadout;
  }

  Widget _buildWeaponsCallers() {
    return Column(children: [
      WidgetTitleBigButton(
        primaryText: tr("weapons"),
        icon: "assets/graphics/icons/menu_open.svg",
        onTap: () {
          focus();
          Navigator.push(context, MaterialPageRoute(builder: (context) => ListLoadoutItems(selected: _selectedAmmo, type: Item.ammo, set: _setItems)));
        },
      ),
      _listOfAmmo(),
      WidgetTitleBigButton(
        primaryText: tr("callers"),
        icon: "assets/graphics/icons/menu_open.svg",
        onTap: () {
          focus();
          Navigator.push(context, MaterialPageRoute(builder: (context) => ListLoadoutItems(selected: _selectedCallers, type: Item.caller, set: _setItems)));
        },
      ),
      _listOfCallers(),
    ]);
  }

  @override
  void addOrEdit() {
    Loadout loadout = _createLoadout();
    editing ? HelperLoadout.editLoadout(loadout) : HelperLoadout.addLoadout(loadout);
  }

  @override
  Widget buildBody() {
    return Column(
      children: [
        buildName(),
        _buildWeaponsCallers(),
      ],
    );
  }
}
