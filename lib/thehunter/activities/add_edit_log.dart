// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_log.dart';
import 'package:cotwcompanion/helpers/helper_logger.dart';
import 'package:cotwcompanion/helpers/helper_settings.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/model/animal_fur.dart';
import 'package:cotwcompanion/thehunter/model/fur.dart';
import 'package:cotwcompanion/thehunter/model/idtoid.dart';
import 'package:cotwcompanion/thehunter/model/log.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_name_with.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_name_with_subtext.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_container.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold_advanced.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_switch.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_textfield.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/title.dart';
import 'package:cotwcompanion/thehunter/widgets/record.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';

class ActivityLogsAddEdit extends StatefulWidget {
  final int animalID;
  final int reserveID;
  final Function callback;
  final Map<String, dynamic> toEdit;
  final bool fromTrophyLodge;

  const ActivityLogsAddEdit(
      {Key? key, this.animalID = -1, this.reserveID = -1, required this.fromTrophyLodge, required this.callback, this.toEdit = const {}})
      : super(key: key);

  @override
  ActivityLogsAddEditState createState() => ActivityLogsAddEditState();
}

class ActivityLogsAddEditState extends State<ActivityLogsAddEdit> {
  DateTime _dateTime = DateTime.now();

  int _minute = DateTime.now().minute;
  int _hour = DateTime.now().hour;
  int _day = DateTime.now().day;
  int _month = DateTime.now().month;
  int _year = DateTime.now().year;

  late final Settings _settings;
  late final List<Animal> _animals = [];
  late final List<AnimalFur> _furs = [];
  late final List<Log> _trophyLodgeRecords = [];
  late final List<DropdownMenuItem> _dropDownListAnimals = [];
  late final List<DropdownMenuItem> _dropDownListAnimalFurs = [];
  late final List<DropdownMenuItem> _dropDownListReserves = [];

  final HelperLogger logger = HelperLogger("[LOGS] [ADD & EDIT]");
  final _controllerTrophyNumber = TextEditingController();
  final _controllerWeightNumber = TextEditingController();
  final _equalsDoubleTrophyNumber = RegExp(r'^([0-9]){1,4}(\.{1}[0-9]{1,3})?$');
  final _equalsDoubleWeightNumber = RegExp(r'^([0-9]){1,4}(\.{1}[0-9]{1,3})?$');
  final List<int> _animalsIDs = [];
  final List<int> _fursIDs = [];

  bool _initialization = true;
  bool _editing = false;
  bool _fromOtherSource = false;
  bool _recordsOpened = false;

  bool _reserveChanged = false;
  bool _animalChanged = false;
  bool _genderChanged = false;
  bool _furChanged = false;

  int _logID = 0;
  bool _correctTrophyNumber = true;
  bool _correctWeightNumber = true;
  bool _manuallySetTrophyRating = false;
  bool _gender = true;
  bool _imperials = false;
  bool _correctAmmunition = true;
  bool _maxTwoShots = true;
  bool _vitalOrgan = true;
  bool _noTrophyOrgan = true;
  double _silver = 0;
  double _gold = 0;
  double _diamond = 0;
  double _trophy = 0;
  double _weight = 0;
  double _maxTrophy = 0;
  double _maxWeight = 0;
  int _lodge = 0;
  int _trophyRating = 0;
  int _selectedAnimal = 0;
  int _selectedAnimalID = 0;
  int _selectedReserve = 0;
  int _selectedReserveID = 0;
  int _selectedFur = 0;
  int _selectedFurID = 0;

  @override
  void initState() {
    _settings = Provider.of<Settings>(context, listen: false);
    _imperials = _settings.getImperialUnits;
    _controllerTrophyNumber.addListener(() => _textTrophyAndWeightListener(0));
    _controllerWeightNumber.addListener(() => _textTrophyAndWeightListener(1));
    super.initState();
  }

