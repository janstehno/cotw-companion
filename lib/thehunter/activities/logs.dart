// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/controller_search.dart';
import 'package:cotwcompanion/helpers/helper_filter.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_log.dart';
import 'package:cotwcompanion/helpers/helper_settings.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/helpers/multi_sort.dart';
import 'package:cotwcompanion/thehunter/activities/add_edit_log.dart';
import 'package:cotwcompanion/thehunter/activities/logs_information.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/model/animal_fur.dart';
import 'package:cotwcompanion/thehunter/model/log.dart';
import 'package:cotwcompanion/thehunter/model/reserve.dart';
import 'package:cotwcompanion/thehunter/widgets/log.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_button.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold_advanced.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_searchbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_snackbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_switch.dart';
import 'package:cotwcompanion/thehunter/widgets/sort_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ActivityLogs extends StatefulWidget {
  final bool trophyLodge;

  const ActivityLogs({Key? key, required this.trophyLodge}) : super(key: key);

  @override
  ActivityLogsState createState() => ActivityLogsState();
}

class ActivityLogsState extends State<ActivityLogs> {
  final List<Log> _filtered = [];

  final List<String> _criteriaNames = ['NAME', 'TROPHY', 'DATE'];

  late Settings _settings;
  late ScaffoldMessengerState _scaffoldMessengerState;

  bool _sortOptionsOpened = false;
  bool _viewOptionsOpened = false;
  bool _fileOptionsOpened = false;
  bool _yesNoOpened = false;
  bool _showTrophyLodgeRecords = false;
  bool _showDateOfRecord = false;

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

  final _controller = TextEditingControllerWorkaround(text: "");
  final equalsNumber = RegExp(r'^([0-9]){1,5}(\.{1}[0-9]{1,3})?$');
  final greaterNumber = RegExp(r'^>([0-9]){1,5}(\.{1}[0-9]{1,3})?$');
  final lesserNumber = RegExp(r'^<([0-9]){1,5}(\.{1}[0-9]{1,3})?$');
  final equalsString = RegExp(r'^[\D ]+$');

