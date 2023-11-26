// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/lists/add_edit_loadout/loadouts_items.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/model/loadout.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:cotwcompanion/widgets/snackbar.dart';
import 'package:cotwcompanion/widgets/text_field_indicator.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:cotwcompanion/widgets/title_big_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class ActivityLoadoutsAddEdit extends StatefulWidget {
  final Function callback;
  final Loadout? loadout;

  const ActivityLoadoutsAddEdit({
    Key? key,
    required this.callback,
    this.loadout,
  }) : super(key: key);

  @override
  ActivityLoadoutsAddEditState createState() => ActivityLoadoutsAddEditState();
}

class ActivityLoadoutsAddEditState extends State<ActivityLoadoutsAddEdit> {
  final TextEditingController _controller = TextEditingController();
  final RegExp _nameRegex = RegExp(r'^(\p{L}|[\d_\-]){1,30}$', unicode: true);
  final List<int> _selectedAmmo = [];
  final List<int> _selectedCallers = [];
  final double _addButtonSize = 60;
  final double _safeSpaceHeight = 100;

  late ScaffoldMessengerState _scaffoldMessengerState;

  bool _editing = false;
  bool _correctName = false;
  String _errorMessage = "";

  @override
  void initState() {
    _controller.addListener(() => _reload());
    _getData();
    super.initState();
  }

  @override
  void dispose() {
    _scaffoldMessengerState.clearSnackBars();
    super.dispose();
  }

  void _getData() {
    _selectedAmmo.clear();
    _selectedCallers.clear();
    if (widget.loadout != null) {
      //WHEN EDITING LOADOUT
      _editing = true;
      _controller.text = widget.loadout!.name;
      _selectedAmmo.addAll(widget.loadout!.ammo);
      _selectedCallers.addAll(widget.loadout!.callers);
    }
  }

  void _reload() {
    setState(() {
      _correctName = _nameRegex.hasMatch(_controller.text);
    });
  }

  void _focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _isNameCorrect() {
    if (_controller.text.isEmpty) {
      _errorMessage = tr("error_no_name");
    } else if (!_correctName) {
      _errorMessage = tr("error_wrong_name");
    } else if (_selectedAmmo.isEmpty && _selectedCallers.isEmpty) {
      _errorMessage = tr("error_no_chosen_item");
    } else {
      _errorMessage = "";
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
    int loadoutId = _editing ? widget.loadout!.id : HelperLoadout.loadouts.length;
    Loadout loadout = Loadout(id: loadoutId, name: _controller.text);
    loadout.setAmmo = _selectedAmmo;
    loadout.setCallers = _selectedCallers;
    return loadout;
  }

  void _buildSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 5000),
        padding: const EdgeInsets.all(0),
        backgroundColor: Interface.search,
        content: GestureDetector(
            onTap: () {
              setState(() {
                _scaffoldMessengerState.hideCurrentSnackBar();
              });
            },
            child: WidgetSnackBar(
              text: _errorMessage,
              process: Process.error,
            ))));
  }

  Widget _buildName() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("name"),
      ),
      WidgetTextFieldIndicator(
        numberOnly: false,
        correct: _correctName,
        controller: _controller,
      )
    ]);
  }

  Widget _buildWeaponsCallers() {
    return Column(children: [
      WidgetTitleBigButton(
        primaryText: tr("weapons"),
        icon: "assets/graphics/icons/menu_open.svg",
        onTap: () {
          _focus();
          Navigator.push(context, MaterialPageRoute(builder: (context) => ListLoadoutItems(selected: _selectedAmmo, type: Item.ammo, set: _setItems)));
        },
      ),
      _listOfAmmo(),
      WidgetTitleBigButton(
        primaryText: tr("callers"),
        icon: "assets/graphics/icons/menu_open.svg",
        onTap: () {
          _focus();
          Navigator.push(context, MaterialPageRoute(builder: (context) => ListLoadoutItems(selected: _selectedCallers, type: Item.caller, set: _setItems)));
        },
      ),
      _listOfCallers(),
    ]);
  }

  Widget _buildAdd() {
    return Positioned(
        bottom: 30,
        right: 30,
        child: SimpleShadow(
            sigma: 7,
            color: Interface.alwaysDark,
            child: WidgetButtonIcon(
              buttonSize: _addButtonSize,
              icon: _editing ? "assets/graphics/icons/edit.svg" : "assets/graphics/icons/plus.svg",
              onTap: () {
                _focus();
                _isNameCorrect();
                if (_errorMessage.isNotEmpty) {
                  _buildSnackBar(_errorMessage);
                } else {
                  setState(() {
                    _scaffoldMessengerState.hideCurrentSnackBar();
                  });
                  Loadout loadout = _createLoadout();
                  _editing ? HelperLoadout.editItem(loadout) : HelperLoadout.addItem(loadout);
                  widget.callback();
                  Navigator.pop(context);
                }
              },
            )));
  }

  Widget _buildStack() {
    return Stack(fit: StackFit.expand, children: [
      WidgetScrollbar(
          child: SingleChildScrollView(
              child: Column(children: [
        WidgetAppBar(
          text: _editing ? tr("edit") : tr("add"),
          context: context,
        ),
        _buildName(),
        _buildWeaponsCallers(),
        SizedBox(
          height: _safeSpaceHeight,
        ),
      ]))),
      _buildAdd(),
    ]);
  }

  Widget _buildWidgets() {
    _reload();
    _scaffoldMessengerState = ScaffoldMessenger.of(context);
    return WidgetScaffold(
      customBody: true,
      body: _buildStack(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
