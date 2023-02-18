// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_loadout.dart';
import 'package:cotwcompanion/helpers/helper_types.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/builders/add_loadout/loadouts_items.dart';
import 'package:cotwcompanion/thehunter/model/caller.dart';
import 'package:cotwcompanion/thehunter/model/loadout.dart';
import 'package:cotwcompanion/thehunter/model/weapon.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_name_with.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_without_dlc.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold_advanced.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_snackbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_textfield.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ActivityLoadoutsAddEdit extends StatefulWidget {
  final Function callback;
  final Map<String, dynamic> toEdit;

  const ActivityLoadoutsAddEdit({Key? key, required this.callback, this.toEdit = const {}}) : super(key: key);

  @override
  ActivityLoadoutsAddEditState createState() => ActivityLoadoutsAddEditState();
}

class ActivityLoadoutsAddEditState extends State<ActivityLoadoutsAddEdit> {
  final List<Weapon> _selectedWeapons = [];
  final List<Caller> _selectedCallers = [];

  final _controller = TextEditingController();

  int _loadoutID = 0;
  bool _correctName = false;
  String _errorMessage = "";

  bool _initialization = true;

  late ScaffoldMessengerState _scaffoldMessengerState;

  @override
  void initState() {
    _controller.addListener(() => _nameListener());
    super.initState();
  }

  @override
  void dispose() {
    _scaffoldMessengerState.clearSnackBars();
    super.dispose();
  }

  _getData() {
    if (_initialization) {
      if (widget.toEdit.isNotEmpty) {
        //WHEN EDITING LOADOUT
        _loadoutID = widget.toEdit["id"];
        _controller.text = widget.toEdit["name"];
        for (int w in widget.toEdit["weapons"]) {
          _selectedWeapons.add(JSONHelper.getWeaponAmmo(w));
        }
        for (int c in widget.toEdit["callers"]) {
          _selectedCallers.add(JSONHelper.getCaller(c));
        }
      }
      _initialization = false;
    }
    _nameListener();
  }

  _nameListener() {
    String s = _controller.text;
    RegExp regex = RegExp(r'^(\p{L}|[0-9_\-]){1,30}$', unicode: true);
    setState(() {
      if (regex.hasMatch(s)) {
        _correctName = true;
      } else {
        _correctName = false;
      }
    });
  }

  _focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  _check() {
    if (_controller.text.isEmpty) {
      _errorMessage = tr('error_no_name');
    } else if (!_correctName) {
      _errorMessage = tr('error_wrong_name');
    } else if (_selectedWeapons.isEmpty && _selectedCallers.isEmpty) {
      _errorMessage = tr('error_no_chosen_item');
    } else {
      _errorMessage = "";
    }
  }

  _setItems(ObjectType type, List<dynamic> d) {
    setState(() {
      if (type == ObjectType.weapon) {
        _selectedWeapons.clear();
        for (dynamic i in d) {
          _selectedWeapons.add(i);
        }
      } else {
        _selectedCallers.clear();
        for (dynamic i in d) {
          _selectedCallers.add(i);
        }
      }
    });
  }

