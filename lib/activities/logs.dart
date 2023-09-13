// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/activities/filter.dart';
import 'package:cotwcompanion/activities/logs_add_edit.dart';
import 'package:cotwcompanion/activities/logs_information.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/helpers/log.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/search_controller.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/entries/log.dart';
import 'package:cotwcompanion/widgets/entries/menubar_item.dart';
import 'package:cotwcompanion/widgets/filters/picker_icon.dart';
import 'package:cotwcompanion/widgets/filters/range_set.dart';
import 'package:cotwcompanion/widgets/filters/sorter_icon.dart';
import 'package:cotwcompanion/widgets/menubar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:cotwcompanion/widgets/searchbar.dart';
import 'package:cotwcompanion/widgets/snackbar.dart';
import 'package:cotwcompanion/widgets/switch_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ActivityLogs extends StatefulWidget {
  final bool trophyLodge;

  const ActivityLogs({
    Key? key,
    required this.trophyLodge,
  }) : super(key: key);

  @override
  ActivityLogsState createState() => ActivityLogsState();
}

class ActivityLogsState extends State<ActivityLogs> {
  final TextEditingControllerWorkaround _controller = TextEditingControllerWorkaround(text: "");
  final RegExp equalsNumber = RegExp(r'^(\d){1,5}(\.\d{1,3})?$');
  final RegExp greaterNumber = RegExp(r'^>(\d){1,5}(\.\d{1,3})?$');
  final RegExp lesserNumber = RegExp(r'^<(\d){1,5}(\.\d{1,3})?$');
  final RegExp equalsString = RegExp(r'^[\D ]+$');
  final List<Log> _logs = [];
  final double _menuHeight = 75;

  late final Settings _settings;

  late ScaffoldMessengerState _scaffoldMessengerState;

  bool _viewOptionsOpened = false;
  bool _fileOptionsOpened = false;
  bool _yesNoOpened = false;

