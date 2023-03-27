// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/search_controller.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/log.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/multi_sort.dart';
import 'package:cotwcompanion/activities/logs_add_edit.dart';
import 'package:cotwcompanion/activities/logs_information.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:cotwcompanion/widgets/entries/log.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:cotwcompanion/widgets/searchbar.dart';
import 'package:cotwcompanion/widgets/snackbar.dart';
import 'package:cotwcompanion/widgets/switch.dart';
import 'package:cotwcompanion/widgets/switch_sort.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  final List<String> _criteriaNames = ['NAME', 'TROPHY', 'DATE'];
  final List<Log> _filtered = [];

  late final Settings _settings;

  late ScaffoldMessengerState _scaffoldMessengerState;

  bool _sortOptionsOpened = false;
  bool _viewOptionsOpened = false;
  bool _fileOptionsOpened = false;
  bool _yesNoOpened = false;

  int _numberOfLogs = 0;
  int _numberOfNoneLogs = 0;
  int _numberOfBronzeLogs = 0;
  int _numberOfSilverLogs = 0;
  int _numberOfGoldLogs = 0;
  int _numberOfDiamondLogs = 0;
  int _numberOfGreatOneLogs = 0;
  int _numberOfCorruptedLogs = 0;

  List<String> _preferences = [];
  List<bool> _criteria = [];
  int _namePreferenceSet = -1;
  int _datePreferenceSet = -1;
  int _trophyPreferenceSet = -1;
  bool _nameCriteria = true;
  bool _dateCriteria = false;
  bool _trophyCriteria = false;

  @override
  void initState() {
    _filtered.addAll(HelperLog.logs);
    _controller.addListener(() => _reload());
    _settings = Provider.of<Settings>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _scaffoldMessengerState.clearSnackBars();
    super.dispose();
  }

  void _reload() {
    setState(() {
      _filtered.clear();
      String searchText = _controller.text;
      List<List<dynamic>> compareList = _getCompareList(searchText);
      _filtered.addAll(HelperFilter.filterByMultipleCriteria(compareList, searchText, context));

      if (!widget.trophyLodge && !_settings.getTrophyLodgeRecord) {
        _filtered.removeWhere((log) => log.isInLodge);
      }
      if (widget.trophyLodge) {
        _filtered.removeWhere((log) => !log.isInLodge);
      }

      _filtered.sort((a, b) => b.dateForCompare.compareTo(a.dateForCompare));
      if (_preferences.isNotEmpty) _filtered.multiSort(_criteria, _preferences);

      _countLogs();
    });
  }

  void _focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  List<List<dynamic>> _getCompareList(String searchText) {
    List<List<dynamic>> compareList = [];
    List<dynamic> values = [];
    List<int> types = [];
    List<String> searchTextList = searchText.split("|");
    for (String searchText in searchTextList) {
      if (searchText.isNotEmpty) {
        if (equalsString.hasMatch(searchText)) {
          values.add(searchText);
          types.add(0);
        } else if (equalsNumber.hasMatch(searchText)) {
          if (!types.contains(2) && !types.contains(3)) {
            values.add(double.parse(searchText));
            types.add(1);
          }
        } else if (greaterNumber.hasMatch(searchText)) {
          if (!types.contains(1) && !types.contains(2)) {
            values.add(double.parse(searchText.split(">")[1]));
            types.add(2);
          }
        } else if (lesserNumber.hasMatch(searchText)) {
          if (!types.contains(1) && !types.contains(3)) {
            values.add(double.parse(searchText.split("<")[1]));
            types.add(3);
          }
        }
      }
    }
    compareList.add(values);
    compareList.add(types);
    return compareList;
  }

  void _countLogs() {
    _numberOfCorruptedLogs = HelperLog.corruptedLogs.length;
    _numberOfLogs = _filtered.length;
    _numberOfNoneLogs = 0;
    _numberOfBronzeLogs = 0;
    _numberOfSilverLogs = 0;
    _numberOfGoldLogs = 0;
    _numberOfDiamondLogs = 0;
    _numberOfGreatOneLogs = 0;
    for (Log log in _filtered) {
      Animal animal = HelperJSON.getAnimal(log.animalId);
      int trophyRating = _getTrophyRating(animal, log);
      switch (trophyRating) {
        case 1:
          _numberOfBronzeLogs++;
          break;
        case 2:
          _numberOfSilverLogs++;
          break;
        case 3:
          _numberOfGoldLogs++;
          break;
        case 4:
          _numberOfDiamondLogs++;
          break;
        case 5:
          _numberOfGreatOneLogs++;
          break;
        default:
          _numberOfNoneLogs++;
          break;
      }
    }
  }

  int _getTrophyRating(Animal animal, Log log) {
    double trophy = log.trophy;
    double silver = animal.silver;
    double gold = animal.gold;
    double diamond = animal.diamond;
    int decrease = log.harvestCheckPassed ? 0 : 1;
    if (log.furId == Interface.greatOneId) {
      return 5 - (decrease * 2);
    }
    if (trophy >= diamond) {
      return 4 - decrease;
    } else if (trophy >= gold) {
      return 3 - decrease;
    } else if (trophy >= silver) {
      return 2 - decrease;
    } else if (trophy > 0) {
      return 1 - decrease;
    } else {
      return 0;
    }
  }

  void _removeLogs() {
    setState(() {
      HelperLog.removeLogs();
      _reload();
    });
  }

  void _showFileOptions() {
    setState(() {
      _fileOptionsOpened = !_fileOptionsOpened;
      _viewOptionsOpened = false;
      _sortOptionsOpened = false;
      _focus();
    });
  }

  void _showViewOptions() {
    setState(() {
      _fileOptionsOpened = false;
      _viewOptionsOpened = !_viewOptionsOpened;
      _sortOptionsOpened = false;
      _focus();
    });
  }

  void _showSortOptions() {
    setState(() {
      _fileOptionsOpened = false;
      _viewOptionsOpened = false;
      _sortOptionsOpened = !_sortOptionsOpened;
      _focus();
    });
  }

  void _addSeparator() {
    String searchText = _controller.text += "|";
    _controller.setTextAndPosition(searchText);
  }

  void _resetPreferencesAndCriteria() {
    setState(() {
      _preferences = [];
      _criteria = [];
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          _namePreferenceSet = -1;
          _datePreferenceSet = -1;
          _trophyPreferenceSet = -1;
          _nameCriteria = true;
          _dateCriteria = false;
          _trophyCriteria = false;
          _reload();
        });
      });
    });
  }

  void _setPreferencesAndCriteria(int preferenceId) {
    String preference = _criteriaNames[preferenceId];
    if (!_preferences.contains(preference)) {
      _preferences.add(preference);
      switch (preferenceId) {
        case 0:
          _namePreferenceSet = _preferences.length - 1;
          _criteria.add(_nameCriteria);
          break;
        case 1:
          _trophyPreferenceSet = _preferences.length - 1;
          _criteria.add(_trophyCriteria);
          break;
        case 2:
          _datePreferenceSet = _preferences.length - 1;
          _criteria.add(_dateCriteria);
          break;
      }
    } else {
      switch (preferenceId) {
        case 0:
          _nameCriteria = !_nameCriteria;
          _criteria[_namePreferenceSet] = _nameCriteria;
          break;
        case 1:
          _trophyCriteria = !_trophyCriteria;
          _criteria[_trophyPreferenceSet] = _trophyCriteria;
          break;
        case 2:
          _dateCriteria = !_dateCriteria;
          _criteria[_datePreferenceSet] = _dateCriteria;
          break;
      }
    }
    _reload();
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
    final bool fileLoaded = await HelperLog.loadFile();
    if (fileLoaded) {
      _reload();
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

  Widget _buildStack() {
    return Stack(children: [
      _buildLogs(),
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

  Widget _buildYesNo() {
    return Center(
        child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _yesNoOpened ? 1 : 0,
            child: _yesNoOpened
                ? Container(
                    color: Interface.shadow.withOpacity(0.8),
                    child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                          padding: const EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: AutoSizeText(tr('remove_all_items'),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Interface.alwaysLight,
                                fontSize: Interface.s20,
                                fontWeight: FontWeight.w600,
                              ))),
                      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        WidgetButton(
                            buttonSize: 80,
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
                        WidgetButton(
                            buttonSize: 80,
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
                : Container()));
  }

  Widget _buildLogs() {
    return WidgetScrollbar(
        child: ListView.builder(
            itemCount: _filtered.length,
            itemBuilder: (context, index) {
              Log log = _filtered[index];
              bool last = false;
              index == _filtered.length - 1 ? last = true : last = false;
              return last
                  ? Column(children: [
                      EntryLog(
                        log: log,
                        callback: _reload,
                        context: context,
                      ),
                      const SizedBox(height: 75)
                    ])
                  : EntryLog(
                      log: log,
                      callback: _reload,
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
          height: _fileOptionsOpened || _viewOptionsOpened
              ? 232.5
              : _sortOptionsOpened
                  ? 282.5
                  : 75,
          child: SingleChildScrollView(
              reverse: true,
              scrollDirection: Axis.horizontal,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.end, children: [
                //ABOUT
                Container(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width > 330 ? 0 : 20, right: 10, bottom: 17.5),
                    child: WidgetButton(
                        icon: "assets/graphics/icons/about.svg",
                        color: Interface.light,
                        background: Interface.dark,
                        onTap: () {
                          setState(() {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityLogsInformation()));
                            _focus();
                          });
                        })),
                //FILE OPTIONS
                AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 40,
                    margin: const EdgeInsets.only(right: 10, bottom: 17.5),
                    child: Stack(children: [
                      AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          right: 0,
                          bottom: _fileOptionsOpened ? 175 : 0,
                          child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: _fileOptionsOpened ? 1 : 0,
                              child: WidgetButton(
                                  icon: "assets/graphics/icons/remove_bin.svg",
                                  color: Interface.alwaysDark,
                                  background: Interface.red,
                                  onTap: () {
                                    setState(() {
                                      _yesNoOpened = true;
                                      _showFileOptions();
                                      _focus();
                                    });
                                  }))),
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
                                  _showFileOptions();
                                  _focus();
                                });
                              }))
                    ])),
                //SORT OPTIONS
                AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 40,
                    margin: const EdgeInsets.only(right: 10, bottom: 17.5),
                    child: Stack(children: [
                      AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          right: 0,
                          bottom: _sortOptionsOpened ? 225 : 0,
                          child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: _sortOptionsOpened ? 1 : 0,
                              child: WidgetButton(
                                  icon: "assets/graphics/icons/reload.svg",
                                  color: Interface.accent,
                                  background: Interface.primary,
                                  onTap: () {
                                    setState(() {
                                      _resetPreferencesAndCriteria();
                                      _focus();
                                    });
                                  }))),
                      AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          right: 0,
                          bottom: _sortOptionsOpened ? 175 : 0,
                          child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: _sortOptionsOpened ? 1 : 0,
                              child: WidgetSwitchSort(
                                  icon: "assets/graphics/icons/sort_date.svg",
                                  orderNumber: _datePreferenceSet + 1,
                                  isAscended: !_dateCriteria,
                                  activeColor: Interface.accent,
                                  activeBackground: Interface.primary,
                                  inactiveColor: Interface.light,
                                  inactiveBackground: Interface.dark,
                                  inactiveOpacity: 1,
                                  isActive: _preferences.contains(_criteriaNames[2]),
                                  onTap: () {
                                    setState(() {
                                      _setPreferencesAndCriteria(2);
                                      _focus();
                                    });
                                  }))),
                      AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          right: 0,
                          bottom: _sortOptionsOpened ? 125 : 0,
                          child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: _sortOptionsOpened ? 1 : 0,
                              child: WidgetSwitchSort(
                                  icon: "assets/graphics/icons/trophy_gold.svg",
                                  orderNumber: _trophyPreferenceSet + 1,
                                  isAscended: !_trophyCriteria,
                                  activeColor: Interface.accent,
                                  activeBackground: Interface.primary,
                                  inactiveColor: Interface.light,
                                  inactiveBackground: Interface.dark,
                                  inactiveOpacity: 1,
                                  isActive: _preferences.contains(_criteriaNames[1]),
                                  onTap: () {
                                    setState(() {
                                      _setPreferencesAndCriteria(1);
                                      _focus();
                                    });
                                  }))),
                      AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          right: 0,
                          bottom: _sortOptionsOpened ? 75 : 0,
                          child: WidgetSwitchSort(
                              icon: "assets/graphics/icons/sort_az.svg",
                              orderNumber: _namePreferenceSet + 1,
                              isAscended: _nameCriteria,
                              activeColor: Interface.accent,
                              activeBackground: Interface.primary,
                              inactiveColor: Interface.light,
                              inactiveBackground: Interface.dark,
                              inactiveOpacity: 1,
                              isActive: _preferences.contains(_criteriaNames[0]),
                              onTap: () {
                                setState(() {
                                  _setPreferencesAndCriteria(0);
                                  _focus();
                                });
                              })),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: WidgetButton(
                              icon: "assets/graphics/icons/sort.svg",
                              color: Interface.light,
                              background: Interface.dark,
                              onTap: () {
                                setState(() {
                                  _showSortOptions();
                                  _focus();
                                });
                              }))
                    ])),
                //VIEW OPTIONS
                AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 40,
                    margin: const EdgeInsets.only(right: 10, bottom: 17.5),
                    child: Stack(children: [
                      widget.trophyLodge
                          ? Container()
                          : AnimatedPositioned(
                              duration: const Duration(milliseconds: 200),
                              right: 0,
                              bottom: _viewOptionsOpened ? 175 : 0,
                              child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 300),
                                  opacity: _viewOptionsOpened ? 1 : 0,
                                  child: WidgetSwitch(
                                      activeIcon: "assets/graphics/icons/trophy_lodge.svg",
                                      inactiveIcon: "assets/graphics/icons/trophy_lodge.svg",
                                      activeColor: Interface.accent,
                                      activeBackground: Interface.primary,
                                      inactiveColor: Interface.light,
                                      inactiveBackground: Interface.dark,
                                      isActive: _settings.getTrophyLodgeRecord,
                                      onTap: () {
                                        setState(() {
                                          _settings.changeTrophyLodgeRecord();
                                          _reload();
                                          _focus();
                                        });
                                      }))),
                      AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          right: 0,
                          bottom: _viewOptionsOpened ? 125 : 0,
                          child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: _viewOptionsOpened ? 1 : 0,
                              child: WidgetSwitch(
                                  activeIcon: "assets/graphics/icons/sort_date.svg",
                                  inactiveIcon: "assets/graphics/icons/sort_date.svg",
                                  activeColor: Interface.accent,
                                  activeBackground: Interface.primary,
                                  inactiveColor: Interface.light,
                                  inactiveBackground: Interface.dark,
                                  isActive: _settings.getDateOfRecord,
                                  onTap: () {
                                    setState(() {
                                      _settings.changeDateOfRecord();
                                      _focus();
                                    });
                                  }))),
                      AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          right: 0,
                          bottom: _viewOptionsOpened ? 75 : 0,
                          child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: _viewOptionsOpened ? 1 : 0,
                              child: WidgetButton(
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
                                  }))),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: WidgetButton(
                              icon: "assets/graphics/icons/fullscreen.svg",
                              color: Interface.light,
                              background: Interface.dark,
                              onTap: () {
                                setState(() {
                                  _showViewOptions();
                                  _focus();
                                });
                              }))
                    ])),
                //SEPARATOR
                Container(
                    margin: const EdgeInsets.only(right: 10, bottom: 17.5),
                    child: WidgetButton(
                        icon: "assets/graphics/icons/separator.svg",
                        color: Interface.light,
                        background: Interface.dark,
                        onTap: () {
                          _addSeparator();
                        })),
                //ADD
                Container(
                    margin: const EdgeInsets.only(right: 20, bottom: 17.5),
                    child: WidgetButton(
                        icon: "assets/graphics/icons/plus.svg",
                        color: Interface.accent,
                        background: Interface.primary,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityLogsAddEdit(fromTrophyLodge: widget.trophyLodge, callback: _reload)));
                          _focus();
                        }))
              ]))),
    );
  }

  Widget _buildWidgets() {
    _scaffoldMessengerState = ScaffoldMessenger.of(context);
    return WidgetScaffold.withCustomBody(
        body: Stack(children: [
      Column(mainAxisSize: MainAxisSize.max, children: [
        WidgetAppBar(
          text: widget.trophyLodge ? tr('trophy_lodge') : tr('logbook'),
          fontSize: Interface.s30,
          context: context,
        ),
        Container(
            height: 60,
            color: Interface.logsInfoBackground,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                    flex: 1,
                    child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                          width: 20,
                          height: 25,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 3),
                          child: SvgPicture.asset(
                            "assets/graphics/icons/list.svg",
                            height: 14,
                            width: 14,
                            color: Interface.alwaysLight,
                          )),
                      Container(
                          height: 25,
                          alignment: Alignment.center,
                          child: AutoSizeText(_numberOfLogs.toString(),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Interface.alwaysLight,
                                fontSize: Interface.s18,
                                fontWeight: FontWeight.w600,
                              )))
                    ])),
                Expanded(
                    flex: 1,
                    child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                          width: 20,
                          height: 25,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 3),
                          child: SvgPicture.asset(
                            "assets/graphics/icons/list.svg",
                            height: 14,
                            width: 14,
                            color: Interface.red,
                          )),
                      Container(
                          height: 25,
                          alignment: Alignment.center,
                          child: AutoSizeText(_numberOfCorruptedLogs.toString(),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Interface.red,
                                fontSize: Interface.s18,
                                fontWeight: FontWeight.w600,
                              )))
                    ])),
                Expanded(
                    flex: 1,
                    child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                          width: 20,
                          height: 25,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 3),
                          child: SvgPicture.asset(
                            "assets/graphics/icons/trophy_none.svg",
                            height: 17,
                            width: 17,
                            color: Interface.disabled,
                          )),
                      Container(
                          height: 25,
                          alignment: Alignment.center,
                          child: AutoSizeText(_numberOfNoneLogs.toString(),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Interface.disabled,
                                fontSize: Interface.s18,
                                fontWeight: FontWeight.w600,
                              )))
                    ])),
                Expanded(
                    flex: 1,
                    child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                          width: 20,
                          height: 25,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 3),
                          child: SvgPicture.asset(
                            "assets/graphics/icons/trophy_great_one.svg",
                            height: 16,
                            width: 16,
                            color: Interface.alwaysLight,
                          )),
                      Container(
                          height: 25,
                          alignment: Alignment.center,
                          child: AutoSizeText(_numberOfGreatOneLogs.toString(),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Interface.alwaysLight,
                                fontSize: Interface.s18,
                                fontWeight: FontWeight.w600,
                              )))
                    ]))
              ]),
              Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                    flex: 1,
                    child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                          width: 20,
                          height: 25,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 3),
                          child: SvgPicture.asset(
                            "assets/graphics/icons/trophy_bronze.svg",
                            height: 17,
                            width: 17,
                            color: Interface.trophyBronze,
                          )),
                      Container(
                          height: 25,
                          alignment: Alignment.center,
                          child: AutoSizeText(_numberOfBronzeLogs.toString(),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Interface.trophyBronze,
                                fontSize: Interface.s18,
                                fontWeight: FontWeight.w600,
                              )))
                    ])),
                Expanded(
                    flex: 1,
                    child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                          width: 20,
                          height: 25,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 3),
                          child: SvgPicture.asset(
                            "assets/graphics/icons/trophy_silver.svg",
                            height: 17,
                            width: 17,
                            color: Interface.trophySilver,
                          )),
                      Container(
                          height: 25,
                          alignment: Alignment.center,
                          child: AutoSizeText(_numberOfSilverLogs.toString(),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Interface.trophySilver,
                                fontSize: Interface.s18,
                                fontWeight: FontWeight.w600,
                              )))
                    ])),
                Expanded(
                    flex: 1,
                    child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                          width: 20,
                          height: 25,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 3),
                          child: SvgPicture.asset(
                            "assets/graphics/icons/trophy_gold.svg",
                            height: 17,
                            width: 17,
                            color: Interface.trophyGold,
                          )),
                      Container(
                          height: 25,
                          alignment: Alignment.center,
                          child: AutoSizeText(_numberOfGoldLogs.toString(),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Interface.trophyGold,
                                fontSize: Interface.s18,
                                fontWeight: FontWeight.w600,
                              )))
                    ])),
                Expanded(
                    flex: 1,
                    child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                          width: 20,
                          height: 25,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 3),
                          child: SvgPicture.asset(
                            "assets/graphics/icons/trophy_diamond.svg",
                            height: 17,
                            width: 17,
                            color: Interface.trophyDiamond,
                          )),
                      Container(
                          height: 25,
                          alignment: Alignment.center,
                          child: AutoSizeText(_numberOfDiamondLogs.toString(),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Interface.trophyDiamond,
                                fontSize: Interface.s18,
                                fontWeight: FontWeight.w600,
                              )))
                    ]))
              ])
            ])),
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
      ]),
      _buildYesNo()
    ]));
  }

  @override
  Widget build(BuildContext context) {
    _reload();
    return _buildWidgets();
  }
}