  _getData() {
    if (_initialization) {
      if (widget.animalID > -1 && widget.reserveID > -1) {
        //WHEN CREATING RECORD FROM RESERVE'S ANIMAL LIST OR FROM NEED ZONES FEATURE
        _selectedReserveID = widget.reserveID;
        _selectedReserve = _selectedReserveID - 1;
        _selectedAnimalID = widget.animalID;
        _fromOtherSource = true;
      } else if (widget.toEdit.isNotEmpty) {
        //WHEN EDITING RECORD
        _logID = widget.toEdit["id"];
        _gender = widget.toEdit["gender"];
        _imperials = widget.toEdit["imperials"];
        _lodge = widget.toEdit["lodge"];
        _correctAmmunition = widget.toEdit["correctAmmunition"];
        _maxTwoShots = widget.toEdit["maxTwoShots"];
        _vitalOrgan = widget.toEdit["vitalOrgan"];
        _noTrophyOrgan = widget.toEdit["noTrophyOrgan"];
        _trophy = widget.toEdit["trophy"];
        _weight = widget.toEdit["weight"];
        _selectedReserveID = widget.toEdit["reserveID"];
        _selectedReserve = widget.toEdit["reserveID"] - 1;
        _selectedAnimalID = widget.toEdit["animalID"];
        _selectedFurID = widget.toEdit["furID"];
        _dateTime = _getDateTime(widget.toEdit["date"]);
        _controllerTrophyNumber.text = _trophy.toString().split(".")[1] == "0" ? _trophy.toString().split(".")[0] : _trophy.toString();
        _controllerWeightNumber.text = _weight.toString().split(".")[1] == "0" ? _weight.toString().split(".")[0] : _weight.toString();
        _editing = true;
      } else {
        //OTHERWISE
        _dropDownListReserves.clear();
        _dropDownListReserves.addAll(_listOfReserves());
        _selectedReserveID = JSONHelper.getReserve(_selectedReserve + 1).getID;
        _getAnimalsData();
        _getAnimal(false, false);
        _getFursData();
        _getFur(false, false);
      }
      _initialization = false;
    }

    if (_fromOtherSource) {
      logger.i("Creating log from other source");
      _getAnimalsData();
      _getAnimal(true, false);
      _getFursData();
      _getFur(false, true);
      _fromOtherSource = false;
    } else if (_editing) {
      logger.i("Editing log");
      _getAnimalsData();
      _getAnimal(true, false);
      _getFursData();
      _getFur(true, false);
      _getTrophyRating();
      _editing = false;
    } else if (_reserveChanged) {
      logger.i("Reserve changed");
      _selectedReserveID = JSONHelper.getReserve(_selectedReserve + 1).getID;
      _getAnimalsData();
      _getAnimal(false, true);
      _getFursData();
      _getFur(false, true);
      _reserveChanged = false;
    } else if (_animalChanged) {
      logger.i("Animal changed");
      _getAnimal(false, false);
      _getFursData();
      _getFur(false, true);
      _animalChanged = false;
    } else if (_furChanged) {
      logger.i("Fur changed");
      _getFur(false, false);
      _furChanged = false;
    } else if (_genderChanged) {
      logger.i("Gender changed");
      _getFursData();
      _getFur(false, true);
      _genderChanged = false;
    }
    _getTrophyOf(_animals.elementAt(_selectedAnimal));
  }

