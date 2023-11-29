// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/activities/edit/enumerators.dart';
import 'package:cotwcompanion/activities/help/enumerators.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/enumerator.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/model/enumerator.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/entries/enumerator.dart';
import 'package:cotwcompanion/widgets/entries/menubar_item.dart';
import 'package:cotwcompanion/widgets/menubar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:cotwcompanion/widgets/searchbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityEnumerators extends StatefulWidget {
  const ActivityEnumerators({
    Key? key,
  }) : super(key: key);

  @override
  ActivityEnumeratorsState createState() => ActivityEnumeratorsState();
}

class ActivityEnumeratorsState extends State<ActivityEnumerators> {
  final TextEditingController _controller = TextEditingController();
  final List<Enumerator> _enumerators = [];
  final double _menuHeight = 75;
  final double _removeButtonSize = 60;

  late ScaffoldMessengerState _scaffoldMessengerState;

  bool _fileOptionsOpened = false;
  bool _yesNoOpened = false;

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
      _enumerators.clear();
      _enumerators.addAll(HelperFilter.filterEnumerators(_controller.text, context));
    });
  }

  void _removeEnumerators() {
    setState(() {
      HelperEnumerator.removeAllEnumerators();
      _filter();
    });
  }

  void _showFileOptions() {
    setState(() {
      _focus();
      _fileOptionsOpened = !_fileOptionsOpened;
    });
  }

  void _buildSnackBar(String message, Process process) {
    ScaffoldMessenger.of(context).showSnackBar(Utils.snackBar(() {
      setState(() {
        _scaffoldMessengerState.hideCurrentSnackBar();
      });
    }, message, process));
  }

  void loadFile() async {
    final bool fileLoaded = await HelperEnumerator.importFile();
    if (fileLoaded) {
      _filter();
      _buildSnackBar(
        tr("file_imported"),
        Process.success,
      );
    } else {
      _buildSnackBar(
        tr("file_not_imported"),
        Process.error,
      );
    }
  }

  void saveFile() async {
    final bool fileSaved = await HelperEnumerator.exportFile();
    if (fileSaved) {
      _buildSnackBar(
        tr("file_exported"),
        Process.success,
      );
    } else {
      _buildSnackBar(
        tr("file_not_exported"),
        Process.error,
      );
    }
  }

  Widget _buildYesNo() {
    return Center(
        child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _yesNoOpened ? 1 : 0,
            child: _yesNoOpened
                ? Container(
                    color: Interface.alwaysDark.withOpacity(0.8),
                    child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                          padding: const EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            tr("remove_all_items"),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: Interface.s18w500n(Interface.alwaysLight),
                          )),
                      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        WidgetButtonIcon(
                            buttonSize: _removeButtonSize,
                            icon: "assets/graphics/icons/remove_bin.svg",
                            color: Interface.alwaysDark,
                            background: Interface.red,
                            onTap: () {
                              setState(() {
                                _focus();
                                _removeEnumerators();
                                _yesNoOpened = false;
                              });
                            }),
                        WidgetButtonIcon(
                            buttonSize: _removeButtonSize,
                            icon: "assets/graphics/icons/menu_close.svg",
                            color: Interface.light,
                            background: Interface.dark,
                            onTap: () {
                              setState(() {
                                _focus();
                                _yesNoOpened = false;
                              });
                            })
                      ])
                    ]))
                : const SizedBox.shrink()));
  }

  Widget _buildEnumerators() {
    _filter();
    return WidgetScrollbar(
      child: Column(
        children: [
          Expanded(
            child: ReorderableListView.builder(
              itemCount: _enumerators.length,
              itemBuilder: (context, index) {
                Enumerator enumerator = _enumerators.elementAt(index);
                return EntryEnumerator(
                  key: Key(index.toString()),
                  index: index,
                  enumerator: enumerator,
                  callback: _filter,
                  context: context,
                );
              },
              onReorder: (int oldIndex, int newIndex) {
                HelperEnumerator.changeIndexOfEnumerators(oldIndex, newIndex);
                setState(() {});
              },
            ),
          ),
          SizedBox(height: _menuHeight),
        ],
      ),
    );
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
              _showFileOptions();
            });
          }),
      menuButtons: [
        WidgetButtonIcon(
            icon: "assets/graphics/icons/export.svg",
            color: Interface.light,
            background: Interface.dark,
            onTap: () async {
              saveFile();
              setState(() {
                _focus();
                _fileOptionsOpened = !_fileOptionsOpened;
              });
            }),
        WidgetButtonIcon(
            icon: "assets/graphics/icons/import.svg",
            color: Interface.light,
            background: Interface.dark,
            onTap: () async {
              loadFile();
              setState(() {
                _focus();
                _fileOptionsOpened = !_fileOptionsOpened;
              });
            }),
        WidgetButtonIcon(
            icon: "assets/graphics/icons/remove_bin.svg",
            color: Interface.alwaysDark,
            background: Interface.red,
            onTap: () {
              setState(() {
                _focus();
                _showFileOptions();
                _yesNoOpened = true;
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
        EntryMenuBarItem(
          barButton: WidgetButtonIcon(
              icon: "assets/graphics/icons/about.svg",
              color: Interface.light,
              background: Interface.dark,
              onTap: () {
                setState(() {
                  _focus();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityHelpEnumerators()));
                });
              }),
        ),
        _buildFileOptions(),
        EntryMenuBarItem(
          barButton: WidgetButtonIcon(
              icon: "assets/graphics/icons/plus.svg",
              onTap: () {
                _focus();
                Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityEditEnumerators(callback: _filter)));
              }),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            WidgetAppBar(
              text: tr("counters"),
              context: context,
            ),
            WidgetSearchBar(
              controller: _controller,
              onFilter: null,
            ),
            Expanded(
              child: Stack(
                children: [
                  _buildEnumerators(),
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
                ],
              ),
            )
          ],
        ),
        _buildYesNo(),
      ],
    );
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
