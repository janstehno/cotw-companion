// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/activities/edit/counters.dart';
import 'package:cotwcompanion/activities/help/counters.dart';
import 'package:cotwcompanion/miscellaneous/helpers/enumerator.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/enumerator.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/entries/counter.dart';
import 'package:cotwcompanion/widgets/entries/menubar_item.dart';
import 'package:cotwcompanion/widgets/menubar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityCounters extends StatefulWidget {
  final Enumerator enumerator;

  const ActivityCounters({
    Key? key,
    required this.enumerator,
  }) : super(key: key);

  @override
  ActivityCountersState createState() => ActivityCountersState();
}

class ActivityCountersState extends State<ActivityCounters> {
  final List<dynamic> _counters = [];

  final double _menuHeight = 75;
  final double _removeButtonSize = 60;

  late ScaffoldMessengerState _scaffoldMessengerState;

  bool _yesNoOpened = false;

  @override
  void initState() {
    _counters.addAll(widget.enumerator.counters);
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
      _counters.clear();
      _counters.addAll(widget.enumerator.counters);
    });
  }

  void _removeCounters() {
    setState(() {
      HelperEnumerator.removeAllCounters(widget.enumerator.id);
      _filter();
    });
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
                                _removeCounters();
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

  Widget _buildCounters() {
    _filter();
    return WidgetScrollbar(
      child: Column(
        children: [
          Expanded(
            child: ReorderableListView.builder(
              itemCount: _counters.length,
              itemBuilder: (context, index) {
                Counter counter = _counters.elementAt(index);
                return EntryCounter(
                  key: Key(index.toString()),
                  index: index,
                  enumerator: widget.enumerator,
                  counter: counter,
                  callback: _filter,
                  context: context,
                );
              },
              onReorder: (int oldIndex, int newIndex) {
                HelperEnumerator.swapIndexOfCounters(widget.enumerator.id, oldIndex, newIndex);
                setState(() {});
              },
            ),
          ),
          SizedBox(height: _menuHeight),
        ],
      ),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityHelpCounters()));
                });
              }),
        ),
        EntryMenuBarItem(
            barButton: WidgetButtonIcon(
                icon: "assets/graphics/icons/remove_bin.svg",
                color: Interface.alwaysDark,
                background: Interface.red,
                onTap: () {
                  setState(() {
                    _focus();
                    _yesNoOpened = true;
                  });
                })),
        EntryMenuBarItem(
          barButton: WidgetButtonIcon(
              icon: "assets/graphics/icons/plus.svg",
              onTap: () {
                _focus();
                Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityEditCounters(enumerator: widget.enumerator, callback: _filter)));
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
              text: widget.enumerator.name,
              context: context,
            ),
            Expanded(
              child: Stack(
                children: [
                  _buildCounters(),
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
