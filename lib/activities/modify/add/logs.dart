import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:collection/collection.dart';
import 'package:cotwcompanion/activities/modify/modify.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/helpers/log.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/lists/logs/modify/harvest_check.dart';
import 'package:cotwcompanion/lists/logs/modify/trophy_lodge_logs.dart';
import 'package:cotwcompanion/lists/logs/modify/trophy_rating.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/model/connect/animal_fur.dart';
import 'package:cotwcompanion/model/exportable/log.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/handling/drop_down.dart';
import 'package:cotwcompanion/widgets/handling/drop_down_item.dart';
import 'package:cotwcompanion/widgets/handling/drop_down_item_fur.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:cotwcompanion/widgets/text/text_field_indicator.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:cotwcompanion/widgets/title/title_button_icon.dart';
import 'package:cotwcompanion/widgets/title/title_switch_icon.dart';
import 'package:cotwcompanion/widgets/title/title_tap.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityAddLogs extends ActivityModify {
  final BuildContext _context;

  const ActivityAddLogs({
    super.key,
    super.type = ModifyType.add,
    required BuildContext context,
    required super.onSuccess,
  }) : _context = context;

  BuildContext get context => _context;

  @override
  State<StatefulWidget> createState() => ActivityAddLogsState();
}

class ActivityAddLogsState extends ActivityModifyState {
  Reserve? get selectedReserve => reserveValueListenable.value;

  Animal get selectedAnimal => animalValueListenable.value;

  AnimalFur get selectedAnimalFur => animalFurValueListenable.value;

  final RegExp rxDouble = RegExp(r"^\d{1,4}([.,]\d{0,3})?$");
  final TextEditingController trophyController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  late final ValueNotifier<Reserve?> reserveValueListenable;
  late final ValueNotifier<Animal> animalValueListenable;
  late final ValueNotifier<AnimalFur> animalFurValueListenable;

  DateTime dateTime = DateTime.now();

  int trophyRating = 0;
  double trophy = 0;
  double weight = 0;
  bool isMale = true;
  bool correctAmmo = true;
  bool twoShots = true;
  bool vitalOrgan = true;
  bool trophyOrgan = true;

  bool correctTrophy = true;
  bool correctWeight = true;

  bool get usesImperials => Provider.of<Settings>(context, listen: false).imperialUnits;

  List<Reserve> get reserves => HelperJSON.reserves.sorted(Reserve.sortById);

  List<Animal> get reserveAnimals => selectedReserve == null
      ? HelperJSON.animals.sorted(Animal.sortByNameByLocale((widget as ActivityAddLogs).context))
      : HelperJSON.getReserveAnimals(selectedReserve!.id)
          .sorted(Animal.sortByNameByReserve((widget as ActivityAddLogs).context, selectedReserve));

  List<AnimalFur> get animalFurs =>
      HelperJSON.getAnimalFursWithGender(selectedAnimal.id, isMale, !isMale).sorted(AnimalFur.sortByRarityFurName);

  List<Log> get trophyLodgeLogs => HelperLog.logs.where((e) => e.animal == selectedAnimal && e.lodge).toList();

  @override
  void initState() {
    initializeData();
    trophyController.addListener(() => _trophyListener());
    weightController.addListener(() => _weightListener());
    super.initState();
  }

  @override
  void dispose() {
    weightController.dispose();
    trophyController.dispose();
    super.dispose();
  }

  void initializeData() {
    reserveValueListenable = ValueNotifier(reserves.first);
    animalValueListenable = ValueNotifier(reserveAnimals.first);
    animalFurValueListenable = ValueNotifier(animalFurs.first);
  }

  void _updateData(Change change) {
    setState(() {
      switch (change) {
        case Change.reserve:
          animalValueListenable.value = reserveAnimals.first;
          animalFurValueListenable.value = animalFurs.first;
        case Change.animal:
          animalFurValueListenable.value = animalFurs.first;
        case Change.gender:
          animalFurValueListenable.value = animalFurs.first;
        case Change.fur:
          break;
        case Change.other:
          break;
      }
    });
  }