  @override
  void initState() {
    _filtered.addAll(LogHelper.logs);
    _controller.addListener(() => _filter());
    _settings = Provider.of<Settings>(context, listen: false);
    _showDateOfRecord = _settings.getDateOfRecord;
    _showTrophyLodgeRecords = _settings.getTrophyLodgeRecord;
    _filter();
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
      String searchText = _controller.text;
      List<List<dynamic>> compareList = _getCompareList(searchText);
      _filtered.addAll(HelperFilter.filterByMultipleCriteria(compareList, searchText, context));

      if (!widget.trophyLodge && !_showTrophyLodgeRecords) {
        _filtered.removeWhere((log) => log.getLodge);
      }
      if (widget.trophyLodge) {
        _filtered.removeWhere((log) => !log.getLodge);
      }

      _filtered.sort((a, b) => b.getDateCompare.compareTo(a.getDateCompare));
      if (_preferences.isNotEmpty) _filtered.multiSort(_criteria, _preferences);

      _countLogs();
    });
  }

  _focus() {
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
    for (String s in searchTextList) {
      if (s.isNotEmpty) {
        if (equalsString.hasMatch(s)) {
          values.add(s);
          types.add(0);
        } else if (equalsNumber.hasMatch(s)) {
          if (!types.contains(2) && !types.contains(3)) {
            values.add(double.parse(s));
            types.add(1);
          }
        } else if (greaterNumber.hasMatch(s)) {
          if (!types.contains(1) && !types.contains(2)) {
            values.add(double.parse(s.split(">")[1]));
            types.add(2);
          }
        } else if (lesserNumber.hasMatch(s)) {
          if (!types.contains(1) && !types.contains(3)) {
            values.add(double.parse(s.split("<")[1]));
            types.add(3);
          }
        }
      }
    }
    compareList.add(values);
    compareList.add(types);
    return compareList;
  }

  _countLogs() {
    _numberOfCorruptedLogs = LogHelper.corruptedLogs.length;
    _numberOfLogs = _filtered.length;
    _numberOfNoneLogs = 0;
    _numberOfBronzeLogs = 0;
    _numberOfSilverLogs = 0;
    _numberOfGoldLogs = 0;
    _numberOfDiamondLogs = 0;
    _numberOfGreatOneLogs = 0;
    for (Log l in _filtered) {
      Animal a = JSONHelper.getAnimal(l.getAnimalID);
      int t = _getTrophyRating(a, l);
      switch (t) {
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

  int _getTrophyRating(Animal a, Log l) {
    double trophy = l.getTrophy;
    double silver = a.getSilver;
    double gold = a.getGold;
    double diamond = a.getDiamond;
    int decrease = l.getHarvestCheck ? 0 : 1;
    if (l.getFurID == Values.greatOneID) {
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

  _removeLogs() {
    setState(() {
      LogHelper.removeLogs();
      _filter();
    });
  }

  _changeView() {
    setState(() {
      _settings.changeCompactLogbook();
    });
  }

  _showFileOptions() {
    setState(() {
      _fileOptionsOpened = !_fileOptionsOpened;
      _viewOptionsOpened = false;
      _sortOptionsOpened = false;
      _focus();
    });
  }

  _showViewOptions() {
    setState(() {
      _fileOptionsOpened = false;
      _viewOptionsOpened = !_viewOptionsOpened;
      _sortOptionsOpened = false;
      _focus();
    });
  }

  _showSortOptions() {
    setState(() {
      _fileOptionsOpened = false;
      _viewOptionsOpened = false;
      _sortOptionsOpened = !_sortOptionsOpened;
      _focus();
    });
  }

  _addSeparator(bool b) {
    String searchText = b ? _controller.text += "|" : _controller.text;
    _controller.setTextAndPosition(searchText);
  }

  _resetPreferencesAndCriteria() {
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
          _filter();
        });
      });
    });
  }

  _setPreferencesAndCriteria(int pref) {
    String p = _criteriaNames[pref];
    if (!_preferences.contains(p)) {
      _preferences.add(p);
      switch (pref) {
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
      switch (pref) {
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
    _filter();
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
    final bool b = await LogHelper.loadFile();
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
    final bool b = await LogHelper.saveFile();
    if (b) {
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
            color: Color(Values.colorSearchBackground),
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
                color: Color(Values.colorShadow).withOpacity(0.8),
                child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                      padding: const EdgeInsets.all(30),
                      alignment: Alignment.center,
                      child: AutoSizeText(tr('remove_all_items'),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(Values.colorAlwaysLight), fontSize: Values.fontSize20, fontWeight: FontWeight.w600))),
                  Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    WidgetButton(
                        icon: "assets/graphics/icons/remove_bin.svg",
                        size: 80,
                        color: Values.colorAlwaysDark,
                        background: Values.colorFirst,
                        onTap: () {
                          setState(() {
                            _removeLogs();
                            _yesNoOpened = false;
                            _focus();
                          });
                        }),
                    WidgetButton(
                        icon: "assets/graphics/icons/menu_close.svg",
                        size: 80,
                        color: Values.colorLight,
                        background: Values.colorDark,
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
    return ListView.builder(
        itemCount: _filtered.length,
        itemBuilder: (context, index) {
          Log log = _filtered[index];
          Animal animal = log.getAnimal();
          Reserve reserve = log.getReserve();
          AnimalFur animalFur = log.getAnimalFur();
          bool last = false;
          index == _filtered.length - 1 ? last = true : last = false;
          return last
              ? Column(children: [
            EntryLog(
                log: log,
                animal: animal,
                reserve: reserve,
                animalFur: animalFur,
                index: index,
                trophyLodge: widget.trophyLodge,
                callback: _filter,
                context: context),
            const SizedBox(height: 75)
          ])
              : EntryLog(
              log: log,
              animal: animal,
              reserve: reserve,
              animalFur: animalFur,
              index: index,
              trophyLodge: widget.trophyLodge,
              callback: _filter,
              context: context);
        });
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
                        size: 40,
                        color: Values.colorLight,
                        background: Values.colorDark,
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
                                  size: 40,
                                  color: Values.colorAlwaysDark,
                                  background: Values.colorFirst,
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
                                  size: 40,
                                  color: Values.colorAccent,
                                  background: Values.colorPrimary,
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
                              child: WidgetSortButton(
                                  icon: "assets/graphics/icons/sort_date.svg",
                                  number: _datePreferenceSet + 1,
                                  ascended: !_dateCriteria,
                                  size: 40,
                                  activeColor: Values.colorAccent,
                                  activeBackground: Values.colorPrimary,
                                  inactiveColor: Values.colorLight,
                                  inactiveBackground: Values.colorDark,
                                  noInactiveOpacity: true,
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
                              child: WidgetSortButton(
                                  icon: "assets/graphics/icons/trophy_gold.svg",
                                  number: _trophyPreferenceSet + 1,
                                  ascended: !_trophyCriteria,
                                  size: 40,
                                  activeColor: Values.colorAccent,
                                  activeBackground: Values.colorPrimary,
                                  inactiveColor: Values.colorLight,
                                  inactiveBackground: Values.colorDark,
                                  noInactiveOpacity: true,
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
                          child: WidgetSortButton(
                              icon: "assets/graphics/icons/sort_az.svg",
                              number: _namePreferenceSet + 1,
                              ascended: _nameCriteria,
                              size: 40,
                              activeColor: Values.colorAccent,
                              activeBackground: Values.colorPrimary,
                              inactiveColor: Values.colorLight,
                              inactiveBackground: Values.colorDark,
                              noInactiveOpacity: true,
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
                              size: 40,
                              color: Values.colorLight,
                              background: Values.colorDark,
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
                                  icon: "assets/graphics/icons/trophy_lodge.svg",
                                  size: 40,
                                  activeColor: Values.colorAccent,
                                  activeBackground: Values.colorPrimary,
                                  inactiveColor: Values.colorLight,
                                  inactiveBackground: Values.colorDark,
                                  noInactiveOpacity: true,
                                  isActive: _settings.getTrophyLodgeRecord,
                                  onTap: () {
                                    setState(() {
                                      _showTrophyLodgeRecords = !_showTrophyLodgeRecords;
                                      _settings.changeTrophyLodgeRecord();
                                      _filter();
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
                                  icon: "assets/graphics/icons/sort_date.svg",
                                  size: 40,
                                  activeColor: Values.colorAccent,
                                  activeBackground: Values.colorPrimary,
                                  inactiveColor: Values.colorLight,
                                  inactiveBackground: Values.colorDark,
                                  noInactiveOpacity: true,
                                  isActive: _settings.getDateOfRecord,
                                  onTap: () {
                                    setState(() {
                                      _showDateOfRecord = !_showDateOfRecord;
                                      _settings.changeDateOfRecord();
                                      _filter();
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
                                  size: 40,
                                  color: Values.colorLight,
                                  background: Values.colorDark,
                                  onTap: () {
                                    setState(() {
                                      _changeView();
                                      _focus();
                                    });
                                  }))),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: WidgetButton(
                              icon: "assets/graphics/icons/fullscreen.svg",
                              size: 40,
                              color: Values.colorLight,
                              background: Values.colorDark,
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
                        size: 40,
                        color: Values.colorLight,
                        background: Values.colorDark,
                        onTap: () {
                          _addSeparator(true);
                        })),
                //ADD
                Container(
                    margin: const EdgeInsets.only(right: 20, bottom: 17.5),
                    child: WidgetButton(
                        icon: "assets/graphics/icons/plus.svg",
                        size: 40,
                        color: Values.colorAccent,
                        background: Values.colorPrimary,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityLogsAddEdit(fromTrophyLodge: widget.trophyLodge, callback: _filter)));
                          _focus();
                        }))
              ]))),
    );
  }

  Widget _buildWidgets() {
    _scaffoldMessengerState = ScaffoldMessenger.of(context);
    return WidgetScaffoldAdvanced(
        body: Stack(children: [
          Column(mainAxisSize: MainAxisSize.max, children: [
            WidgetAppBar(
              text: widget.trophyLodge ? tr('trophy_lodge') : tr('logbook'),
              height: 90,
              fontSize: Values.fontSize30,
              fontWeight: FontWeight.w700,
              alignment: Alignment.centerRight,
              function: () {
                Navigator.pop(context);
              },
            ),
            Container(
                height: 60,
                color: Color(Values.colorContentNumberOfLogsBackground),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 20,
                                  height: 25,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(right: 3),
                                  child:
                                  SvgPicture.asset("assets/graphics/icons/list.svg", height: 14, width: 14, color: Color(Values.colorAlwaysLight))),
                              Container(
                                  height: 25,
                                  alignment: Alignment.center,
                                  child: AutoSizeText(_numberOfLogs.toString(),
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(color: Color(Values.colorAlwaysLight), fontSize: Values.fontSize18, fontWeight: FontWeight.w600)))
                            ])),
                    Expanded(
                        flex: 1,
                        child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                          Container(width: 20, height: 25, alignment: Alignment.center, margin: const EdgeInsets.only(right: 3), child: SvgPicture.asset("assets/graphics/icons/list.svg", height: 14, width: 14, color: const Color(Values.colorFirst))),
                          Container(height: 25, alignment: Alignment.center, child: AutoSizeText(_numberOfCorruptedLogs.toString(), maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: const Color(Values.colorFirst), fontSize: Values.fontSize18, fontWeight: FontWeight.w600)))
                        ])),
                    Expanded(
                        flex: 1,
                        child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                          Container(width: 20, height: 25, alignment: Alignment.center, margin: const EdgeInsets.only(right: 3), child: SvgPicture.asset("assets/graphics/icons/trophy_none.svg", height: 17, width: 17, color: Color(Values.colorDisabled))),
                          Container(height: 25, alignment: Alignment.center, child: AutoSizeText(_numberOfNoneLogs.toString(), maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Color(Values.colorDisabled), fontSize: Values.fontSize18, fontWeight: FontWeight.w600)))
                        ])),
                    Expanded(
                        flex: 1,
                        child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                          Container(
                              width: 20,
                              height: 25,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 3),
                              child: SvgPicture.asset("assets/graphics/icons/trophy_great_one.svg", height: 16, width: 16, color: Color(Values.colorAlwaysLight))),
                          Container(
                              height: 25,
                              alignment: Alignment.center,
                              child: AutoSizeText(_numberOfGreatOneLogs.toString(),
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Color(Values.colorAlwaysLight), fontSize: Values.fontSize18, fontWeight: FontWeight.w600)))
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
                              child: SvgPicture.asset("assets/graphics/icons/trophy_bronze.svg", height: 17, width: 17, color: Color(Values.colorBronze))),
                          Container(
                              height: 25,
                              alignment: Alignment.center,
                              child: AutoSizeText(_numberOfBronzeLogs.toString(),
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Color(Values.colorBronze), fontSize: Values.fontSize18, fontWeight: FontWeight.w600)))
                        ])),
                    Expanded(
                        flex: 1,
                        child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                          Container(
                              width: 20,
                              height: 25,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 3),
                              child: SvgPicture.asset("assets/graphics/icons/trophy_silver.svg", height: 17, width: 17, color: Color(Values.colorSilver))),
                          Container(
                              height: 25,
                              alignment: Alignment.center,
                              child: AutoSizeText(_numberOfSilverLogs.toString(),
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Color(Values.colorSilver), fontSize: Values.fontSize18, fontWeight: FontWeight.w600)))
                        ])),
                    Expanded(
                        flex: 1,
                        child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                          Container(
                              width: 20,
                              height: 25,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 3),
                              child: SvgPicture.asset("assets/graphics/icons/trophy_gold.svg", height: 17, width: 17, color: Color(Values.colorGold))),
                          Container(
                              height: 25,
                              alignment: Alignment.center,
                              child: AutoSizeText(_numberOfGoldLogs.toString(),
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Color(Values.colorGold), fontSize: Values.fontSize18, fontWeight: FontWeight.w600)))
                        ])),
                    Expanded(
                        flex: 1,
                        child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                          Container(
                              width: 20,
                              height: 25,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 3),
                              child: SvgPicture.asset("assets/graphics/icons/trophy_diamond.svg", height: 17, width: 17, color: Color(Values.colorDiamond))),
                          Container(
                              height: 25,
                              alignment: Alignment.center,
                              child: AutoSizeText(_numberOfDiamondLogs.toString(),
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Color(Values.colorDiamond), fontSize: Values.fontSize18, fontWeight: FontWeight.w600)))
                        ]))
                  ])
                ])),
            Expanded(flex: 0, child: WidgetSearchBar(background: Values.colorSearchBackground, color: Values.colorSearch, controller: _controller)),
            Expanded(child: _buildStack())
          ]),
          _buildYesNo()
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
