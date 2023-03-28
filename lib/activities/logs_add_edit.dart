// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/log.dart';
import 'package:cotwcompanion/miscellaneous/helpers/logger.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/animal_fur.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:cotwcompanion/widgets/title_functional.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/switch.dart';
import 'package:cotwcompanion/widgets/text_field.dart';
import 'package:cotwcompanion/widgets/title.dart';
import 'package:cotwcompanion/widgets/entries/trophy_lodge_record.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';

class ActivityLogsAddEdit extends StatefulWidget {
  final int animalId;
  final int reserveId;
  final Log? log;
  final bool fromTrophyLodge;
  final Function callback;

  const ActivityLogsAddEdit({
    Key? key,
    this.animalId = -1,
    this.reserveId = -1,
    this.log,
    required this.fromTrophyLodge,
    required this.callback,
  }) : super(key: key);

  @override
  ActivityLogsAddEditState createState() => ActivityLogsAddEditState();
}

class ActivityLogsAddEditState extends State<ActivityLogsAddEdit> {
  final TextEditingController _controllerTrophyNumber = TextEditingController();
  final TextEditingController _controllerWeightNumber = TextEditingController();
  final RegExp _equalsDoubleTrophyNumber = RegExp(r'^\d{1,4}(\.\d{1,3})?$');
  final RegExp _equalsDoubleWeightNumber = RegExp(r'^\d{1,4}(\.\d{1,3})?$');
  final HelperLogger _logger = HelperLogger("[LOGS] [ADD & EDIT]");
  final List<Animal> _animals = [];
  final List<AnimalFur> _furs = [];
  final List<DropdownMenuItem> _dropDownListReserves = [];
  final List<DropdownMenuItem> _dropDownListAnimals = [];
  final List<DropdownMenuItem> _dropDownListAnimalFurs = [];
  final List<Log> _trophyLodgeRecords = [];

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

  bool _recordsOpened = false;
  bool _correctTrophyNumber = true;
  bool _correctWeightNumber = true;
  bool _manuallySetTrophyRating = false;

