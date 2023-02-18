// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_filter.dart';
import 'package:cotwcompanion/helpers/helper_loadout.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/activities/add_edit_loadout.dart';
import 'package:cotwcompanion/thehunter/model/loadout.dart';
import 'package:cotwcompanion/thehunter/widgets/loadout.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_button.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold_advanced.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_searchbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_snackbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ActivityLoadouts extends StatefulWidget {
  const ActivityLoadouts({Key? key}) : super(key: key);

  @override
  ActivityLoadoutsState createState() => ActivityLoadoutsState();
}

class ActivityLoadoutsState extends State<ActivityLoadouts> {
  final List<Loadout> _filtered = [];

  final _controller = TextEditingController();

  bool _fileOptionsOpened = false;

  late ScaffoldMessengerState _scaffoldMessengerState;

  @override
  void initState() {
    _filtered.addAll(LoadoutHelper.loadouts);
    _controller.addListener(() => _filter());
    super.initState();
  }

  @override
  void dispose() {
    _scaffoldMessengerState.clearSnackBars();
    super.dispose();
  }

  _filter() {
    setState(() {
      _filtered.clear();
      _filtered.addAll(HelperFilter.filterLoadoutsByName(_controller.text, context));
    });
  }

  _focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _buildSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 1000),
        padding: const EdgeInsets.all(0),
        backgroundColor: Color(Values.colorSearchBackground),
        content: GestureDetector(
            onTap: () {
              setState(() {
                _scaffoldMessengerState.hideCurrentSnackBar();
              });
            },
            child: WidgetSnackBar(text: message))));
  }

  void loadFile() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    final bool b = await LoadoutHelper.loadFile();
    if (b) {
      _filter();
      _buildSnackBar(tr('file_imported'));
    } else {
      _buildSnackBar(tr('file_not_imported'));
    }
  }

  void saveFile() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    final bool b = await LoadoutHelper.saveFile();
    if (b) {
      _buildSnackBar(tr('file_exported'));
    } else {
      _buildSnackBar(tr('file_not_exported'));
    }
  }

  Widget _buildStack() {
    return Stack(children: [
      _buildLoadouts(),
      Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            color: Color(Values.colorSearchBackground),
            height: 75,
            width: MediaQuery.of(context).size.width,
          )),
      _buildMenu()
    ]);
  }

  Widget _buildLoadouts() {
    return ListView.builder(
        itemCount: _filtered.length,
        itemBuilder: (context, index) {
          bool last = false;
          index == _filtered.length - 1 ? last = true : last = false;
          return last
              ? Column(children: [EntryLoadout(loadout: _filtered[index], index: index, callback: _filter, context: context), const SizedBox(height: 75)])
              : EntryLoadout(loadout: _filtered[index], index: index, callback: _filter, context: context);
        });
  }

  Widget _buildMenu() {
    return Positioned(
      right: 0,
      bottom: 0,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: MediaQuery.of(context).size.width,
          height: _fileOptionsOpened ? 200 : 75,
          child: SingleChildScrollView(
              reverse: true,
              scrollDirection: Axis.horizontal,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.end, children: [
                AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 40,
                    margin: const EdgeInsets.only(right: 10, bottom: 17.5),
                    child: Stack(children: [
                      AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          right: 0,
                          bottom: _fileOptionsOpened ? 125 : 0,
                          child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: _fileOptionsOpened ? 1 : 0,
                              child: WidgetButton(
                                  icon: "assets/graphics/icons/import.svg",
                                  size: 40,
                                  color: Values.colorLight,
                                  background: Values.colorDark,
                                  onTap: () {
                                    setState(() {
                                      _fileOptionsOpened = !_fileOptionsOpened;
                                      _focus();
                                      loadFile();
                                    });
                                  }))),
                      AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          right: 0,
                          bottom: _fileOptionsOpened ? 75 : 0,
                          child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: _fileOptionsOpened ? 1 : 0,
                              child: WidgetButton(
                                  icon: "assets/graphics/icons/export.svg",
                                  size: 40,
                                  color: Values.colorLight,
                                  background: Values.colorDark,
                                  onTap: () {
                                    setState(() {
                                      _fileOptionsOpened = !_fileOptionsOpened;
                                      _focus();
                                      saveFile();
                                    });
                                  }))),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: WidgetButton(
                              icon: "assets/graphics/icons/file.svg",
                              size: 40,
                              color: Values.colorLight,
                              background: Values.colorDark,
                              onTap: () {
                                setState(() {
                                  _fileOptionsOpened = !_fileOptionsOpened;
                                  _focus();
                                });
                              }))
                    ])),
                Container(
                    margin: const EdgeInsets.only(right: 20, bottom: 17.5),
                    child: WidgetButton(
                        icon: "assets/graphics/icons/plus.svg",
                        size: 40,
                        color: Values.colorAccent,
                        background: Values.colorPrimary,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityLoadoutsAddEdit(callback: _filter)));
                          _focus();
                        }))
              ]))),
    );
  }

  Widget _buildWidgets() {
    _scaffoldMessengerState = ScaffoldMessenger.of(context);
    return WidgetScaffoldAdvanced(
        body: Column(mainAxisSize: MainAxisSize.max, children: [
      WidgetAppBar(
        text: tr('loadouts'),
        fontSize: Values.fontSize30,
        function: () {
          Navigator.pop(context);
        },
      ),
      Expanded(flex: 0, child: WidgetSearchBar(background: Values.colorSearchBackground, color: Values.colorSearch, controller: _controller)),
      Expanded(child: _buildStack())
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