  @override
  void initState() {
    _controller.addListener(() => _filter());
    _settings = Provider.of<Settings>(context, listen: false);
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
      _logs.clear();
      _logs.addAll(HelperFilter.filterLogs(_controller.text, context));

      if (!widget.trophyLodge && !_settings.getTrophyLodgeRecord) {
        _logs.removeWhere((log) => log.isInLodge);
      }
      if (widget.trophyLodge) {
        _logs.removeWhere((log) => !log.isInLodge);
      }
    });
  }

  void _removeLogs() {
    setState(() {
      HelperLog.removeLogs();
      _filter();
    });
  }

  void _showFileOptions() {
    setState(() {
      _fileOptionsOpened = !_fileOptionsOpened;
      _viewOptionsOpened = false;
      _focus();
    });
  }

  void _showViewOptions() {
    setState(() {
      _viewOptionsOpened = !_viewOptionsOpened;
      _fileOptionsOpened = false;
      _focus();
    });
  }

  void _addSeparator() {
    String searchText = _controller.text += "|";
    _controller.setTextAndPosition(searchText);
  }

  void _buildSnackBar(String message) {
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
            ))));
  }

  void loadFile() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    final bool fileLoaded = await HelperLog.loadFile();
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
    final bool fileSaved = await HelperLog.saveFile();
    if (fileSaved) {
      _buildSnackBar(tr('file_exported'));
    } else {
      _buildSnackBar(tr('file_not_exported'));
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
                            tr('remove_all_items'),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: Interface.s18w500n(Interface.alwaysLight),
                          )),
                      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        WidgetButtonIcon(
                            buttonSize: 60,
                            icon: "assets/graphics/icons/remove_bin.svg",
                            color: Interface.alwaysDark,
                            background: Interface.red,
                            onTap: () {
                              setState(() {
                                _removeLogs();
                                _yesNoOpened = false;
                                _focus();
                              });
                            }),
                        WidgetButtonIcon(
                            buttonSize: 60,
                            icon: "assets/graphics/icons/menu_close.svg",
                            color: Interface.light,
                            background: Interface.dark,
                            onTap: () {
                              setState(() {
                                _yesNoOpened = false;
                                _focus();
                              });
                            })
                      ])
                    ]))
                : const SizedBox.shrink()));
  }

  Widget _buildLogs() {
    _filter();
    return WidgetScrollbar(
        child: ListView.builder(
            itemCount: _logs.length,
            itemBuilder: (context, index) {
              Log log = _logs[index];
              bool last = false;
              index == _logs.length - 1 ? last = true : last = false;
              return last
                  ? Column(children: [
                      EntryLog(
                        index: index,
                        log: log,
                        callback: _filter,
                        context: context,
                      ),
                      const SizedBox(height: 75)
                    ])
                  : EntryLog(
                      index: index,
                      log: log,
                      callback: _filter,
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
              _showFileOptions();
              _focus();
            });
          }),
      menuButtons: [
        WidgetButtonIcon(
            icon: "assets/graphics/icons/export.svg",
            color: Interface.light,
            background: Interface.dark,
            onTap: () {
              setState(() {
                _fileOptionsOpened = !_fileOptionsOpened;
                _focus();
                saveFile();
              });
            }),
        WidgetButtonIcon(
            icon: "assets/graphics/icons/import.svg",
            color: Interface.light,
            background: Interface.dark,
            onTap: () {
              setState(() {
                _fileOptionsOpened = !_fileOptionsOpened;
                _focus();
                loadFile();
              });
            }),
        WidgetButtonIcon(
            icon: "assets/graphics/icons/remove_bin.svg",
            color: Interface.alwaysDark,
            background: Interface.red,
            onTap: () {
              setState(() {
                _yesNoOpened = true;
                _showFileOptions();
                _focus();
              });
            }),
      ],
      menuHeight: _menuHeight,
      menuOpened: _fileOptionsOpened,
    );
  }

  EntryMenuBarItem _buildViewOptions() {
    return EntryMenuBarItem(
      barButton: WidgetButtonIcon(
          icon: "assets/graphics/icons/fullscreen.svg",
          color: Interface.light,
          background: Interface.dark,
          onTap: () {
            setState(() {
              _showViewOptions();
              _focus();
            });
          }),
      menuButtons: [
        WidgetButtonIcon(
            icon: _settings.getCompactLogbook == 3
                ? "assets/graphics/icons/view_semi_compact.svg"
                : _settings.getCompactLogbook == 2
                    ? "assets/graphics/icons/view_compact.svg"
                    : "assets/graphics/icons/view_expanded.svg",
            color: Interface.light,
            background: Interface.dark,
            onTap: () {
              setState(() {
                _settings.changeCompactLogbook();
                _focus();
              });
            }),
        WidgetSwitchIcon(
            icon: "assets/graphics/icons/sort_date.svg",
            color: Interface.light,
            background: Interface.dark,
            isActive: _settings.getDateOfRecord,
            onTap: () {
              setState(() {
                _settings.changeDateOfRecord();
                _focus();
              });
            }),
        widget.trophyLodge
            ? const SizedBox.shrink()
            : WidgetSwitchIcon(
                icon: "assets/graphics/icons/trophy_lodge.svg",
                color: Interface.light,
                background: Interface.dark,
                isActive: _settings.getTrophyLodgeRecord,
                onTap: () {
                  setState(() {
                    _settings.changeTrophyLodgeRecord();
                    _filter();
                    _focus();
                  });
                })
      ],
      menuHeight: _menuHeight,
      menuOpened: _viewOptionsOpened,
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
              iconSize: 16,
              color: Interface.light,
              background: Interface.dark,
              onTap: () {
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityLogsInformation()));
                  _focus();
                });
              }),
        ),
        _buildFileOptions(),
        _buildViewOptions(),
        EntryMenuBarItem(
          barButton: WidgetButtonIcon(
              icon: "assets/graphics/icons/separator.svg",
              color: Interface.light,
              background: Interface.dark,
              onTap: () {
                _addSeparator();
              }),
        ),
        EntryMenuBarItem(
          barButton: WidgetButtonIcon(
              icon: "assets/graphics/icons/plus.svg",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityLogsAddEdit(fromTrophyLodge: widget.trophyLodge, callback: _filter)));
                _focus();
              }),
        ),
      ],
    );
  }

  List<Widget> _buildFilters() {
    String assets = "assets/graphics/icons/";
    return [
      FilterRangeSet(
        icon: "${assets}difficulty.svg",
        text: tr('animal_trophy'),
        min: 0,
        max: 1000,
        filterKeyLower: FilterKey.logsTrophyScoreMin,
        filterKeyUpper: FilterKey.logsTrophyScoreMax,
      ),
      FilterPickerIcon(
        icon: "${assets}trophy_diamond.svg",
        text: tr('trophy_rating'),
        filterKey: FilterKey.logsTrophyRating,
        values: const [0, 1, 2, 3, 4, 5],
        icons: [
          "${assets}trophy_none.svg",
          "${assets}trophy_bronze.svg",
          "${assets}trophy_silver.svg",
          "${assets}trophy_gold.svg",
          "${assets}trophy_diamond.svg",
          "${assets}trophy_great_one.svg",
        ],
        colors: [
          Interface.alwaysDark,
          Interface.alwaysDark,
          Interface.alwaysDark,
          Interface.alwaysDark,
          Interface.alwaysDark,
          Interface.light,
        ],
        backgrounds: [
          Interface.trophyNoneBackground,
          Interface.trophyBronzeBackground,
          Interface.trophySilverBackground,
          Interface.trophyGoldBackground,
          Interface.trophyDiamondBackground,
          Interface.dark,
        ],
      ),
      FilterPickerIcon(
        icon: "${assets}gender.svg",
        text: tr('animal_gender'),
        filterKey: FilterKey.logsGender,
        values: const [1, 0],
        icons: [
          "${assets}gender_male.svg",
          "${assets}gender_female.svg",
        ],
        colors: const [
          Interface.alwaysDark,
          Interface.alwaysDark,
        ],
        backgrounds: const [
          Interface.male,
          Interface.female,
        ],
      ),
      FilterSorterIcon(
        icon: "${assets}sort.svg",
        text: tr('sort'),
        filterKey: FilterKey.logsSort,
        values: const [1, 2, 3, 4, 5, 6],
        icons: [
          "${assets}sort_az.svg",
          "${assets}sort_date.svg",
          "${assets}sort_trophy_score.svg",
          "${assets}trophy_diamond.svg",
          "${assets}sort_fur_rarity.svg",
          "${assets}gender.svg",
        ],
        criteria: const [
          true,
          false,
          false,
          false,
          false,
          false,
        ],
        preferences: const [
          "NAME",
          "DATE",
          "TROPHY",
          "TROPHY_RATING",
          "FUR_RARITY",
          "GENDER",
        ],
      )
    ];
  }

  void _buildFilter() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityFilter(filters: _buildFilters(), filter: _filter)));
  }

  Widget _buildBody() {
    return Stack(children: [
      Column(mainAxisSize: MainAxisSize.max, children: [
        WidgetAppBar(
          text: widget.trophyLodge ? tr('trophy_lodge') : tr('logbook'),
          context: context,
        ),
        WidgetSearchBar(
          controller: _controller,
          onFilter: _buildFilter,
        ),
        Expanded(
            child: Stack(children: [
          _buildLogs(),
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
          )
        ]))
      ]),
      _buildYesNo(),
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
