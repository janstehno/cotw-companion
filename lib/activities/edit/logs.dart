// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/lists/logs/add_edit_log/trophy_lodge_logs.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/log.dart';
import 'package:cotwcompanion/miscellaneous/helpers/logger.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/miscellaneous/interface/values.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/animal_fur.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/drop_down.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:cotwcompanion/widgets/switch_icon.dart';
import 'package:cotwcompanion/widgets/text_field_indicator.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:cotwcompanion/widgets/title_big_button.dart';
import 'package:cotwcompanion/widgets/title_big_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';

class ActivityEditLogs extends StatefulWidget {
  final int animalId;
  final int reserveId;
  final Log? log;
  final bool fromTrophyLodge;
  final Function callback;

  const ActivityEditLogs({
    Key? key,
    this.animalId = -1,
    this.reserveId = -1,
    this.log,
    required this.fromTrophyLodge,
    required this.callback,
  }) : super(key: key);

  @override
  ActivityEditLogsState createState() => ActivityEditLogsState();
}

class ActivityEditLogsState extends State<ActivityEditLogs> {
  final TextEditingController _controllerTrophyNumber = TextEditingController();
  final TextEditingController _controllerWeightNumber = TextEditingController();
  final RegExp _equalsDoubleTrophyNumber = RegExp(r"^\d{1,4}(\.\d{1,3})?$");
  final RegExp _equalsDoubleWeightNumber = RegExp(r"^\d{1,4}(\.\d{1,3})?$");
  final HelperLogger _logger = HelperLogger("[LOGS] [ADD & EDIT]");
  final List<Animal> _animals = [];
  final List<AnimalFur> _furs = [];
  final List<Log> _trophyLodgeLogs = [];
  final double _dateHeight = 70;
  final double _addButtonSize = 60;
  final double _safeSpaceHeight = 100;

  DateTime _dateTime = DateTime.now();
  int _minute = DateTime.now().minute;
  int _hour = DateTime.now().hour;
  int _day = DateTime.now().day;
  int _month = DateTime.now().month;
  int _year = DateTime.now().year;

  bool _init = true;
  bool _editing = false;
  bool _fromOtherSource = false;

  bool _reserveChanged = false;
  bool _animalChanged = false;
  bool _genderChanged = false;
  bool _furChanged = false;

  bool _correctTrophyNumber = true;
  bool _correctWeightNumber = true;

  bool _isInLodge = false;
  bool _isMale = true;
  bool _usesImperials = false;
  bool _correctAmmoUsed = true;
  bool _twoShotsFired = true;
  bool _vitalOrganHit = true;
  bool _trophyOrganUndamaged = true;
  double _trophy = 0;
  double _weight = 0;
  double _maxTrophy = 0;
  double _maxWeight = 0;

  int _trophyRating = 0;
  int _selectedReserve = 0;
  int _selectedReserveId = 0;
  int _selectedAnimal = 0;
  int _selectedAnimalId = 0;
  int _selectedFur = 0;
  int _selectedFurId = 0;

  @override
  void initState() {
    _usesImperials = Provider.of<Settings>(context, listen: false).imperialUnits;
    _controllerTrophyNumber.addListener(() => _textTrophyAndWeightListener(0));
    _controllerWeightNumber.addListener(() => _textTrophyAndWeightListener(1));
    super.initState();
  }

  void _initialize() {
    if (widget.animalId != -1 && widget.reserveId != -1) {
      //WHEN CREATING ENTRY FROM RESERVE'S ANIMAL LIST OR FROM NEED ZONES FEATURE
      _fromOtherSource = true;
      _selectedReserveId = widget.reserveId;
      _selectedReserve = _selectedReserveId - 1;
      _selectedAnimalId = widget.animalId;
    } else if (widget.log != null) {
      //WHEN EDITING
      _editing = true;
      _isMale = widget.log!.isMale;
      _usesImperials = widget.log!.usesImperials;
      _isInLodge = widget.log!.isInLodge;
      _correctAmmoUsed = widget.log!.correctAmmoUsed;
      _twoShotsFired = widget.log!.twoShotsFired;
      _vitalOrganHit = widget.log!.vitalOrganHit;
      _trophyOrganUndamaged = widget.log!.trophyOrganUndamaged;
      _trophyRating = widget.log!.trophyRating;
      _trophy = widget.log!.trophy;
      _weight = widget.log!.weight;
      _selectedReserveId = widget.log!.reserveId;
      _selectedReserve = widget.log!.reserveId - 1;
      _selectedAnimalId = widget.log!.animalId;
      _selectedFurId = widget.log!.furId;
      _dateTime = _getDateTime(widget.log!.date);
      _controllerTrophyNumber.text = _trophy.toString().split(".")[1] == "0" ? _trophy.toString().split(".")[0] : _trophy.toString();
      _controllerWeightNumber.text = _weight.toString().split(".")[1] == "0" ? _weight.toString().split(".")[0] : _weight.toString();
    } else {
      //OTHERWISE
      _logger.i("Creating log");
      _selectedReserve = 0;
      _selectedReserveId = 1;
      _getAnimalsData();
      _getAnimal(true);
      _getFursData();
      _getFur(true);
    }
  }

