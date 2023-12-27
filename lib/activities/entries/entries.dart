// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/miscellaneous/search_controller.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/entries/menubar_item.dart';
import 'package:cotwcompanion/widgets/menubar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:cotwcompanion/widgets/searchbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class ActivityEntries extends StatefulWidget {
  final String name;

  const ActivityEntries({
    Key? key,
    required this.name,
  }) : super(key: key);
}

abstract class ActivityEntriesState extends State<ActivityEntries> {
  final TextEditingControllerWorkaround controller = TextEditingControllerWorkaround();
  final List<dynamic> items = [];
  final double menuHeight = 75;
  final double _removeButtonSize = 60;

  late ScaffoldMessengerState _scaffoldMessengerState;

  bool fileOptionsOpened = false;
  bool yesNoOpened = false;

  @override
  void initState() {
    controller.addListener(() => filter());
    super.initState();
  }

  @override
  void dispose() {
    _scaffoldMessengerState.clearSnackBars();
    super.dispose();
  }

  void focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void filter() {}

  void removeAll() {}

  void showFileOptions() {
    setState(() {
      focus();
      fileOptionsOpened = !fileOptionsOpened;
    });
  }

  fileLoaded() async => false;

  void _loadFile() async {
    final bool loaded = await fileLoaded();
    _buildLoaded(loaded);
  }

  void _buildLoaded(bool loaded) {
    if (loaded) {
      filter();
      Utils.buildSnackBarMessage(
        tr("file_imported"),
        Process.success,
        context,
      );
    } else {
      Utils.buildSnackBarMessage(
        tr("file_not_imported"),
        Process.error,
        context,
      );
    }
  }

  fileSaved() async => false;

  void _saveFile() async {
    final bool saved = await fileSaved();
    _buildSaved(saved);
  }

  void _buildSaved(bool saved) {
    if (saved) {
      Utils.buildSnackBarMessage(
        tr("file_exported"),
        Process.success,
        context,
      );
    } else {
      Utils.buildSnackBarMessage(
        tr("file_not_exported"),
        Process.error,
        context,
      );
    }
  }

  Widget _buildYesNo() {
    return Center(
        child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: yesNoOpened ? 1 : 0,
            child: yesNoOpened
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
                                focus();
                                removeAll();
                                yesNoOpened = false;
                              });
                            }),
                        WidgetButtonIcon(
                            buttonSize: _removeButtonSize,
                            icon: "assets/graphics/icons/menu_close.svg",
                            color: Interface.light,
                            background: Interface.dark,
                            onTap: () {
                              setState(() {
                                focus();
                                yesNoOpened = false;
                              });
                            })
                      ])
                    ]))
                : const SizedBox.shrink()));
  }

  Widget buildEntry(int index, dynamic item) => Container();

  Widget buildItems() {
    filter();
    return WidgetScrollbar(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  dynamic item = items.elementAt(index);
                  return buildEntry(index, item);
                }),
          ),
          SizedBox(height: menuHeight),
        ],
      ),
    );
  }

  EntryMenuBarItem buildFileOptions() {
    return EntryMenuBarItem(
      barButton: WidgetButtonIcon(
          icon: "assets/graphics/icons/file.svg",
          color: Interface.light,
          background: Interface.dark,
          onTap: () {
            setState(() {
              focus();
              showFileOptions();
            });
          }),
      menuButtons: [
        WidgetButtonIcon(
            icon: "assets/graphics/icons/export.svg",
            color: Interface.light,
            background: Interface.dark,
            onTap: () async {
              _saveFile();
              setState(() {
                focus();
                fileOptionsOpened = !fileOptionsOpened;
              });
            }),
        WidgetButtonIcon(
            icon: "assets/graphics/icons/import.svg",
            color: Interface.light,
            background: Interface.dark,
            onTap: () async {
              _loadFile();
              setState(() {
                focus();
                fileOptionsOpened = !fileOptionsOpened;
              });
            }),
        WidgetButtonIcon(
            icon: "assets/graphics/icons/remove_bin.svg",
            color: Interface.alwaysDark,
            background: Interface.red,
            onTap: () {
              setState(() {
                focus();
                showFileOptions();
                yesNoOpened = true;
              });
            }),
      ],
      menuHeight: menuHeight,
      menuOpened: fileOptionsOpened,
    );
  }

  List<EntryMenuBarItem> buildMenuBarItems() => [];

  Widget _buildMenu() {
    return WidgetMenuBar(
      width: MediaQuery.of(context).size.width,
      height: menuHeight,
      items: buildMenuBarItems(),
    );
  }

  List<Widget> buildFilters() => [];

  void buildFilter() {}

  WidgetAppBar buildAppBar() {
    return WidgetAppBar(
      text: tr(widget.name),
      context: context,
    );
  }

  WidgetSearchBar? buildSearchBar() => null;

  Widget _buildBody() {
    return Stack(
      children: [
        Column(mainAxisSize: MainAxisSize.max, children: [
          buildAppBar(),
          buildSearchBar() ?? const SizedBox.shrink(),
          Expanded(
            child: Stack(
              children: [
                buildItems(),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: menuHeight,
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
        ]),
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