  _textTrophyAndWeightListener(int controller) {
    setState(() {
      if (controller == 0) {
        if (_equalsDoubleTrophyNumber.hasMatch(_controllerTrophyNumber.text) &&
            (double.parse(_controllerTrophyNumber.text) <= _maxTrophy || _maxTrophy == 0)) {
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
        if (_equalsDoubleWeightNumber.hasMatch(_controllerWeightNumber.text) &&
            (double.parse(_controllerWeightNumber.text) <= _maxWeight || _maxWeight == 0)) {
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

  _getAnimalsData() {
    logger.v("Getting animals");
    _dropDownListAnimals.clear();
    _dropDownListAnimals.addAll(_listOfAnimals());
    _animals.clear();
    _animalsIDs.clear();
    if (widget.fromTrophyLodge) {
      _animals.addAll(JSONHelper.animals);
    } else {
      for (IDtoID iti in JSONHelper.animalsReserves) {
        if (iti.getSecondID == _selectedReserveID) {
          for (Animal a in JSONHelper.animals) {
            if (iti.getFirstID == a.getID) {
              _animals.add(a);
              break;
            }
          }
        }
      }
    }
    _animals.sort(
        (a, b) => a.getNameBasedOnReserve(context.locale, _selectedReserveID).compareTo(b.getNameBasedOnReserve(context.locale, _selectedReserveID)));
    for (Animal a in _animals) {
      _animalsIDs.add(a.getID);
    }
  }

  _getAnimal(bool hasSource, bool needToBeInitialized) {
    if (hasSource) {
      if (_animalsIDs.contains(_selectedAnimalID)) {
        _selectedAnimal = _animalsIDs.indexOf(_selectedAnimalID);
      } else {
        _selectedAnimal = 0;
        _selectedAnimalID = _animalsIDs.elementAt(_selectedAnimal);
      }
    } else if (needToBeInitialized) {
      _selectedAnimal = 0;
      _selectedAnimalID = _animalsIDs.elementAt(_selectedAnimal);
    } else {
      _selectedAnimalID = _animalsIDs.elementAt(_selectedAnimal);
    }
    logger.v("Selected animal NUM $_selectedAnimal with ID $_selectedAnimalID");
    if (widget.toEdit.isEmpty) _getTrophyLodgeRecords();
  }

  _getFursData() {
    logger.v("Getting furs");
    _dropDownListAnimalFurs.clear();
    _dropDownListAnimalFurs.addAll(_listOfFurs());
    _furs.clear();
    _fursIDs.clear();
    for (AnimalFur af in JSONHelper.animalsFurs) {
      if (af.getAnimalID == _selectedAnimalID) {
        for (Fur f in JSONHelper.furs) {
          if (af.getFurID == f.getID && ((!af.getMale && !af.getFemale) || (af.getMale && _gender) || (af.getFemale && !_gender))) {
            _furs.add(af);
            break;
          }
        }
      }
    }
    _furs.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
    for (AnimalFur af in _furs) {
      _fursIDs.add(af.getFurID);
    }
  }

  _getFur(bool hasSource, bool needToBeInitialized) {
    if (hasSource) {
      if (_fursIDs.contains(_selectedFurID)) {
        _selectedFur = _fursIDs.indexOf(_selectedFurID);
      } else {
        _selectedFur = 0;
        _selectedFurID = _fursIDs.elementAt(_selectedFur);
      }
    } else if (needToBeInitialized) {
      _selectedFur = 0;
      _selectedFurID = _fursIDs.elementAt(_selectedFur);
    } else {
      _selectedFurID = _fursIDs.elementAt(_selectedFur);
    }
    logger.v("Selected fur NUM $_selectedFur with ID $_selectedFurID");
  }

  _getTrophyRating() {
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
    if (_selectedFurID == Values.greatOneID) {
      _trophyRating = 4; //GREAT ONE ADJUSTMENT
    }
    if (widget.toEdit.isNotEmpty) {
      _trophyRating = widget.toEdit["trophyRating"];
      if (_trophyRating == 5) _trophyRating = 4; //GREAT ONE ADJUSTMENT
    }
  }

  _getTrophyOf(Animal a) {
    _silver = a.getSilver;
    _gold = a.getGold;
    _diamond = a.getDiamond;
    if (_selectedFurID == Values.greatOneID) {
      //GREAT ONE ADJUSTMENT
      _maxTrophy = a.getTrophyGO;
      _maxWeight = a.getWeightGOWithoutUnits(_settings.getImperialUnits);
    } else {
      _maxTrophy = a.getTrophy;
      _maxWeight = a.getWeightWithoutUnits(_settings.getImperialUnits);
    }
  }

  _getTrophyLodgeRecords() {
    _trophyLodgeRecords.clear();
    for (Log l in LogHelper.logs) {
      if (l.getAnimalID == _selectedAnimalID && l.getLodge) _trophyLodgeRecords.add(l);
    }
    _trophyLodgeRecords.sort((a, b) => b.getTrophy.compareTo(a.getTrophy));
    logger.v("Found ${_trophyLodgeRecords.length} trophy lodge record/s with this animal");
  }

  List<DropdownMenuItem> _listOfReserves() {
    List<DropdownMenuItem> dropItems = [];
    for (int i = 0; i < JSONHelper.reserves.length; i++) {
      dropItems.add(DropdownMenuItem(
          value: i,
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 50,
              padding: const EdgeInsets.only(left: 30, right: 30),
              alignment: Alignment.centerLeft,
              child: AutoSizeText(JSONHelper.getReserve(i + 1).getName(context.locale),
                  maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)))));
    }
    return dropItems;
  }

  List<DropdownMenuItem> _listOfAnimals() {
    List<DropdownMenuItem> dropItems = [];
    for (int i = 0; i < _animals.length; i++) {
      dropItems.add(DropdownMenuItem(
          value: i,
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 50,
              padding: const EdgeInsets.only(left: 30, right: 30),
              alignment: Alignment.centerLeft,
              child: AutoSizeText(_animals[i].getNameBasedOnReserve(context.locale, _selectedReserveID),
                  maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)))));
    }
    return dropItems;
  }

  List<DropdownMenuItem> _listOfFurs() {
    List<DropdownMenuItem> dropItems = [];
    for (int i = 0; i < _furs.length; i++) {
      dropItems.add(DropdownMenuItem(
          value: i,
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 50,
              padding: const EdgeInsets.only(left: 30, right: 30),
              alignment: Alignment.centerLeft,
              child: AutoSizeText(_furs[i].getName(context.locale),
                  maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)))));
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

  _focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  _check() {
    if (_trophy < _diamond && _selectedFurID == Values.greatOneID) {
      _trophy = _diamond;
    }
    if (widget.fromTrophyLodge) {
      _correctAmmunition = true;
      _maxTwoShots = true;
      _vitalOrgan = true;
      _noTrophyOrgan = true;
      if (_trophy >= _diamond) {
        if (_trophyRating < 4) {
          _trophyRating = 3;
          _correctAmmunition = false;
          _maxTwoShots = false;
          _vitalOrgan = false;
          _noTrophyOrgan = false;
        }
      } else if (_trophy >= _gold) {
        if (_trophyRating > 3) {
          _trophyRating = 3;
        } else if (_trophyRating < 3) {
          _trophyRating = 2;
          _correctAmmunition = false;
          _maxTwoShots = false;
          _vitalOrgan = false;
          _noTrophyOrgan = false;
        }
      } else if (_trophy >= _silver) {
        if (_trophyRating > 2) {
          _trophyRating = 2;
        } else if (_trophyRating < 2) {
          _trophyRating = 1;
          _correctAmmunition = false;
          _maxTwoShots = false;
          _vitalOrgan = false;
          _noTrophyOrgan = false;
        }
      } else if (_trophy > 0) {
        if (_trophyRating > 1) {
          _trophyRating = 1;
        } else if (_trophyRating < 1) {
          _trophyRating = 0;
          _correctAmmunition = false;
          _maxTwoShots = false;
          _vitalOrgan = false;
          _noTrophyOrgan = false;
        }
      } else {
        _correctAmmunition = false;
        _maxTwoShots = false;
        _vitalOrgan = false;
        _noTrophyOrgan = false;
      }
    }
  }

  Log _createLog() => Log(
      id: widget.toEdit.isEmpty ? LogHelper.logs.length : _logID,
      date: LogHelper.getDate(_dateTime),
      reserveID: widget.fromTrophyLodge ? -1 : _selectedReserveID,
      animalID: _selectedAnimalID,
      furID: _selectedFurID,
      trophy: _trophy,
      weight: _weight,
      imperials: _imperials ? 1 : 0,
      lodge: widget.fromTrophyLodge ? 1 : _lodge,
      gender: _gender ? 1 : 0,
      harvestCorrectAmmo: _correctAmmunition ? 1 : 0,
      harvestTwoShots: _maxTwoShots ? 1 : 0,
      harvestVitalOrgan: _vitalOrgan ? 1 : 0,
      harvestNoTrophyOrgan: _noTrophyOrgan ? 1 : 0);

  Widget _buildDate() {
    return GestureDetector(
        onTap: () async {
          _focus();
          _dateTime = (await showOmniDateTimePicker(
                context: context,
                primaryColor: Color(Values.colorDark).withOpacity(.3),
                backgroundColor: Color(Values.colorContentSubTitleBackground),
                calendarTextColor: Color(Values.colorDark),
                buttonTextColor: Color(Values.colorDark),
                timeSpinnerTextStyle: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize18, fontWeight: FontWeight.w400),
                timeSpinnerHighlightedTextStyle: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize22, fontWeight: FontWeight.w400),
                is24HourMode: true,
                isShowSeconds: false,
                startInitialDate: _dateTime,
                startFirstDate: DateTime(2017),
                startLastDate: DateTime(2022, 12, 31),
                borderRadius: const Radius.circular(10),
              )) ??
              _dateTime;
          setState(() {});
        },
        child: Container(
            height: 70,
            color: Color(Values.colorContentSubTitleBackground),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
              AutoSizeText(
                tr('time'),
                maxLines: 1,
                textAlign: TextAlign.start,
                style: TextStyle(color: Color(Values.colorContentSubTitle), fontSize: Values.fontSize24, fontWeight: FontWeight.w600),
              ),
              AutoSizeText(LogHelper.getDateFormatted(_dateTime),
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Color(Values.colorContentSubTitle), fontSize: Values.fontSize20, fontWeight: FontWeight.w400))
            ])));
  }

  Widget _buildReserve() {
    return Column(children: [
      WidgetTitle.sub(text: tr('reserve')),
      DropdownButton(
          dropdownColor: Color(Values.colorDropDownBackground),
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
          items: _listOfReserves())
    ]);
  }

  Widget _buildAnimal() {
    return Column(children: [
      WidgetTitle.sub(text: tr('animal')),
      DropdownButton(
          dropdownColor: Color(Values.colorDropDownBackground),
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
      WidgetTitle.sub(text: tr('animal_fur')),
      DropdownButton(
          dropdownColor: Color(Values.colorDropDownBackground),
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
      EntryName.withSwitch(
          text: tr('animal_gender'),
          color: Values.colorContentSubTitle,
          background: Values.colorContentSubTitleBackground,
          size: 40,
          buttonIcon: "assets/graphics/icons/male.svg",
          buttonInactiveIcon: "assets/graphics/icons/female.svg",
          buttonActiveColor: Values.colorAlwaysDark,
          buttonActiveBackground: Values.colorMale,
          buttonInactiveColor: Values.colorAlwaysDark,
          buttonInactiveBackground: Values.colorFemale,
          noInactiveOpacity: true,
          isActive: _gender,
          onTap: () {
            setState(() {
              _gender = !_gender;
              _genderChanged = true;
              _focus();
            });
          })
    ]);
  }

  Widget _buildTrophy() {
    _textTrophyAndWeightListener(0);
    return Column(children: [
      widget.toEdit.isNotEmpty
          ? EntryNameWithSubtext(
              text: tr('animal_trophy'),
              subText: "${tr('max')}: ${_maxTrophy == 0 ? "?" : _maxTrophy.toString()}",
              color: Values.colorContentSubTitle,
              background: Values.colorContentSubTitleBackground)
          : EntryName.withTap(
              text: tr('animal_trophy'),
              subText: "${tr('max')}: ${_maxTrophy == 0 ? "?" : _maxTrophy.toString()}",
              buttonIcon: "assets/graphics/icons/list.svg",
              size: 40,
              color: Values.colorContentSubTitle,
              background: Values.colorContentSubTitleBackground,
              buttonActiveColor: Values.colorAccent,
              buttonActiveBackground: Values.colorPrimary,
              onTap: () {
                setState(() {
                  _recordsOpened = true;
                });
              }),
      WidgetTextField(numberOnly: true, correct: _correctTrophyNumber, controller: _controllerTrophyNumber)
    ]);
  }

  Widget _buildWeight() {
    _textTrophyAndWeightListener(1);
    return Column(children: [
      EntryNameWithSubtext(
          text: tr('animal_weight'), subText: "${tr('max')}: ${_maxWeight == 0 ? "?" : _maxWeight.toString()}", color: Values.colorContentSubTitle, background: Values.colorContentSubTitleBackground),
      WidgetTextField(numberOnly: true, correct: _correctWeightNumber, controller: _controllerWeightNumber)
    ]);
  }

  Widget _buildHarvestCheck() {
    return Column(children: [
      WidgetTitle.sub(text: tr('harvest_check')),
      WidgetContainer(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
            WidgetSwitch(
                icon: "assets/graphics/icons/harvest_correct_ammo.svg",
                size: 40,
                activeColor: Values.colorAccent,
                activeBackground: Values.colorPrimary,
                isActive: _correctAmmunition,
                onTap: () {
                  setState(() {
                    _correctAmmunition = !_correctAmmunition;
                    _focus();
                  });
                }),
            WidgetSwitch(
                icon: "assets/graphics/icons/harvest_two_shots.svg",
                size: 40,
                activeColor: Values.colorAccent,
                activeBackground: Values.colorPrimary,
                isActive: _maxTwoShots,
                onTap: () {
                  setState(() {
                    _maxTwoShots = !_maxTwoShots;
                    _focus();
                  });
                }),
            WidgetSwitch(
                icon: "assets/graphics/icons/harvest_no_trophy_organ.svg",
                size: 40,
                activeColor: Values.colorAccent,
                activeBackground: Values.colorPrimary,
                isActive: _noTrophyOrgan,
                onTap: () {
                  setState(() {
                    _noTrophyOrgan = !_noTrophyOrgan;
                    _focus();
                  });
                }),
            WidgetSwitch(
                icon: "assets/graphics/icons/harvest_vital_organ.svg",
                size: 40,
                activeColor: Values.colorAccent,
                activeBackground: Values.colorPrimary,
                isActive: _vitalOrgan,
                onTap: () {
                  setState(() {
                    _vitalOrgan = !_vitalOrgan;
                    _focus();
                  });
                })
          ]))
    ]);
  }

  Widget _buildTrophyRating() {
    return Column(children: [
      WidgetTitle.sub(text: tr('trophy_rating')),
      WidgetContainer(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
            WidgetSwitch(
                icon: "assets/graphics/icons/trophy_none.svg",
                size: 40,
                activeColor: Values.colorLight,
                activeBackground: Values.colorSwitchTrophyNoneBackground,
                isActive: _trophyRating == 0,
                onTap: () {
                  setState(() {
                    _manuallySetTrophyRating = true;
                    _trophyRating = 0;
                    _focus();
                  });
                }),
            WidgetSwitch(
                icon: "assets/graphics/icons/trophy_bronze.svg",
                size: 40,
                activeColor: Values.colorAlwaysDark,
                activeBackground: Values.colorSwitchTrophyBronzeBackground,
                isActive: _trophyRating == 1,
                onTap: () {
                  setState(() {
                    _manuallySetTrophyRating = true;
                    _trophyRating = 1;
                    _focus();
                  });
                }),
            WidgetSwitch(
                icon: "assets/graphics/icons/trophy_silver.svg",
                size: 40,
                activeColor: Values.colorAlwaysDark,
                activeBackground: Values.colorSwitchTrophySilverBackground,
                isActive: _trophyRating == 2,
                onTap: () {
                  setState(() {
                    _manuallySetTrophyRating = true;
                    _trophyRating = 2;
                    _focus();
                  });
                }),
            WidgetSwitch(
                icon: "assets/graphics/icons/trophy_gold.svg",
                size: 40,
                activeColor: Values.colorAlwaysDark,
                activeBackground: Values.colorSwitchTrophyGoldBackground,
                isActive: _trophyRating == 3,
                onTap: () {
                  setState(() {
                    _manuallySetTrophyRating = true;
                    _trophyRating = 3;
                    _focus();
                  });
                }),
            WidgetSwitch(
                icon: _selectedFurID == Values.greatOneID ? "assets/graphics/icons/trophy_great_one.svg" : "assets/graphics/icons/trophy_diamond.svg",
                size: 40,
                activeColor: Values.colorAlwaysDark,
                activeBackground: Values.colorSwitchTrophyDiamondBackground,
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
          _check();
          Log log = _createLog();
          widget.toEdit.isEmpty ? LogHelper.addLog(log) : LogHelper.editLog(log);
          widget.callback();
          Navigator.pop(context);
        },
        child: Container(
            height: 90,
            alignment: Alignment.center,
            color: Color(Values.colorPrimary),
            child: SvgPicture.asset(widget.toEdit.isEmpty ? "assets/graphics/icons/plus.svg" : "assets/graphics/icons/edit.svg",
                height: 20, width: 20, color: Color(Values.colorAccent))));
  }

  Widget _buildRecords() {
    return AnimatedPositioned(
        top: 0,
        left: _recordsOpened ? 0 : MediaQuery.of(context).size.width,
        duration: const Duration(milliseconds: 200),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(Values.colorBody),
            child: Column(children: [
              EntryName.withTap(
                  text: tr('trophy_lodge'),
                  buttonIcon: "assets/graphics/icons/menu_close.svg",
                  color: Values.colorContentSubTitle,
                  background: Values.colorContentSubTitleBackground,
                  buttonActiveColor: Values.colorContentSubTitle,
                  buttonActiveBackground: Values.colorTransparent,
                  onTap: () {
                    setState(() {
                      _recordsOpened = false;
                    });
                  }),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _trophyLodgeRecords.length,
                    itemBuilder: (context, index) {
                      return EntryRecord(log: _trophyLodgeRecords[index], index: index);
                    })
              ])))
            ])));
  }

  Widget _buildWidgets() {
    return WidgetScaffoldAdvanced(
        body: Column(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          child: Container(
              color: Color(Values.colorBody),
              child: Stack(fit: StackFit.expand, children: [
                SingleChildScrollView(
                    child: Column(children: [
                  WidgetAppBar(
                    text: widget.toEdit.isEmpty ? tr('add') : tr('edit'),
                    height: 90,
                    fontSize: Values.fontSize30,
                    fontWeight: FontWeight.w700,
                    alignment: Alignment.centerRight,
                    function: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildDate(),
                  widget.fromTrophyLodge ? Container() : _buildReserve(),
                  _buildAnimal(),
                  _buildGender(),
                  _buildFur(),
                  _buildTrophy(),
                  widget.fromTrophyLodge ? Container() : _buildWeight(),
                  widget.fromTrophyLodge ? _buildTrophyRating() : _buildHarvestCheck(),
                  _buildAdd()
                ])),
                widget.toEdit.isNotEmpty ? Container() : _buildRecords()
              ])))
    ]));
  }

  @override
  Widget build(BuildContext context) {
    _getData();
    return _buildWidgets();
  }
}