  void _reload() {
    if (_init) {
      _initialize();
      _init = false;
    }
    if (_fromOtherSource) {
      _logger.i("Creating log from other source");
      _getAnimalsData();
      _getAnimal(false);
      _getFursData();
      _getFur(true);
      _fromOtherSource = false;
    } else if (_editing) {
      _logger.i("Editing log");
      _getAnimalsData();
      _getAnimal(false);
      _getFursData();
      _getFur(false);
      _editing = false;
    } else if (_reserveChanged) {
      _logger.i("Reserve changed");
      _selectedReserveId = HelperJSON.reserves[_selectedReserve].id;
      _getAnimalsData();
      _getAnimal(true);
      _getFursData();
      _getFur(true);
      _reserveChanged = false;
    } else if (_animalChanged) {
      _logger.i("Animal changed");
      _getAnimal(false);
      _getFursData();
      _getFur(true);
      _animalChanged = false;
    } else if (_furChanged) {
      _logger.i("Fur changed");
      _getFur(false);
      _furChanged = false;
    } else if (_genderChanged) {
      _logger.i("Gender changed");
      _getFursData();
      _getFur(true);
      _genderChanged = false;
    }
    _getTrophyOf(_animals.elementAt(_selectedAnimal));
  }

  void _textTrophyAndWeightListener(int controller) {
    setState(() {
      if (controller == 0) {
        if (_equalsDoubleTrophyNumber.hasMatch(_controllerTrophyNumber.text)) {
          _correctTrophyNumber = true;
          _trophy = double.parse(_controllerTrophyNumber.text);
        } else {
          if (_controllerTrophyNumber.text.isEmpty) {
            _correctTrophyNumber = true;
            _trophy = 0;
          } else {
            _correctTrophyNumber = false;
            _trophy = 0;
          }
        }
      } else if (controller == 1) {
        if (_equalsDoubleWeightNumber.hasMatch(_controllerWeightNumber.text)) {
          _correctWeightNumber = true;
          _weight = double.parse(_controllerWeightNumber.text);
        } else {
          if (_controllerWeightNumber.text.isEmpty) {
            _correctWeightNumber = true;
            _weight = 0;
          } else {
            _correctWeightNumber = false;
            _weight = 0;
          }
        }
      }
    });
  }

  void _getAnimalsData() {
    _logger.t("Getting animals");
    _animals.clear();
    if (widget.fromTrophyLodge) {
      _animals.addAll(HelperJSON.animals);
    } else {
      for (IdtoId iti in HelperJSON.animalsReserves) {
        if (iti.secondId == _selectedReserveId) {
          _animals.add(HelperJSON.getAnimal(iti.firstId));
        }
      }
    }
    _animals.sort((a, b) => a.getNameBasedOnReserve(context.locale, _selectedReserveId).compareTo(b.getNameBasedOnReserve(context.locale, _selectedReserveId)));
  }

  void _getAnimal(bool init) {
    if (init) {
      _selectedAnimal = 0;
      _selectedAnimalId = _animals.elementAt(_selectedAnimal).id;
    } else if (_fromOtherSource || _editing) {
      for (Animal animal in _animals) {
        if (animal.id == _selectedAnimalId) _selectedAnimal = _animals.indexOf(animal);
      }
    } else {
      _selectedAnimalId = _animals.elementAt(_selectedAnimal).id;
    }
    _logger.t("Selected animal NUM $_selectedAnimal with ID $_selectedAnimalId");
    if (widget.log == null) _getTrophyLodgeEntries();
  }

  void _getFursData() {
    _logger.t("Getting furs");
    _furs.clear();
    for (AnimalFur animalFur in HelperJSON.animalsFurs) {
      if (animalFur.animalId == _selectedAnimalId) {
        if ((!animalFur.male && !animalFur.female) || (animalFur.male && _isMale) || (animalFur.female && !_isMale)) {
          _furs.add(animalFur);
        }
      }
    }
    _furs.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
  }