  void _focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
  }

  void _trophyListener() {
    setState(() {
      if (rxDouble.hasMatch(trophyController.text)) {
        correctTrophy = true;
        trophy = double.parse(trophyController.text.replaceAll(",", "."));
      } else {
        if (trophyController.text.isEmpty) {
          trophyController.clear();
          correctTrophy = true;
          trophy = 0;
        } else {
          trophyController.clear();
          correctTrophy = false;
          trophy = 0;
        }
      }
    });
  }

  void _weightListener() {
    setState(() {
      if (rxDouble.hasMatch(weightController.text)) {
        correctWeight = true;
        weight = double.parse(weightController.text.replaceAll(",", "."));
      } else {
        if (weightController.text.isEmpty) {
          weightController.clear();
          correctWeight = true;
          weight = 0;
        } else {
          weightController.clear();
          correctWeight = false;
          weight = 0;
        }
      }
    });
  }

  Widget _buildDatePickerConfirm(Function onClose) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: WidgetButtonIcon(
        Assets.graphics.icons.accept,
        onTap: () {
          onClose();
        },
      ),
    );
  }

  Future<DateTime?> _buildDatePicker() async {
    return await showBoardDateTimePicker(
      context: context,
      useSafeArea: true,
      radius: 0,
      options: Interface.boardDatePickerOptions(context),
      customCloseButtonBuilder: (context, isModal, onClose) => _buildDatePickerConfirm(onClose),
      initialDate: dateTime,
      minimumDate: DateTime(2017),
      maximumDate: DateTime(2030, 12, 31),
      pickerType: DateTimePickerType.datetime,
    );
  }

  Widget _buildDate() {
    return WidgetTitleTap(
      tr("TIME"),
      content: WidgetText(
        Utils.dateTimeAs(DateStructure.format, dateTime),
        color: Interface.dark,
        style: Style.normal.s16.w300,
      ),
      onTap: () async {
        dateTime = await _buildDatePicker() ?? dateTime;
        _updateData(Change.other);
      },
    );
  }

  DropdownItem<Reserve> _buildReserveItem(Reserve reserve) {
    return DropdownItem<Reserve>(
      value: reserve,
      child: WidgetDropDownItem(
        text: reserve.name,
      ),
    );
  }

  List<DropdownItem<Reserve>> _listReserves() {
    return reserves.map((e) => _buildReserveItem(e)).toList();
  }

  List<Widget> _listReserve() {
    return [
      WidgetTitleSwitchIcon(
        tr("RESERVE"),
        icon: Assets.graphics.icons.reserveUnknown,
        activeIcon: Assets.graphics.icons.reserveKnown,
        buttonColor: Interface.alwaysDark,
        buttonBackground: Interface.red,
        activeButtonColor: Interface.alwaysDark,
        activeButtonBackground: Interface.green,
        isActive: selectedReserve == null,
        alignRight: true,
        onTap: () {
          setState(() {
            if (selectedReserve == null) {
              if (widget.type == ModifyType.edit) {
                reserveValueListenable.value = HelperJSON.getAnimalReserves(selectedAnimal).first;
              } else {
                reserveValueListenable.value = reserves.first;
              }
            } else {
              reserveValueListenable.value = null;
            }
            if (widget.type == ModifyType.add) _updateData(Change.reserve);
          });
        },
      ),
      if (selectedReserve != null)
        WidgetDropDown<Reserve?>(
          valueListenable: reserveValueListenable,
          items: _listReserves(),
          onChange: (Reserve? value) {
            reserveValueListenable.value = value;
            _updateData(Change.reserve);
          },
        ),
      if (selectedReserve == null) WidgetDropDownItem(text: tr("UNKNOWN")),
    ];
  }

  DropdownItem<Animal> _buildAnimalItem(Animal animal) {
    return DropdownItem<Animal>(
      value: animal,
      child: WidgetDropDownItem(text: animal.name),
    );
  }

  List<DropdownItem<Animal>> _listAnimals() {
    return reserveAnimals.map((e) => _buildAnimalItem(e)).toList();
  }

  List<Widget> _listAnimal() {
    return [
      WidgetTitle(tr("ANIMAL")),
      WidgetDropDown<Animal>(
        valueListenable: animalValueListenable,
        items: _listAnimals(),
        onChange: (Animal value) {
          animalValueListenable.value = value;
          _updateData(Change.animal);
        },
      ),
    ];
  }

  Widget _buildGender() {
    return WidgetTitleSwitchIcon(
      tr("ANIMAL_GENDER"),
      icon: Assets.graphics.icons.genderFemale,
      buttonColor: Interface.alwaysDark,
      buttonBackground: Interface.red,
      activeIcon: Assets.graphics.icons.genderMale,
      activeButtonColor: Interface.alwaysDark,
      activeButtonBackground: Interface.blue,
      alignRight: true,
      isActive: isMale,
      onTap: () {
        isMale = !isMale;
        _focus();
        _updateData(Change.gender);
      },
    );
  }

  DropdownItem<AnimalFur> _buildAnimalFurItem(AnimalFur animalFur) {
    return DropdownItem<AnimalFur>(
      value: animalFur,
      child: WidgetDropDownItemFur(
        text: animalFur.furName,
        color: animalFur.rarity.color,
      ),
    );
  }

  List<DropdownItem<AnimalFur>> _listAnimalFurs() {
    return animalFurs.map((e) => _buildAnimalFurItem(e)).toList();
  }

  List<Widget> _listFur() {
    return [
      WidgetTitle(tr("ANIMAL_FUR")),
      WidgetDropDown<AnimalFur>(
        valueListenable: animalFurValueListenable,
        items: _listAnimalFurs(),
        onChange: (AnimalFur value) {
          animalFurValueListenable.value = value;
          _updateData(Change.fur);
        },
      ),
    ];
  }

  List<Widget> _listTrophy() {
    return [
      WidgetTitleButtonIcon(
        tr("ANIMAL_TROPHY"),
        icon: Assets.graphics.icons.menuOpen,
        alignRight: true,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (e) => ListTrophyLodgeLogs(trophyLodgeLogs),
            ),
          );
        },
      ),
      WidgetTextFieldIndicator(
        icon: Assets.graphics.icons.trophyDiamond,
        correct: correctTrophy,
        textController: trophyController,
      ),
    ];
  }

  List<Widget> _listWeight() {
    return [
      WidgetTitle(tr("ANIMAL_WEIGHT")),
      WidgetTextFieldIndicator(
        icon: Assets.graphics.icons.weight,
        correct: correctWeight,
        textController: weightController,
      ),
    ];
  }

  List<Widget> _listTrophyRating() {
    return [
      WidgetTitle(tr("TROPHY_RATING")),
      ListTrophyRating(
        trophyRating: trophyRating,
        selectedFur: selectedAnimalFur,
        trophyRatingChanged: (int rating) {
          trophyRating = rating;
          setState(() {});
        },
      ),
    ];
  }

  List<Widget> _listHarvestCheck() {
    return [
      WidgetTitle(tr("HARVEST_CHECK")),
      ListHarvestCheck(
        correctAmmo: correctAmmo,
        twoShots: twoShots,
        trophyOrgan: trophyOrgan,
        vitalOrgan: vitalOrgan,
        correctAmmoChanged: () {
          correctAmmo = !correctAmmo;
          setState(() {});
        },
        twoShotsChanged: () {
          twoShots = !twoShots;
          setState(() {});
        },
        trophyOrganChanged: () {
          trophyOrgan = !trophyOrgan;
          setState(() {});
        },
        vitalOrganChanged: () {
          vitalOrgan = !vitalOrgan;
          setState(() {});
        },
      ),
    ];
  }

  Log get _newLog {
    return Log.create(
      dateTime,
      selectedAnimal,
      selectedReserve,
      selectedAnimalFur,
      trophyRating,
      trophy,
      weight,
      usesImperials,
      false,
      isMale,
      correctAmmo,
      twoShots,
      vitalOrgan,
      trophyOrgan,
      false,
    );
  }

  void onSuccess() {
    HelperLog.save(_newLog);
  }

  @override
  void onConfirm() {
    onSuccess();
    widget.onSuccess();
    Navigator.pop(context);
  }

  @override
  Widget buildBody() {
    return Column(
      children: [
        _buildDate(),
        ..._listReserve(),
        ..._listAnimal(),
        _buildGender(),
        ..._listFur(),
        ..._listWeight(),
        ..._listTrophy(),
        ..._listTrophyRating(),
        ..._listHarvestCheck(),
      ],
    );
  }
}
