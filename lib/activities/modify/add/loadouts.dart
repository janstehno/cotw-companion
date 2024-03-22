import 'package:collection/collection.dart';
import 'package:cotwcompanion/activities/modify/modify.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/helpers/loadout.dart';
import 'package:cotwcompanion/lists/loadouts/modify/loadouts_ammo.dart';
import 'package:cotwcompanion/lists/loadouts/modify/loadouts_callers.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/model/connect/weapon_ammo.dart';
import 'package:cotwcompanion/model/exportable/loadout.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/text/text_indicator.dart';
import 'package:cotwcompanion/widgets/title/title_button_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityAddLoadouts extends ActivityModify {
  const ActivityAddLoadouts({
    super.key,
    super.type = ModifyType.add,
    required super.onSuccess,
  });

  @override
  State<StatefulWidget> createState() => ActivityAddLoadoutsState();
}

class ActivityAddLoadoutsState extends ActivityModifyState {
  final TextEditingController textController = TextEditingController();

  final Set<WeaponAmmo> selectedAmmo = {};
  final Set<Caller> selectedCallers = {};

  @override
  void initState() {
    textController.addListener(() => updateIndicatorOf(textController));
    super.initState();
  }

  void _updateAmmo(List<WeaponAmmo> ammo) {
    setState(() {
      selectedAmmo.clear();
      selectedAmmo.addAll(ammo);
    });
  }

  void _updateCallers(List<Caller> callers) {
    setState(() {
      selectedCallers.clear();
      selectedCallers.addAll(callers);
    });
  }

  Widget _buildAmmo(int i, WeaponAmmo weaponAmmo) {
    Ammo? ammo = HelperJSON.getAmmo(weaponAmmo.ammoId);
    return WidgetTextIndicator(
      ammo!.name,
      isShown: ammo.isFromDlc,
    );
  }

  List<Widget> _listAmmo() {
    return selectedAmmo.sorted(WeaponAmmo.sortByAmmoName).mapIndexed((i, ammo) => _buildAmmo(i, ammo)).toList();
  }

  Widget _buildCaller(int i, Caller caller) {
    return WidgetTextIndicator(
      caller.name,
      isShown: caller.isFromDlc,
    );
  }

  List<Widget> _listCallers() {
    return selectedCallers.sorted(Caller.sortByName).mapIndexed((i, caller) => _buildCaller(i, caller)).toList();
  }

  Widget _buildAmmoButton() {
    return WidgetTitleButtonIcon(
      tr("WEAPONS"),
      icon: Assets.graphics.icons.edit,
      alignRight: true,
      onTap: () {
        focus();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (e) => ListLoadoutAmmo(selected: selectedAmmo, onSelect: _updateAmmo),
          ),
        );
      },
    );
  }

  Widget _buildCallerButton() {
    return WidgetTitleButtonIcon(
      tr("CALLERS"),
      icon: Assets.graphics.icons.edit,
      alignRight: true,
      onTap: () {
        focus();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (e) => ListLoadoutCallers(selected: selectedCallers, onSelect: _updateCallers),
          ),
        );
      },
    );
  }

  Widget _buildWeaponsCallers() {
    return Column(
      children: [
        _buildAmmoButton(),
        if (selectedAmmo.isNotEmpty)
          WidgetPadding.h30v20(
            child: Column(children: _listAmmo()),
          ),
        _buildCallerButton(),
        if (selectedCallers.isNotEmpty)
          WidgetPadding.h30v20(
            child: Column(children: _listCallers()),
          ),
      ],
    );
  }

  Loadout get _newLoadout {
    return Loadout.create(
      textController.text,
      selectedAmmo,
      selectedCallers,
    );
  }

  void onSuccess() {
    HelperLoadout.save(_newLoadout);
  }

  @override
  void onConfirm() {
    if (errorMessage.isEmpty) {
      onSuccess();
      widget.onSuccess();
      Navigator.pop(context);
    } else {
      Utils.buildSnackBarMessage(
        errorMessage,
        Process.error,
        context,
      );
    }
  }

  @override
  Widget buildBody() {
    return Column(
      children: [
        buildName(correctName, textController),
        _buildWeaponsCallers(),
      ],
    );
  }
}