  Widget _listOfWeapons() {
    _selectedWeapons.sort((a, b) => (a.getNameAmmo(context.locale).compareTo(b.getNameAmmo(context.locale))));
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _selectedWeapons.length,
        itemBuilder: (context, index) {
          return EntryWithoutDlc(
              padding: EdgeInsets.fromLTRB(30, index == 0 ? 30 : 5, 30, index == _selectedWeapons.length - 1 ? 30 : 5),
              text: _selectedWeapons[index].getNameAmmo(context.locale));
        });
  }

  Widget _listOfCallers() {
    _selectedCallers.sort((a, b) => (a.getName(context.locale).compareTo(b.getName(context.locale))));
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _selectedCallers.length,
        itemBuilder: (context, index) {
          return EntryWithoutDlc(
              padding: EdgeInsets.fromLTRB(30, index == 0 ? 30 : 5, 30, index == _selectedCallers.length - 1 ? 30 : 5),
              text: _selectedCallers[index].getName(context.locale));
        });
  }

  List<int> _weaponsIDs() {
    List<int> selectedIDs = [];
    for (dynamic d in _selectedWeapons) {
      selectedIDs.add(d.getAmmoID);
    }
    return selectedIDs;
  }

  List<int> _callersIDs() {
    List<int> selectedIDs = [];
    for (dynamic d in _selectedCallers) {
      selectedIDs.add(d.getID);
    }
    return selectedIDs;
  }

  Loadout _createLoadout() =>
      Loadout(id: widget.toEdit.isEmpty ? LoadoutHelper.loadouts.length : _loadoutID, name: _controller.text, weapons: _weaponsIDs(), callers: _callersIDs());

  _buildSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 3000),
        padding: const EdgeInsets.all(0),
        backgroundColor: Color(Values.colorSearchBackground),
        content: GestureDetector(
            onTap: () {
              setState(() {
                _scaffoldMessengerState.hideCurrentSnackBar();
              });
            },
            child: WidgetSnackBar(
              text: _errorMessage,
            ))));
  }

  Widget _buildName() {
    return Column(children: [WidgetTitle.sub(text: tr('name')), WidgetTextField(correct: _correctName, controller: _controller)]);
  }

  Widget _buildWeaponsCallers() {
    return Column(children: [
      EntryName.withTap(
          isTitle: true,
          text: tr('weapons'),
          size: 40,
          buttonIcon: "assets/graphics/icons/list.svg",
          background: Values.colorContentSubTitleBackground,
          onTap: () {
            _focus();
            Navigator.push(context, MaterialPageRoute(builder: (context) => BuilderAddLoadoutItems(selected: _selectedWeapons, type: ObjectType.weapon, set: _setItems)));
          }),
      _listOfWeapons(),
      EntryName.withTap(
          isTitle: true,
          text: tr('callers'),
          size: 40,
          buttonIcon: "assets/graphics/icons/list.svg",
          background: Values.colorContentSubTitleBackground,
          onTap: () {
            _focus();
            Navigator.push(context, MaterialPageRoute(builder: (context) => BuilderAddLoadoutItems(selected: _selectedCallers, type: ObjectType.caller, set: _setItems)));
          }),
      _listOfCallers(),
    ]);
  }

  Widget _buildAdd() {
    return GestureDetector(
        onTap: () {
          _focus();
          _check();
          if (_errorMessage.isNotEmpty) {
            _buildSnackBar(_errorMessage);
          } else {
            setState(() {
              _scaffoldMessengerState.hideCurrentSnackBar();
            });
            Loadout loadout = _createLoadout();
            widget.toEdit.isEmpty ? LoadoutHelper.addLoadout(loadout) : LoadoutHelper.editLoadout(loadout);
            widget.callback();
            Navigator.pop(context);
          }
        },
        child: Container(
            height: 90,
            alignment: Alignment.center,
            color: Color(Values.colorPrimary),
            child: SvgPicture.asset(widget.toEdit.isEmpty ? "assets/graphics/icons/plus.svg" : "assets/graphics/icons/edit.svg",
                height: 20, width: 20, color: Color(Values.colorAccent))));
  }

  Widget _buildWidgets() {
    _scaffoldMessengerState = ScaffoldMessenger.of(context);
    return WidgetScaffoldAdvanced(
        body: Column(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          child: Stack(children: [
        SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
          WidgetAppBar(
            text: widget.toEdit.isEmpty ? tr('add') : tr('edit'),
            fontSize: Values.fontSize30,
            function: () {
              Navigator.pop(context);
            },
          ),
          _buildName(),
          _buildWeaponsCallers(),
          _buildAdd()
        ]))
      ]))
    ]));
  }

  @override
  Widget build(BuildContext context) {
    _getData();
    return _buildWidgets();
  }
}