  void _getFur(bool init) {
    if (init) {
      _selectedFur = 0;
      _selectedFurId = _furs.elementAt(_selectedFur).furId;
    } else if (_editing) {
      for (AnimalFur animalFur in _furs) {
        if (animalFur.furId == _selectedFurId) _selectedFur = _furs.indexOf(animalFur);
      }
    } else {
      _selectedFurId = _furs.elementAt(_selectedFur).furId;
    }
    _logger.t("Selected fur NUM $_selectedFur with ID $_selectedFurId");
  }

  void _getTrophyOf(Animal animal) {
    if (_selectedFurId == Values.greatOneId) {
      //GREAT ONE
      _maxTrophy = animal.trophyGO;
      _maxWeight = animal.weightGO(_usesImperials);
    } else {
      _maxTrophy = animal.trophy;
      _maxWeight = animal.weight(_usesImperials);
    }
  }

  void _getTrophyLodgeEntries() {
    _trophyLodgeLogs.clear();
    for (Log log in HelperLog.logs) {
      if (log.animalId == _selectedAnimalId && log.isInLodge) _trophyLodgeLogs.add(log);
    }
    _trophyLodgeLogs.sort((a, b) => b.trophy.compareTo(a.trophy));
    _logger.t("Found ${_trophyLodgeLogs.length} trophy lodge entry/entries with this animal");
  }