  bool _isInLodge = false;
  bool _isMale = true;
  bool _usesImperials = false;
  bool _correctAmmoUsed = true;
  bool _twoShotsFired = true;
  bool _vitalOrganHit = true;
  bool _trophyOrganUndamaged = true;
  double _silver = 0;
  double _gold = 0;
  double _diamond = 0;
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
    _usesImperials = Provider.of<Settings>(context, listen: false).getImperialUnits;
    _controllerTrophyNumber.addListener(() => _textTrophyAndWeightListener(0));
    _controllerWeightNumber.addListener(() => _textTrophyAndWeightListener(1));
    super.initState();
  }

  void _initialize() {
    if (widget.animalId != -1 && widget.reserveId != -1) {
      //WHEN CREATING RECORD FROM RESERVE'S ANIMAL LIST OR FROM NEED ZONES FEATURE
      _fromOtherSource = true;
      _selectedReserveId = widget.reserveId;
      _selectedReserve = _selectedReserveId - 1;
      _selectedAnimalId = widget.animalId;
    } else if (widget.log != null) {
      //WHEN EDITING RECORD
      _editing = true;
      _isMale = widget.log!.isMale;
      _usesImperials = widget.log!.usesImperials;
      _isInLodge = widget.log!.isInLodge;
      _correctAmmoUsed = widget.log!.correctAmmoUsed;
      _twoShotsFired = widget.log!.twoShotsFired;
      _vitalOrganHit = widget.log!.vitalOrganHit;
      _trophyOrganUndamaged = widget.log!.trophyOrganUndamaged;
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
      _dropDownListReserves.clear();
      _dropDownListReserves.addAll(_listOfReserves());
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
      _getTrophyRating();
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
        if (_equalsDoubleTrophyNumber.hasMatch(_controllerTrophyNumber.text) && (double.parse(_controllerTrophyNumber.text) <= _maxTrophy || _maxTrophy == 0)) {
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
        if (!_manuallySetTrophyRating) _getTrophyRating();
      } else if (controller == 1) {
        if (_equalsDoubleWeightNumber.hasMatch(_controllerWeightNumber.text) && (double.parse(_controllerWeightNumber.text) <= _maxWeight || _maxWeight == 0)) {
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
    _logger.v("Getting animals");
    _animals.clear();
    _dropDownListAnimals.clear();
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
    _dropDownListAnimals.addAll(_listOfAnimals());
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
    _logger.v("Selected animal NUM $_selectedAnimal with ID $_selectedAnimalId");
    if (widget.log == null) _getTrophyLodgeRecords();
  }

  void _getFursData() {
    _logger.v("Getting furs");
    _furs.clear();
    _dropDownListAnimalFurs.clear();
    for (AnimalFur animalFur in HelperJSON.animalsFurs) {
      if (animalFur.animalId == _selectedAnimalId) {
        if ((!animalFur.male && !animalFur.female) || (animalFur.male && _isMale) || (animalFur.female && !_isMale)) {
          _furs.add(animalFur);
        }
      }
    }
    _furs.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
    _dropDownListAnimalFurs.addAll(_listOfFurs());
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
    _logger.v("Selected fur NUM $_selectedFur with ID $_selectedFurId");
  }

  void _getTrophyRating() {
    if (_trophy >= _diamond) {
      _trophyRating = 4;
    } else if (_trophy >= _gold) {
      _trophyRating = 3;
    } else if (_trophy >= _silver) {
      _trophyRating = 2;
    } else if (_trophy > 0) {
      _trophyRating = 1;
    } else {
      _trophyRating = 0;
    }
    if (_selectedFurId == Interface.greatOneId) {
      _trophyRating = 4; //GREAT ONE ADJUSTMENT
    }
    if (widget.log != null) {
      _trophyRating = widget.log!.getTrophyRating(HelperJSON.getAnimal(_selectedAnimalId), true);
      if (_trophyRating == 5) _trophyRating = 4; //GREAT ONE
    }
  }

  void _getTrophyOf(Animal animal) {
    _silver = animal.silver;
    _gold = animal.gold;
    _diamond = animal.diamond;
    if (_selectedFurId == Interface.greatOneId) {
      //GREAT ONE
      _maxTrophy = animal.trophyGO;
      _maxWeight = animal.getWeightGOWithoutUnits(_usesImperials);
    } else {
      _maxTrophy = animal.trophy;
      _maxWeight = animal.getWeightWithoutUnits(_usesImperials);
    }
  }

  void _getTrophyLodgeRecords() {
    _trophyLodgeRecords.clear();
    for (Log log in HelperLog.logs) {
      if (log.animalId == _selectedAnimalId && log.isInLodge) _trophyLodgeRecords.add(log);
    }
    _trophyLodgeRecords.sort((a, b) => b.trophy.compareTo(a.trophy));
    _logger.v("Found ${_trophyLodgeRecords.length} trophy lodge record/s with this animal");
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
              child: AutoSizeText(HelperJSON.reserves[index].getName(context.locale),
                  maxLines: 1,
                  style: TextStyle(
                    color: Interface.dark,
                    fontSize: Interface.s20,
                    fontWeight: FontWeight.w400,
                  )))));
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
              child: AutoSizeText(_animals[index].getNameBasedOnReserve(context.locale, _selectedReserveId),
                  maxLines: 1,
                  style: TextStyle(
                    color: Interface.dark,
                    fontSize: Interface.s20,
                    fontWeight: FontWeight.w400,
                  )))));
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
              child: AutoSizeText(_furs[index].getName(context.locale),
                  maxLines: 1,
                  style: TextStyle(
                    color: Interface.dark,
                    fontSize: Interface.s20,
                    fontWeight: FontWeight.w400,
                  )))));
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

  void _isTrophyCorrect() {
    if (_trophy < _diamond && _selectedFurId == Interface.greatOneId) {
      _trophy = _diamond;
    }
    if (widget.fromTrophyLodge) {
      _correctAmmoUsed = true;
      _twoShotsFired = true;
      _vitalOrganHit = true;
      _trophyOrganUndamaged = true;
      if (_trophy >= _diamond) {
        if (_trophyRating < 4) {
          _trophyRating = 3;
          _correctAmmoUsed = false;
          _twoShotsFired = false;
          _vitalOrganHit = false;
          _trophyOrganUndamaged = false;
        }
      } else if (_trophy >= _gold) {
        if (_trophyRating > 3) {
          _trophyRating = 3;
        } else if (_trophyRating < 3) {
          _trophyRating = 2;
          _correctAmmoUsed = false;
          _twoShotsFired = false;
          _vitalOrganHit = false;
          _trophyOrganUndamaged = false;
        }
      } else if (_trophy >= _silver) {
        if (_trophyRating > 2) {
          _trophyRating = 2;
        } else if (_trophyRating < 2) {
          _trophyRating = 1;
          _correctAmmoUsed = false;
          _twoShotsFired = false;
          _vitalOrganHit = false;
          _trophyOrganUndamaged = false;
        }
      } else if (_trophy > 0) {
        if (_trophyRating > 1) {
          _trophyRating = 1;
        } else if (_trophyRating < 1) {
          _trophyRating = 0;
          _correctAmmoUsed = false;
          _twoShotsFired = false;
          _vitalOrganHit = false;
          _trophyOrganUndamaged = false;
        }
      } else {
        _correctAmmoUsed = false;
        _twoShotsFired = false;
        _vitalOrganHit = false;
        _trophyOrganUndamaged = false;
      }
    }
  }

  Log _createLog() => Log(
        id: widget.log == null ? HelperLog.logs.length : widget.log!.id,
        date: HelperLog.getDate(_dateTime),
        reserveId: widget.fromTrophyLodge ? -1 : _selectedReserveId,
        animalId: _selectedAnimalId,
        furId: _selectedFurId,
        trophy: _trophy,
        weight: _weight,
        imperials: _usesImperials ? 1 : 0,
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
                primaryColor: Interface.dark.withOpacity(.3),
                backgroundColor: Interface.subTitleBackground,
                calendarTextColor: Interface.dark,
                buttonTextColor: Interface.dark,
                timeSpinnerTextStyle: TextStyle(
                  color: Interface.dark,
                  fontSize: Interface.s18,
                  fontWeight: FontWeight.w400,
                ),
                timeSpinnerHighlightedTextStyle: TextStyle(
                  color: Interface.dark,
                  fontSize: Interface.s22,
                  fontWeight: FontWeight.w400,
                ),
                is24HourMode: true,
                isShowSeconds: false,
                startInitialDate: _dateTime,
                startFirstDate: DateTime(2017),
                startLastDate: DateTime(2030, 12, 31),
                borderRadius: const Radius.circular(10),
              )) ??
              _dateTime;
          setState(() {});
        },
        child: Container(
            height: 70,
            color: Interface.subTitleBackground,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
              AutoSizeText(
                tr('time').toUpperCase(),
                maxLines: 1,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Interface.title,
                  fontSize: Interface.s24,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Title',
                ),
              ),
              AutoSizeText(HelperLog.getDateFormatted(_dateTime),
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Interface.title,
                    fontSize: Interface.s20,
                    fontWeight: FontWeight.w400,
                  ))
            ])));
  }

  Widget _buildReserve() {
    return Column(children: [
      WidgetTitle(text: tr('reserve')),
      DropdownButton(
        dropdownColor: Interface.dropDownBody,
        underline: Container(),
        icon: Container(),
        elevation: 0,
        itemHeight: 60,
        isExpanded: true,
        value: _selectedReserve,
        onChanged: (dynamic value) {
          setState(() {
            _selectedReserve = value;
            _reserveChanged = true;
            _focus();
          });
        },
        items: _listOfReserves(),
      )
    ]);
  }

  Widget _buildAnimal() {
    return Column(children: [
      WidgetTitle(text: tr('animal')),
      DropdownButton(
          dropdownColor: Interface.dropDownBody,
          underline: Container(),
          icon: Container(),
          elevation: 0,
          itemHeight: 60,
          isExpanded: true,
          value: _selectedAnimal,
          onChanged: (dynamic value) {
            setState(() {
              _selectedAnimal = value;
              _animalChanged = true;
              _focus();
            });
          },
          items: _listOfAnimals())
    ]);
  }

  Widget _buildFur() {
    return Column(children: [
      WidgetTitle(text: tr('animal_fur')),
      DropdownButton(
          dropdownColor: Interface.dropDownBody,
          underline: Container(),
          icon: Container(),
          elevation: 0,
          itemHeight: 60,
          isExpanded: true,
          value: _selectedFur,
          onChanged: (dynamic value) {
            setState(() {
              _selectedFur = value;
              _furChanged = true;
              _focus();
            });
          },
          items: _listOfFurs())
    ]);
  }

  Widget _buildGender() {
    return Column(children: [
      WidgetTitleFunctional.withSwitch(
          text: tr('animal_gender'),
          icon: "assets/graphics/icons/male.svg",
          inactiveIcon: "assets/graphics/icons/female.svg",
          textColor: Interface.title,
          background: Interface.subTitleBackground,
          iconColor: Interface.alwaysDark,
          buttonBackground: Interface.male,
          iconInactiveColor: Interface.alwaysDark,
          buttonInactiveBackground: Interface.female,
          isTitle: true,
          isActive: _isMale,
          onTap: () {
            setState(() {
              _isMale = !_isMale;
              _genderChanged = true;
              _focus();
            });
          })
    ]);
  }

  Widget _buildTrophy() {
    _textTrophyAndWeightListener(0);
    return Column(children: [
      widget.log != null
          ? WidgetTitle(
              text: tr('animal_trophy'),
              subText: "${tr('max')}: ${_maxTrophy == 0 ? "?" : _maxTrophy.toString()}",
              textColor: Interface.title,
              subTextColor: Interface.title,
              background: Interface.subTitleBackground,
            )
          : WidgetTitleFunctional.withButton(
              text: tr('animal_trophy'),
              subText: "${tr('max')}: ${_maxTrophy == 0 ? "?" : _maxTrophy.toString()}",
              icon: "assets/graphics/icons/list.svg",
              textColor: Interface.title,
              subTextColor: Interface.title,
              background: Interface.subTitleBackground,
              iconColor: Interface.accent,
              buttonBackground: Interface.primary,
              isTitle: true,
              onTap: () {
                setState(() {
                  _recordsOpened = true;
                });
              }),
      WidgetTextField(
        correct: _correctTrophyNumber,
        controller: _controllerTrophyNumber,
        color: Interface.title,
        background: Interface.subSubTitleBackground,
      )
    ]);
  }

  Widget _buildWeight() {
    _textTrophyAndWeightListener(1);
    return Column(children: [
      WidgetTitle(
          text: tr('animal_weight'),
          subText: "${tr('max')}: ${_maxWeight == 0 ? "?" : _maxWeight.toString()}",
          textColor: Interface.title,
          subTextColor: Interface.title,
          background: Interface.subTitleBackground),
      WidgetTextField(
        correct: _correctWeightNumber,
        controller: _controllerWeightNumber,
        color: Interface.title,
        background: Interface.subSubTitleBackground,
      )
    ]);
  }

  Widget _buildHarvestCheck() {
    return Column(children: [
      WidgetTitle(
        text: tr('harvest_check'),
      ),
      Container(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
            WidgetSwitch.withIcon(
              activeIcon: "assets/graphics/icons/harvest_correct_ammo.svg",
              inactiveIcon: "assets/graphics/icons/harvest_correct_ammo.svg",
              activeColor: Interface.accent,
              activeBackground: Interface.primary,
              inactiveColor: Interface.disabled,
              inactiveBackground: Interface.disabled.withOpacity(0.3),
              isActive: _correctAmmoUsed,
              onTap: () {
                setState(() {
                  _correctAmmoUsed = !_correctAmmoUsed;
                  _focus();
                });
              },
            ),
            WidgetSwitch.withIcon(
                activeIcon: "assets/graphics/icons/harvest_two_shots.svg",
                inactiveIcon: "assets/graphics/icons/harvest_two_shots.svg",
                activeColor: Interface.accent,
                activeBackground: Interface.primary,
                inactiveColor: Interface.disabled,
                inactiveBackground: Interface.disabled.withOpacity(0.3),
                isActive: _twoShotsFired,
                onTap: () {
                  setState(() {
                    _twoShotsFired = !_twoShotsFired;
                    _focus();
                  });
                }),
            WidgetSwitch.withIcon(
                activeIcon: "assets/graphics/icons/harvest_no_trophy_organ.svg",
                inactiveIcon: "assets/graphics/icons/harvest_no_trophy_organ.svg",
                activeColor: Interface.accent,
                activeBackground: Interface.primary,
                inactiveColor: Interface.disabled,
                inactiveBackground: Interface.disabled.withOpacity(0.3),
                isActive: _trophyOrganUndamaged,
                onTap: () {
                  setState(() {
                    _trophyOrganUndamaged = !_trophyOrganUndamaged;
                    _focus();
                  });
                }),
            WidgetSwitch.withIcon(
                activeIcon: "assets/graphics/icons/harvest_vital_organ.svg",
                inactiveIcon: "assets/graphics/icons/harvest_vital_organ.svg",
                activeColor: Interface.accent,
                activeBackground: Interface.primary,
                inactiveColor: Interface.disabled,
                inactiveBackground: Interface.disabled.withOpacity(0.3),
                isActive: _vitalOrganHit,
                onTap: () {
                  setState(() {
                    _vitalOrganHit = !_vitalOrganHit;
                    _focus();
                  });
                })
          ]))
    ]);
  }

  Widget _buildTrophyRating() {
    return Column(children: [
      WidgetTitle(
        text: tr('trophy_rating'),
      ),
      Container(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
            WidgetSwitch.withIcon(
                activeIcon: "assets/graphics/icons/trophy_none.svg",
                inactiveIcon: "assets/graphics/icons/trophy_none.svg",
                activeColor: Interface.light,
                activeBackground: Interface.trophyNoneBackground,
                inactiveColor: Interface.disabled,
                inactiveBackground: Interface.disabled.withOpacity(0.3),
                isActive: _trophyRating == 0,
                onTap: () {
                  setState(() {
                    _manuallySetTrophyRating = true;
                    _trophyRating = 0;
                    _focus();
                  });
                }),
            WidgetSwitch.withIcon(
                activeIcon: "assets/graphics/icons/trophy_bronze.svg",
                inactiveIcon: "assets/graphics/icons/trophy_bronze.svg",
                activeColor: Interface.alwaysDark,
                activeBackground: Interface.trophyBronzeBackground,
                inactiveColor: Interface.disabled,
                inactiveBackground: Interface.disabled.withOpacity(0.3),
                isActive: _trophyRating == 1,
                onTap: () {
                  setState(() {
                    _manuallySetTrophyRating = true;
                    _trophyRating = 1;
                    _focus();
                  });
                }),
            WidgetSwitch.withIcon(
                activeIcon: "assets/graphics/icons/trophy_silver.svg",
                inactiveIcon: "assets/graphics/icons/trophy_silver.svg",
                activeColor: Interface.alwaysDark,
                activeBackground: Interface.trophySilverBackground,
                inactiveColor: Interface.disabled,
                inactiveBackground: Interface.disabled.withOpacity(0.3),
                isActive: _trophyRating == 2,
                onTap: () {
                  setState(() {
                    _manuallySetTrophyRating = true;
                    _trophyRating = 2;
                    _focus();
                  });
                }),
            WidgetSwitch.withIcon(
                activeIcon: "assets/graphics/icons/trophy_gold.svg",
                inactiveIcon: "assets/graphics/icons/trophy_gold.svg",
                activeColor: Interface.alwaysDark,
                activeBackground: Interface.trophyGoldBackground,
                inactiveColor: Interface.disabled,
                inactiveBackground: Interface.disabled.withOpacity(0.3),
                isActive: _trophyRating == 3,
                onTap: () {
                  setState(() {
                    _manuallySetTrophyRating = true;
                    _trophyRating = 3;
                    _focus();
                  });
                }),
            WidgetSwitch.withIcon(
                activeIcon: _selectedFurId == Interface.greatOneId ? "assets/graphics/icons/trophy_great_one.svg" : "assets/graphics/icons/trophy_diamond.svg",
                inactiveIcon: _selectedFurId == Interface.greatOneId ? "assets/graphics/icons/trophy_great_one.svg" : "assets/graphics/icons/trophy_diamond.svg",
                activeColor: Interface.alwaysDark,
                activeBackground: Interface.trophyDiamondBackground,
                inactiveColor: Interface.disabled,
                inactiveBackground: Interface.disabled.withOpacity(0.3),
                isActive: _trophyRating == 4,
                onTap: () {
                  setState(() {
                    _manuallySetTrophyRating = true;
                    _trophyRating = 4;
                    _focus();
                  });
                })
          ]))
    ]);
  }

  Widget _buildAdd() {
    return GestureDetector(
        onTap: () {
          _focus();
          _isTrophyCorrect();
          Log log = _createLog();
          widget.log != null ? HelperLog.editLog(log) : HelperLog.addLog(log);
          widget.callback();
          Navigator.pop(context);
        },
        child: Container(
            height: 90,
            alignment: Alignment.center,
            color: Interface.primary,
            child: SvgPicture.asset(
              widget.log != null ? "assets/graphics/icons/edit.svg" : "assets/graphics/icons/plus.svg",
              height: 20,
              width: 20,
              color: Interface.accent,
            )));
  }

  Widget _buildRecords() {
    return AnimatedPositioned(
        top: 0,
        left: _recordsOpened ? 0 : MediaQuery.of(context).size.width,
        duration: const Duration(milliseconds: 200),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Interface.mainBody,
            child: Column(children: [
              WidgetTitleFunctional.withButton(
                  isTitle: true,
                  text: tr('trophy_lodge'),
                  icon: "assets/graphics/icons/menu_close.svg",
                  textColor: Interface.title,
                  background: Interface.subTitleBackground,
                  iconColor: Interface.title,
                  buttonBackground: Colors.transparent,
                  onTap: () {
                    setState(() {
                      _recordsOpened = false;
                    });
                  }),
              Expanded(
                  child: WidgetScrollbar(
                      child: SingleChildScrollView(
                          child: Column(children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _trophyLodgeRecords.length,
                    itemBuilder: (context, index) {
                      return EntryTrophyLodgeRecord(log: _trophyLodgeRecords[index], index: index);
                    })
              ]))))
            ])));
  }

  Widget _buildWidgets() {
    return WidgetScaffold.withCustomBody(
        body: Stack(fit: StackFit.expand, children: [
      WidgetScrollbar(
          child: SingleChildScrollView(
              child: Column(children: [
        WidgetAppBar(
          text: widget.log != null ? tr('edit') : tr('add'),
          fontSize: Interface.s30,
          context: context,
        ),
        _buildDate(),
        widget.fromTrophyLodge ? const SizedBox.shrink() : _buildReserve(),
        _buildAnimal(),
        _buildGender(),
        _buildFur(),
        _buildTrophy(),
        widget.fromTrophyLodge ? const SizedBox.shrink() : _buildWeight(),
        widget.fromTrophyLodge ? _buildTrophyRating() : _buildHarvestCheck(),
        _buildAdd(),
      ]))),
      widget.log != null ? const SizedBox.shrink() : _buildRecords(),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    _reload();
    return _buildWidgets();
  }
}
