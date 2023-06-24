// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/types.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/builders/add_loadout/loadouts_items.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/model/loadout.dart';
import 'package:cotwcompanion/widgets/text.dart';
import 'package:cotwcompanion/widgets/title_functional.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:cotwcompanion/widgets/snackbar.dart';
import 'package:cotwcompanion/widgets/text_field.dart';
import 'package:cotwcompanion/widgets/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      _errorMessage = tr('error_no_name');
    } else if (!_correctName) {
      _errorMessage = tr('error_wrong_name');
    } else if (_selectedAmmo.isEmpty && _selectedCallers.isEmpty) {
      _errorMessage = tr('error_no_chosen_item');
    } else {
      _errorMessage = "";
    }
  }

  void _setItems(ObjectType type, List<int> list) {
    setState(() {
      if (type == ObjectType.ammo) {
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
              child: WidgetText(
                height: 25,
                text: ammo.getName(context.locale),
                color: Interface.dark,
              ));
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
              child: WidgetText(
                height: 25,
                text: caller.getName(context.locale),
                color: Interface.dark,
              ));
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
        duration: const Duration(milliseconds: 3000),
        padding: const EdgeInsets.all(0),
        backgroundColor: Interface.searchBackground,
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
    return Column(children: [
      WidgetTitle(text: tr('name')),
      WidgetTextField(
        numberOnly: false,
        correct: _correctName,
        controller: _controller,
        color: Interface.title,
        background: Interface.subSubTitleBackground,
      )
    ]);
  }

  Widget _buildWeaponsCallers() {
    return Column(children: [
      WidgetTitleFunctional.withButton(
          text: tr('weapons'),
          icon: "assets/graphics/icons/list.svg",
          textColor: Interface.title,
          background: Interface.subTitleBackground,
          iconColor: Interface.accent,
          buttonBackground: Interface.primary,
          isTitle: true,
          onTap: () {
            _focus();
            Navigator.push(context, MaterialPageRoute(builder: (context) => BuilderAddLoadoutItems(selected: _selectedAmmo, type: ObjectType.ammo, set: _setItems)));
          }),
      _listOfAmmo(),
      WidgetTitleFunctional.withButton(
          text: tr('callers'),
          icon: "assets/graphics/icons/list.svg",
          textColor: Interface.title,
          background: Interface.subTitleBackground,
          iconColor: Interface.accent,
          buttonBackground: Interface.primary,
          isTitle: true,
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
          _isNameCorrect();
          if (_errorMessage.isNotEmpty) {
            _buildSnackBar(_errorMessage);
          } else {
            setState(() {
              _scaffoldMessengerState.hideCurrentSnackBar();
            });
            Loadout loadout = _createLoadout();
            _editing ? HelperLoadout.editLoadout(loadout) : HelperLoadout.addLoadout(loadout);
            widget.callback();
            Navigator.pop(context);
          }
        },
        child: Container(
            height: 90,
            alignment: Alignment.center,
            color: Interface.primary,
            child: SvgPicture.asset(
              _editing ? "assets/graphics/icons/edit.svg" : "assets/graphics/icons/plus.svg",
              height: 20,
              width: 20,
              color: Interface.accent,
            )));
  }

  Widget _buildWidgets() {
    _scaffoldMessengerState = ScaffoldMessenger.of(context);
    return WidgetScaffold.withCustomBody(
        body: WidgetScrollbar(
            child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.max, children: [
      WidgetAppBar(
        text: _editing ? tr('edit') : tr('add'),
        fontSize: Interface.s30,
        context: context,
      ),
      _buildName(),
      _buildWeaponsCallers(),
      _buildAdd(),
    ]))));
  }

  @override
  Widget build(BuildContext context) {
    _reload();
    return _buildWidgets();
  }
}
