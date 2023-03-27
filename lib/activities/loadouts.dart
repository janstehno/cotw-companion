// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/activities/loadouts_add_edit.dart';
import 'package:cotwcompanion/model/loadout.dart';
import 'package:cotwcompanion/widgets/entries/loadout.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:cotwcompanion/widgets/searchbar.dart';
import 'package:cotwcompanion/widgets/snackbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ActivityLoadouts extends StatefulWidget {
  const ActivityLoadouts({
    Key? key,
  }) : super(key: key);

  @override
  ActivityLoadoutsState createState() => ActivityLoadoutsState();
}

class ActivityLoadoutsState extends State<ActivityLoadouts> {
  final TextEditingController _controller = TextEditingController();
  final List<Loadout> _filtered = [];

  late ScaffoldMessengerState _scaffoldMessengerState;

  bool _fileOptionsOpened = false;

  @override
  void initState() {
    _filtered.addAll(HelperLoadout.loadouts);
    _controller.addListener(() => _filter());
    super.initState();
  }

  @override
  void dispose() {
    _scaffoldMessengerState.clearSnackBars();
    super.dispose();
  }

  void _filter() {
    setState(() {
      _filtered.clear();
      _filtered.addAll(HelperFilter.filterLoadoutsByName(_controller.text, context));
    });
  }

  void _focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _buildSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 1000),
        padding: const EdgeInsets.all(0),
        backgroundColor: Interface.searchBackground,
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
    final bool fileLoaded = await HelperLoadout.loadFile();
    if (fileLoaded) {
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
    final bool fileSaved = await HelperLoadout.saveFile();
    if (fileSaved) {
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
            color: Interface.searchBackground,
            height: 75,
            width: MediaQuery.of(context).size.width,
          )),
      _buildMenu()
    ]);
  }

  Widget _buildLoadouts() {
    bool last = false;
    return WidgetScrollbar(
        child: ListView.builder(
            itemCount: _filtered.length,
            itemBuilder: (context, index) {
              index == _filtered.length - 1 ? last = true : last = false;
              return last
                  ? Column(children: [
                      EntryLoadout(
                        loadout: _filtered[index],
                        index: index,
                        callback: _filter,
                        context: context,
                      ),
                      const SizedBox(height: 75),
                    ])
                  : EntryLoadout(
                      loadout: _filtered[index],
                      index: index,
                      callback: _filter,
                      context: context,
                    );
            }));
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
                                    color: Interface.light,
                                    background: Interface.dark,
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
                                    color: Interface.light,
                                    background: Interface.dark,
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
                                color: Interface.light,
                                background: Interface.dark,
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
                          color: Interface.accent,
                          background: Interface.primary,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityLoadoutsAddEdit(callback: _filter)));
                            _focus();
                          }))
                ]))));
  }

  Widget _buildWidgets() {
    _scaffoldMessengerState = ScaffoldMessenger.of(context);
    return WidgetScaffold.withCustomBody(
        body: Column(mainAxisSize: MainAxisSize.max, children: [
      WidgetAppBar(
        text: tr('loadouts'),
        fontSize: Interface.s30,
        context: context,
      ),
      Expanded(
          flex: 0,
          child: WidgetSearchBar(
            background: Interface.searchBackground,
            color: Interface.search,
            controller: _controller,
          )),
      Expanded(
        child: _buildStack(),
      )
    ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