  List<DropdownMenuItem> _listOfReserves() {
    List<DropdownMenuItem> dropItems = [];
    for (int index = 0; index < HelperJSON.reserves.length; index++) {
      dropItems.add(DropdownMenuItem(
          value: index,
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 50,
              padding: const EdgeInsets.only(left: 30, right: 30),
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                HelperJSON.reserves.elementAt(index).getName(context.locale),
                maxLines: 1,
                style: Interface.s16w300n(Interface.dark),
              ))));
    }
    return dropItems;
  }

  List<DropdownMenuItem> _listOfAnimals() {
    List<DropdownMenuItem> dropItems = [];
    for (int index = 0; index < _animals.length; index++) {
      dropItems.add(DropdownMenuItem(
          value: index,
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 50,
              padding: const EdgeInsets.only(left: 30, right: 30),
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                _animals.elementAt(index).getNameBasedOnReserve(context.locale, _selectedReserveId),
                maxLines: 1,
                style: Interface.s16w300n(Interface.dark),
              ))));
    }
    return dropItems;
  }

  List<DropdownMenuItem> _listOfFurs() {
    List<DropdownMenuItem> dropItems = [];
    for (int index = 0; index < _furs.length; index++) {
      dropItems.add(DropdownMenuItem(
          value: index,
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 50,
              padding: const EdgeInsets.only(left: 30, right: 30),
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                _furs.elementAt(index).getName(context.locale),
                maxLines: 1,
                style: Interface.s16w300n(Interface.dark),
              ))));
    }
    return dropItems;
  }

  DateTime _getDateTime(String dateTime) {
    _year = int.parse(dateTime.split("-")[0]);
    _month = int.parse(dateTime.split("-")[1]);
    _day = int.parse(dateTime.split("-")[2]);
    _hour = int.parse(dateTime.split("-")[3]);
    _minute = int.parse(dateTime.split("-")[4]);
    return DateTime(_year, _month, _day, _hour, _minute);
  }

  void _focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _getHarvestCheck() {
    if (widget.fromTrophyLodge) {
      _correctAmmoUsed = true;
      _twoShotsFired = true;
      _vitalOrganHit = true;
      _trophyOrganUndamaged = true;
    }
  }

  Log _createLog() => Log(
        id: widget.log == null ? HelperLog.logs.length : widget.log!.id,
        date: Utils.dateToString(_dateTime),
        reserveId: widget.fromTrophyLodge ? -1 : _selectedReserveId,
        animalId: _selectedAnimalId,
        furId: _selectedFurId,
        trophy: _trophy,
        weight: _weight,
        imperials: _usesImperials ? 1 : 0,
        trophyRating: _trophyRating,
        lodge: widget.fromTrophyLodge || _isInLodge ? 1 : 0,
        gender: _isMale ? 1 : 0,
        harvestCorrectAmmo: _correctAmmoUsed ? 1 : 0,
        harvestTwoShots: _twoShotsFired ? 1 : 0,
        harvestVitalOrgan: _vitalOrganHit ? 1 : 0,
        harvestNoTrophyOrgan: _trophyOrganUndamaged ? 1 : 0,
        animalName: HelperJSON.getAnimal(_selectedAnimalId).getNameBasedOnReserve(context.locale, _selectedReserveId),
        corrupted: false,
      );

  Widget _buildDate() {
    return GestureDetector(
        onTap: () async {
          _focus();
          _dateTime = (await showOmniDateTimePicker(
                context: context,
                theme: ThemeData(
                  colorScheme: Interface.omniDatePickerScheme,
                ),
                is24HourMode: true,
                isShowSeconds: false,
                initialDate: _dateTime,
                firstDate: DateTime(2017),
                lastDate: DateTime(2030, 12, 31),
              )) ??
              _dateTime;
          setState(() {});
        },
        child: Container(
            height: _dateHeight,
            color: Interface.title,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
              AutoSizeText(
                tr("time").toUpperCase(),
                maxLines: 1,
                textAlign: TextAlign.start,
                style: Interface.s20w600c(Interface.dark),
              ),
              AutoSizeText(
                Log.getDate(DateStructure.format, Utils.dateToString(_dateTime)),
                maxLines: 1,
                textAlign: TextAlign.start,
                style: Interface.s16w300n(Interface.dark),
              )
            ])));
  }

  Widget _buildReserve() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("reserve"),
      ),
      WidgetDropDown(
          value: _selectedReserve,
          items: _listOfReserves(),
          onTap: (dynamic value) {
            setState(() {
              _focus();
              _selectedReserve = value;
              _reserveChanged = true;
            });
          })
    ]);
  }

  Widget _buildAnimal() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("animal"),
      ),
      WidgetDropDown(
          value: _selectedAnimal,
          items: _listOfAnimals(),
          onTap: (dynamic value) {
            setState(() {
              _focus();
              _selectedAnimal = value;
              _animalChanged = true;
            });
          })
    ]);
  }

  Widget _buildFur() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("animal_fur"),
      ),
      WidgetDropDown(
          value: _selectedFur,
          items: _listOfFurs(),
          onTap: (dynamic value) {
            setState(() {
              _focus();
              _selectedFur = value;
              _furChanged = true;
            });
          })
    ]);
  }

  Widget _buildGender() {
    return Column(children: [
      WidgetTitleBigSwitch(
          primaryText: tr("animal_gender"),
          icon: "assets/graphics/icons/gender_female.svg",
          color: Interface.alwaysDark,
          background: Interface.red,
          activeIcon: "assets/graphics/icons/gender_male.svg",
          activeColor: Interface.alwaysDark,
          activeBackground: Interface.blue,
          isActive: _isMale,
          onTap: () {
            setState(() {
              _focus();
              _isMale = !_isMale;
              _genderChanged = true;
            });
          })
    ]);
  }

  Widget _buildTrophy() {
    _textTrophyAndWeightListener(0);
    return Column(children: [
      widget.log != null
          ? WidgetTitleBig(
              primaryText: tr("animal_trophy"),
              secondaryText: "${tr("max")}: ${_maxTrophy == 0 ? "?" : _maxTrophy.toString()}",
            )
          : WidgetTitleBigButton(
              primaryText: tr("animal_trophy"),
              secondaryText: "${tr("max")}: ${_maxTrophy == 0 ? "?" : _maxTrophy.toString()}",
              icon: "assets/graphics/icons/menu_open.svg",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ListTrophyLodgeLogs(trophyLodgeLogs: _trophyLodgeLogs)));
              }),
      WidgetTextFieldIndicator(
        correct: _correctTrophyNumber,
        controller: _controllerTrophyNumber,
      )
    ]);
  }

  Widget _buildWeight() {
    _textTrophyAndWeightListener(1);
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("animal_weight"),
        secondaryText: "${tr("max")}: ${_maxWeight == 0 ? "?" : _maxWeight.toString()}",
      ),
      WidgetTextFieldIndicator(
        correct: _correctWeightNumber,
        controller: _controllerWeightNumber,
      )
    ]);
  }

  Widget _buildHarvestCheck() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("harvest_check"),
      ),
      Container(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
            WidgetSwitchIcon(
              icon: "assets/graphics/icons/harvest_correct_ammo.svg",
              isActive: _correctAmmoUsed,
              onTap: () {
                setState(() {
                  _focus();
                  _correctAmmoUsed = !_correctAmmoUsed;
                });
              },
            ),
            WidgetSwitchIcon(
                icon: "assets/graphics/icons/harvest_two_shots.svg",
                isActive: _twoShotsFired,
                onTap: () {
                  setState(() {
                    _focus();
                    _twoShotsFired = !_twoShotsFired;
                  });
                }),
            WidgetSwitchIcon(
                icon: "assets/graphics/icons/harvest_no_trophy_organ.svg",
                isActive: _trophyOrganUndamaged,
                onTap: () {
                  setState(() {
                    _focus();
                    _trophyOrganUndamaged = !_trophyOrganUndamaged;
                  });
                }),
            WidgetSwitchIcon(
                icon: "assets/graphics/icons/harvest_vital_organ.svg",
                isActive: _vitalOrganHit,
                onTap: () {
                  setState(() {
                    _focus();
                    _vitalOrganHit = !_vitalOrganHit;
                  });
                })
          ]))
    ]);
  }

  Widget _buildTrophyRating() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("trophy_rating"),
      ),
      Container(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
            WidgetSwitchIcon(
                icon: "assets/graphics/icons/trophy_none.svg",
                activeColor: Interface.light,
                activeBackground: Interface.trophyNone,
                isActive: _trophyRating == 0,
                onTap: () {
                  setState(() {
                    _focus();
                    _trophyRating = 0;
                  });
                }),
            WidgetSwitchIcon(
                icon: "assets/graphics/icons/trophy_bronze.svg",
                activeColor: Interface.alwaysDark,
                activeBackground: Interface.trophyBronze,
                isActive: _trophyRating == 1,
                onTap: () {
                  setState(() {
                    _focus();
                    _trophyRating = 1;
                  });
                }),
            WidgetSwitchIcon(
                icon: "assets/graphics/icons/trophy_silver.svg",
                activeColor: Interface.alwaysDark,
                activeBackground: Interface.trophySilver,
                isActive: _trophyRating == 2,
                onTap: () {
                  setState(() {
                    _focus();
                    _trophyRating = 2;
                  });
                }),
            WidgetSwitchIcon(
                icon: "assets/graphics/icons/trophy_gold.svg",
                activeColor: Interface.alwaysDark,
                activeBackground: Interface.trophyGold,
                isActive: _trophyRating == 3,
                onTap: () {
                  setState(() {
                    _focus();
                    _trophyRating = 3;
                  });
                }),
            WidgetSwitchIcon(
                icon: _selectedFurId == Values.greatOneId ? "assets/graphics/icons/trophy_great_one.svg" : "assets/graphics/icons/trophy_diamond.svg",
                activeColor: _selectedFurId == Values.greatOneId ? Interface.light : Interface.alwaysDark,
                activeBackground: _selectedFurId == Values.greatOneId ? Interface.trophyGreatOne : Interface.trophyDiamond,
                isActive: _trophyRating == 4,
                onTap: () {
                  setState(() {
                    _focus();
                    _trophyRating = 4;
                  });
                })
          ]))
    ]);
  }

  Widget _buildAdd() {
    return Positioned(
        right: 30,
        bottom: 30,
        child: SimpleShadow(
            sigma: 7,
            color: Interface.alwaysDark,
            child: WidgetButtonIcon(
              buttonSize: _addButtonSize,
              icon: widget.log != null ? "assets/graphics/icons/edit.svg" : "assets/graphics/icons/plus.svg",
              onTap: () {
                _focus();
                _getHarvestCheck();
                Log log = _createLog();
                widget.log != null ? HelperLog.editLog(log) : HelperLog.addLog(log);
                widget.callback();
                Navigator.pop(context);
              },
            )));
  }

  Widget _buildStack() {
    return Stack(fit: StackFit.expand, children: [
      WidgetScrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              WidgetAppBar(
                text: widget.log != null ? tr("edit") : tr("add"),
                context: context,
              ),
              _buildDate(),
              widget.fromTrophyLodge ? const SizedBox.shrink() : _buildReserve(),
              _buildAnimal(),
              _buildGender(),
              _buildFur(),
              _buildTrophy(),
              widget.fromTrophyLodge ? const SizedBox.shrink() : _buildWeight(),
              _buildTrophyRating(),
              widget.fromTrophyLodge ? const SizedBox.shrink() : _buildHarvestCheck(),
              SizedBox(
                height: _safeSpaceHeight,
              )
            ],
          ),
        ),
      ),
      _buildAdd(),
    ]);
  }

  Widget _buildWidgets() {
    _reload();
    return WidgetScaffold(
      customBody: true,
      body: _buildStack(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
