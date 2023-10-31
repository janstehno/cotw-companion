// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/activities/filter.dart';
import 'package:cotwcompanion/activities/loadouts_add_edit.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/loadout.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/entries/loadout.dart';
import 'package:cotwcompanion/widgets/entries/menubar_item.dart';
import 'package:cotwcompanion/widgets/filters/range_set.dart';
import 'package:cotwcompanion/widgets/menubar.dart';
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
  final List<Loadout> _loadouts = [];
  final double _menuHeight = 75;

  late ScaffoldMessengerState _scaffoldMessengerState;

  bool _fileOptionsOpened = false;

  @override
  void initState() {
    _controller.addListener(() => _filter());
    super.initState();
  }

  @override
  void dispose() {
    _scaffoldMessengerState.clearSnackBars();
    super.dispose();
  }

  void _focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _filter() {
    setState(() {
      _loadouts.clear();
      _loadouts.addAll(HelperFilter.filterLoadouts(_controller.text, context));
    });
  }

  void _callback() {
    setState(() {});
  }

  void _buildSnackBar(String message, Process process) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 1000),
        padding: const EdgeInsets.all(0),
        backgroundColor: Interface.search,
        content: GestureDetector(
            onTap: () {
              setState(() {
                _scaffoldMessengerState.hideCurrentSnackBar();
              });
            },
            child: WidgetSnackBar(
              text: message,
              process: process,
            ))));
  }

  void loadFile() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    final bool fileLoaded = await HelperLoadout.loadFile();
    if (fileLoaded) {
      _filter();
      _buildSnackBar(
        tr('file_imported'),
        Process.success,
      );
    } else {
      _buildSnackBar(
        tr('file_not_imported'),
        Process.error,
      );
    }
  }

  void saveFile() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    final bool fileSaved = await HelperLoadout.saveFile();
    if (fileSaved) {
      _buildSnackBar(
        tr('file_exported'),
        Process.success,
      );
    } else {
      _buildSnackBar(
        tr('file_not_exported'),
        Process.error,
      );
    }
  }

  Widget _buildLoadouts() {
    _filter();
    bool last = false;
    return WidgetScrollbar(
        child: ListView.builder(
            itemCount: _loadouts.length,
            itemBuilder: (context, index) {
              index == _loadouts.length - 1 ? last = true : last = false;
              return last
                  ? Column(children: [
                      EntryLoadout(
                        index: index,
                        loadout: _loadouts[index],
                        callback: _callback,
                        context: context,
                      ),
                      SizedBox(
                        height: _menuHeight,
                      ),
                    ])
                  : EntryLoadout(
                      index: index,
                      loadout: _loadouts[index],
                      callback: _callback,
                      context: context,
                    );
            }));
  }

  EntryMenuBarItem _buildFileOptions() {
    return EntryMenuBarItem(
      barButton: WidgetButtonIcon(
          icon: "assets/graphics/icons/file.svg",
          color: Interface.light,
          background: Interface.dark,
          onTap: () {
            setState(() {
              _focus();
              _fileOptionsOpened = !_fileOptionsOpened;
            });
          }),
      menuButtons: [
        WidgetButtonIcon(
            icon: "assets/graphics/icons/export.svg",
            color: Interface.light,
            background: Interface.dark,
            onTap: () {
              setState(() {
                _focus();
                saveFile();
                _fileOptionsOpened = !_fileOptionsOpened;
              });
            }),
        WidgetButtonIcon(
            icon: "assets/graphics/icons/import.svg",
            color: Interface.light,
            background: Interface.dark,
            onTap: () {
              setState(() {
                _focus();
                loadFile();
                _fileOptionsOpened = !_fileOptionsOpened;
              });
            }),
      ],
      menuHeight: _menuHeight,
      menuOpened: _fileOptionsOpened,
    );
  }

  Widget _buildMenu() {
    return WidgetMenuBar(
      width: MediaQuery.of(context).size.width,
      height: _menuHeight,
      items: [
        _buildFileOptions(),
        EntryMenuBarItem(
          barButton: WidgetButtonIcon(
              icon: "assets/graphics/icons/plus.svg",
              onTap: () {
                _focus();
                Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityLoadoutsAddEdit(callback: _filter)));
              }),
        ),
      ],
    );
  }

  List<Widget> _buildFilters() {
    return [
      FilterRangeSet(
        icon: "assets/graphics/icons/loadout.svg",
        text: tr('weapon_ammo'),
        decimal: false,
        min: 1,
        max: 200,
        filterKeyLower: FilterKey.loadoutsAmmoMin,
        filterKeyUpper: FilterKey.loadoutsAmmoMax,
      ),
      FilterRangeSet(
        icon: "assets/graphics/icons/caller.svg",
        text: tr('callers'),
        decimal: false,
        min: 1,
        max: 50,
        filterKeyLower: FilterKey.loadoutsCallersMin,
        filterKeyUpper: FilterKey.loadoutsCallersMax,
      ),
    ];
  }

  void _buildFilter() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityFilter(filters: _buildFilters(), filter: _filter)));
  }

  Widget _buildBody() {
    return Stack(children: [
      Column(mainAxisSize: MainAxisSize.max, children: [
        WidgetAppBar(
          text: tr('loadouts'),
          context: context,
        ),
        WidgetSearchBar(
          controller: _controller,
          onFilter: _buildFilter,
        ),
        Expanded(
            child: Stack(children: [
          _buildLoadouts(),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              height: _menuHeight,
              width: MediaQuery.of(context).size.width,
              color: Interface.search,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: _buildMenu(),
          ),
        ])),
      ]),
    ]);
  }

  Widget _buildWidgets() {
    _scaffoldMessengerState = ScaffoldMessenger.of(context);
    return WidgetScaffold(
      customBody: true,
      body: _buildBody(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
